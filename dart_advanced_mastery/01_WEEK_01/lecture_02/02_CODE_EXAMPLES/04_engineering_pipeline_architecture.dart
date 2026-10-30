/// ==============================================================================
/// File: 04_engineering_pipeline_architecture.dart
/// Educational Objective: Build a resilient, type-safe, functional data transformation
/// pipeline implementing middleware chains, interceptors, and error handling.
///
/// Execution:
///   dart run 04_engineering_pipeline_architecture.dart
/// ==============================================================================

/// Context carrier passed through pipeline stages
class ExecutionContext<T> {
  final T data;
  final Map<String, dynamic> metadata;
  final List<String> auditLogs;

  ExecutionContext({
    required this.data,
    Map<String, dynamic>? metadata,
    List<String>? auditLogs,
  })  : metadata = metadata ?? <String, dynamic>{},
        auditLogs = auditLogs ?? <String>[];

  ExecutionContext<R> copyWithData<R>(R newData, String stageDescription) {
    final updatedLogs = List<String>.from(auditLogs)..add('[$stageDescription] -> Processed successfully');
    return ExecutionContext<R>(
      data: newData,
      metadata: Map<String, dynamic>.from(metadata),
      auditLogs: updatedLogs,
    );
  }
}

/// A functional stage that accepts context and returns a new context
typedef PipelineStage<In, Out> = ExecutionContext<Out> Function(ExecutionContext<In> context);

/// Composable Pipeline Engine
class PipelineEngine {
  /// Higher-Order Wrapper adding logging, latency profiling, and error boundary to any stage
  static PipelineStage<In, Out> withTelemetry<In, Out>(
    String stageName,
    Out Function(In input) transformFn,
  ) {
    return (ExecutionContext<In> ctx) {
      final stopwatch = Stopwatch()..start();
      try {
        final transformed = transformFn(ctx.data);
        stopwatch.stop();

        final nextContext = ctx.copyWithData(transformed, stageName);
        nextContext.metadata['${stageName}_duration_micros'] = stopwatch.elapsedMicroseconds;
        return nextContext;
      } catch (error, stackTrace) {
        stopwatch.stop();
        print('CRITICAL FAILURE in Pipeline Stage [$stageName] after ${stopwatch.elapsedMicroseconds}µs');
        print('Error: $error\n$stackTrace');
        rethrow;
      }
    };
  }
}

void main() {
  print('=== INDUSTRIAL PIPELINE ARCHITECTURE IN DART ===\n');

  // Stage 1: Trim raw input string
  final stage1 = PipelineEngine.withTelemetry<String, String>(
    'TrimWhitespace',
    (input) => input.trim(),
  );

  // Stage 2: Parse to Integer
  final stage2 = PipelineEngine.withTelemetry<String, int>(
    'ParseInteger',
    (input) => int.parse(input),
  );

  // Stage 3: Apply Tax Calculation (e.g., 14% VAT)
  final stage3 = PipelineEngine.withTelemetry<int, double>(
    'ApplyVatTax',
    (amount) => amount * 1.14,
  );

  // Executing pipeline on raw external input
  final initialContext = ExecutionContext<String>(
    data: '   5000   ',
    metadata: {'source': 'REST_PAYLOAD_GATEWAY'},
  );

  print('Starting Pipeline Execution...');
  final step1 = stage1(initialContext);
  final step2 = stage2(step1);
  final step3 = stage3(step2);

  print('\n=== FINAL PIPELINE EXECUTION REPORT ===');
  print('Final Processed Data: \$${step3.data.toStringAsFixed(2)}');
  print('Telemetry Metadata: ${step3.metadata}');
  print('Audit Trail:');
  for (final log in step3.auditLogs) {
    print('  * $log');
  }
}
