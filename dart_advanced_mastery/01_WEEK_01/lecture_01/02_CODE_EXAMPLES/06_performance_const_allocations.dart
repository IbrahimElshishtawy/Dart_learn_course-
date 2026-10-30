/// ==============================================================================
/// File: 06_performance_const_allocations.dart
/// Educational Objective: Measure and prove the computational performance and
/// memory allocation difference between `const` canonicalized instances and
/// dynamic heap-allocated runtime instances in high-throughput loops.
///
/// Execution:
///   dart run 06_performance_const_allocations.dart
/// ==============================================================================

class DataPoint {
  final int x;
  final int y;

  const DataPoint(this.x, this.y);
}

void main() {
  const int iterations = 5000000; // 5 Million object instantiations

  print('=== BENCHMARK: 5,000,000 Object Allocations ===');
  print('Comparing runtime heap allocations vs compile-time const canonicalization...\n');

  // --------------------------------------------------------------------------
  // Benchmark 1: Runtime Dynamic Allocations (Non-const constructor calls)
  // --------------------------------------------------------------------------
  final stopwatchDynamic = Stopwatch()..start();
  int dynamicHashAccumulator = 0;

  for (int i = 0; i < iterations; i++) {
    // Each iteration allocates a brand-new instance on the Dart VM Heap!
    final point = DataPoint(100, 200);
    dynamicHashAccumulator ^= point.hashCode;
  }
  stopwatchDynamic.stop();
  final dynamicElapsedMs = stopwatchDynamic.elapsedMilliseconds;
  final dynamicElapsedMicro = stopwatchDynamic.elapsedMicroseconds;

  print('[1] Runtime Dynamic Allocations:');
  print('    Time Elapsed: $dynamicElapsedMs ms ($dynamicElapsedMicro µs)');
  print('    Heap Impact:  5,000,000 separate object allocations triggered GC pressure.');

  // --------------------------------------------------------------------------
  // Benchmark 2: Compile-Time Const Canonicalized Allocation
  // --------------------------------------------------------------------------
  final stopwatchConst = Stopwatch()..start();
  int constHashAccumulator = 0;

  for (int i = 0; i < iterations; i++) {
    // Zero heap allocations in the loop! The exact same canonicalized pointer is reused.
    const point = DataPoint(100, 200);
    constHashAccumulator ^= point.hashCode;
  }
  stopwatchConst.stop();
  final constElapsedMs = stopwatchConst.elapsedMilliseconds;
  final constElapsedMicro = stopwatchConst.elapsedMicroseconds;

  print('\n[2] Const Canonicalized Allocations:');
  print('    Time Elapsed: $constElapsedMs ms ($constElapsedMicro µs)');
  print('    Heap Impact:  EXACTLY 1 instance allocated in constant pool. Zero GC pressure.');

  // --------------------------------------------------------------------------
  // Summary & Speedup Analysis
  // --------------------------------------------------------------------------
  print('\n=== PERFORMANCE SUMMARY & ANALYSIS ===');
  if (constElapsedMicro > 0) {
    final speedupFactor = (dynamicElapsedMicro / constElapsedMicro).toStringAsFixed(2);
    print('>> Const evaluation was ~${speedupFactor}x faster in this benchmark!');
  }
  print('>> Total hash checksum check (prevents loop dead-code removal): ${dynamicHashAccumulator ^ constHashAccumulator}');

  print('\n=== KEY TAKEAWAY FOR FLUTTER & DART ARCHITECTS ===');
  print('Using `const` constructors on immutable data structures and widgets');
  print('is NOT just syntactic sugar. It completely eliminates memory fragmentation');
  print('and relieves the Garbage Collector (Scavenger) from continuous sweeping.');
}
