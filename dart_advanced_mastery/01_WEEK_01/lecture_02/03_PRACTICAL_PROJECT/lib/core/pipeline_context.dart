/// Immutable execution context passed through the transformation pipeline.
class PipelineContext<T> {
  final T payload;
  final Map<String, dynamic> metadata;
  final List<String> stageHistory;

  const PipelineContext({
    required this.payload,
    this.metadata = const <String, dynamic>{},
    this.stageHistory = const <String>[],
  });

  /// Factory constructor to create an initial context
  factory PipelineContext.initial(T initialPayload, {Map<String, dynamic>? initialMetadata}) {
    return PipelineContext(
      payload: initialPayload,
      metadata: Map<String, dynamic>.unmodifiable(initialMetadata ?? {}),
      stageHistory: const <String>[],
    );
  }

  /// Produces a new context holding transformed data of type `R` with updated history
  PipelineContext<R> transform<R>(
    R nextPayload, {
    required String stageName,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final mergedMetadata = Map<String, dynamic>.from(metadata);
    if (additionalMetadata != null) {
      mergedMetadata.addAll(additionalMetadata);
    }

    final updatedHistory = List<String>.from(stageHistory)..add(stageName);

    return PipelineContext<R>(
      payload: nextPayload,
      metadata: Map<String, dynamic>.unmodifiable(mergedMetadata),
      stageHistory: List<String>.unmodifiable(updatedHistory),
    );
  }

  @override
  String toString() => 'PipelineContext(payload: $payload, stages: ${stageHistory.join(" -> ")})';
}
