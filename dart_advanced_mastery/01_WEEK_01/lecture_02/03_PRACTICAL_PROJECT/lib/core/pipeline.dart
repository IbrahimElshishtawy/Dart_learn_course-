import 'pipeline_context.dart';

/// Represents a single asynchronous or synchronous transformation stage
typedef Stage<In, Out> = PipelineContext<Out> Function(PipelineContext<In> context);

/// Middleware Interceptor wrapping a stage with cross-cutting concerns
typedef Middleware<In, Out> = Stage<In, Out> Function(Stage<In, Out> nextStage);

/// Fluent Composable Data Pipeline Builder
class Pipeline<In, Out> {
  final Stage<In, Out> _entryStage;

  const Pipeline._(this._entryStage);

  /// Creates a starting identity pipeline
  static Pipeline<T, T> start<T>() {
    return Pipeline._((context) => context);
  }

  /// Appends a new stage transforming type `Out` to type `Next`
  Pipeline<In, Next> pipe<Next>(
    String stageName,
    Next Function(Out payload) transformFn, {
    List<Middleware<Out, Next>> middleware = const [],
  }) {
    Stage<Out, Next> rawStage = (context) {
      final transformed = transformFn(context.payload);
      return context.transform(transformed, stageName: stageName);
    };

    // Apply middleware in reverse order to ensure correct execution envelope
    for (final mw in middleware.reversed) {
      rawStage = mw(rawStage);
    }

    return Pipeline<In, Next>._((context) {
      final intermediate = _entryStage(context);
      return rawStage(intermediate);
    });
  }

  /// Executes the compiled pipeline against an initial input payload
  PipelineContext<Out> execute(In input, {Map<String, dynamic>? initialMetadata}) {
    final initialContext = PipelineContext<In>.initial(input, initialMetadata: initialMetadata);
    return _entryStage(initialContext);
  }

  // Built-in Telemetry Middleware Generator (Closure capturing stageName)
  static Middleware<A, B> telemetryMiddleware<A, B>(String stageName) {
    return (Stage<A, B> nextStage) {
      return (PipelineContext<A> context) {
        final stopwatch = Stopwatch()..start();
        final resultContext = nextStage(context);
        stopwatch.stop();

        return resultContext.transform(
          resultContext.payload,
          stageName: '$stageName:telemetry',
          additionalMetadata: {
            '${stageName}_duration_micros': stopwatch.elapsedMicroseconds,
          },
        );
      };
    };
  }
}
