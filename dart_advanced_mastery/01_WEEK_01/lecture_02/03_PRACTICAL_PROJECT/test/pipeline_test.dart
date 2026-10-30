import 'package:test/test.dart';
import '../lib/core/pipeline.dart';
import '../lib/stages/enrichment_stages.dart';
import '../lib/stages/sanitization_stages.dart';

void main() {
  group('Flexible Data Transformation Pipeline Tests', () {
    test('Identity pipeline preserves input payload', () {
      final pipeline = Pipeline.start<String>();
      final context = pipeline.execute('test_input');
      expect(context.payload, equals('test_input'));
      expect(context.stageHistory, isEmpty);
    });

    test('Chaining transformation stages produces correct output and history', () {
      final pipeline = Pipeline.start<String>()
          .pipe<String>('Trim', SanitizationStages.trim)
          .pipe<int>('Parse', SanitizationStages.parsePositiveInt)
          .pipe<double>('Multiply', (n) => n * 2.0);

      final result = pipeline.execute('   42   ');
      expect(result.payload, equals(84.0));
      expect(result.stageHistory, equals(['Trim', 'Parse', 'Multiply']));
    });

    test('Telemetry middleware attaches stage duration accurately', () {
      final pipeline = Pipeline.start<String>().pipe<String>(
        'Trim',
        SanitizationStages.trim,
        middleware: [Pipeline.telemetryMiddleware('Trim')],
      );

      final result = pipeline.execute('   data   ');
      expect(result.payload, equals('data'));
      expect(result.metadata.containsKey('Trim_duration_micros'), isTrue);
    });

    test('Throws FormatException on non-positive or invalid integer parsing', () {
      final pipeline = Pipeline.start<String>()
          .pipe<int>('Parse', SanitizationStages.parsePositiveInt);

      expect(() => pipeline.execute('-50'), throwsFormatException);
      expect(() => pipeline.execute('abc'), throwsFormatException);
    });

    test('Closure-based VAT calculation produces exact output', () {
      final vatCalculator = EnrichmentStages.createVatCalculator(10.0);
      expect(vatCalculator(100), equals(10.0));
      expect(vatCalculator(250), equals(25.0));
    });
  });
}
