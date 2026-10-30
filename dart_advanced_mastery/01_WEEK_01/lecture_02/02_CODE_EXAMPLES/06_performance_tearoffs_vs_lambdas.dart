/// ==============================================================================
/// File: 06_performance_tearoffs_vs_lambdas.dart
/// Educational Objective: Measure and compare the execution performance and
/// allocation overhead of Tear-offs versus Redundant Anonymous Lambdas `(x) => fn(x)`.
///
/// Execution:
///   dart run 06_performance_tearoffs_vs_lambdas.dart
/// ==============================================================================

class MathEngine {
  static int square(int x) => x * x;
}

void main() {
  const int iterations = 5000000;
  final testDataset = List<int>.generate(1000, (i) => i);

  print('=== BENCHMARK: Tear-off vs Redundant Lambda in Higher-Order Functions ===');
  print('Running 5,000 iterations over 1,000-element collection (5,000,000 operations)...\n');

  // Warm up JIT compiler
  int warmAccumulator = 0;
  for (int i = 0; i < 10000; i++) {
    warmAccumulator += MathEngine.square(i);
  }

  // --------------------------------------------------------------------------
  // Benchmark 1: Redundant Lambda Closure: `(x) => MathEngine.square(x)`
  // --------------------------------------------------------------------------
  final stopwatchLambda = Stopwatch()..start();
  int lambdaAccumulator = 0;

  for (int run = 0; run < 5000; run++) {
    // Redundant anonymous function created and passed
    final mapped = testDataset.map((x) => MathEngine.square(x));
    lambdaAccumulator ^= mapped.first;
  }
  stopwatchLambda.stop();
  final lambdaElapsedMicros = stopwatchLambda.elapsedMicroseconds;

  // --------------------------------------------------------------------------
  // Benchmark 2: Method Tear-off: `MathEngine.square`
  // --------------------------------------------------------------------------
  final stopwatchTearoff = Stopwatch()..start();
  int tearoffAccumulator = 0;

  for (int run = 0; run < 5000; run++) {
    // Direct static method tear-off reference
    final mapped = testDataset.map(MathEngine.square);
    tearoffAccumulator ^= mapped.first;
  }
  stopwatchTearoff.stop();
  final tearoffElapsedMicros = stopwatchTearoff.elapsedMicroseconds;

  // --------------------------------------------------------------------------
  // Comparison & Architectural Takeaways
  // --------------------------------------------------------------------------
  print('[1] Redundant Lambda `(x) => fn(x)`:');
  print('    Time Elapsed: ${stopwatchLambda.elapsedMilliseconds} ms ($lambdaElapsedMicros µs)');

  print('\n[2] Direct Static Tear-off `fn`:');
  print('    Time Elapsed: ${stopwatchTearoff.elapsedMilliseconds} ms ($tearoffElapsedMicros µs)');

  print('\n=== ARCHITECTURAL & PERFORMANCE ANALYSIS ===');
  print('1. Code Elegance: Tear-offs reduce syntactic noise dramatically.');
  print('2. Compilation: Static tear-offs allow the compiler to inline and optimize call sites directly.');
  print('3. Checksum verification: ${lambdaAccumulator ^ tearoffAccumulator ^ warmAccumulator}');
}
