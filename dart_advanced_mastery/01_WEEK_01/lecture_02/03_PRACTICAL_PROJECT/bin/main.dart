import '../lib/core/pipeline.dart';
import '../lib/stages/enrichment_stages.dart';
import '../lib/stages/sanitization_stages.dart';

void main() {
  print('================================================================');
  print('  FLEXIBLE DATA TRANSFORMATION PIPELINE — LIVE EXECUTION');
  print('================================================================\n');

  // Build the pipeline using fluent syntax and Tear-offs
  final pipeline = Pipeline.start<String>()
      // Stage 1: Trim whitespaces via static method tear-off
      .pipe<String>(
        'Sanitization:Trim',
        SanitizationStages.trim,
        middleware: [Pipeline.telemetryMiddleware('Sanitization:Trim')],
      )
      // Stage 2: Parse integer string to primitive int
      .pipe<int>(
        'Parser:PositiveInt',
        SanitizationStages.parsePositiveInt,
        middleware: [Pipeline.telemetryMiddleware('Parser:PositiveInt')],
      )
      // Stage 3: Enrich with VAT and package into EnrichedTransaction entity
      .pipe<EnrichedTransaction>(
        'Enrichment:PackageVAT',
        (amount) {
          final vatCalculator = EnrichmentStages.createVatCalculator(14.0); // 14% Egyptian VAT
          final vat = vatCalculator(amount);
          return EnrichmentStages.packageTransaction(amount: amount, vat: vat);
        },
        middleware: [Pipeline.telemetryMiddleware('Enrichment:PackageVAT')],
      );

  // Ingest batch of diverse raw inputs
  final rawInputs = <String>[
    '   1500   ',
    '  8200 ',
    '45000',
  ];

  for (final raw in rawInputs) {
    print('----------------------------------------------------------------');
    print('Processing Raw Input: "$raw"');

    final resultContext = pipeline.execute(raw, initialMetadata: {'source': 'BATCH_IMPORT_JOB'});

    print('Output Payload : ${resultContext.payload}');
    print('Stage History  : ${resultContext.stageHistory.join(" -> ")}');
    print('Metadata Audit : ${resultContext.metadata}\n');
  }

  print('================================================================');
  print('  ALL BATCH PIPELINE RUNS COMPLETED SUCCESSFULLY.');
  print('================================================================');
}
