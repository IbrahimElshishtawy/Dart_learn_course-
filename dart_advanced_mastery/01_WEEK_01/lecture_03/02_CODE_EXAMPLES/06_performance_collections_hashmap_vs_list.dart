/// ==============================================================================
/// File: 06_performance_collections_hashmap_vs_list.dart
/// Educational Objective: Measure and prove the computational complexity difference
/// between List linear search $O(N)$ and Set/Map hash lookup $O(1)$ in large collections.
///
/// Execution:
///   dart run 06_performance_collections_hashmap_vs_list.dart
/// ==============================================================================

void main() {
  const int datasetSize = 100000;
  const int lookupQueries = 1000;

  print('=== BENCHMARK: Collection Membership Lookup ($lookupQueries queries across $datasetSize items) ===\n');

  // Generate dataset
  final listData = List<int>.generate(datasetSize, (i) => i * 2);
  final setData = Set<int>.from(listData);

  // Generate target search queries (half present, half missing)
  final queries = List<int>.generate(lookupQueries, (i) => i * 3);

  // --------------------------------------------------------------------------
  // Benchmark 1: List.contains() — Linear Scan O(N)
  // --------------------------------------------------------------------------
  final stopwatchList = Stopwatch()..start();
  int listFoundCount = 0;

  for (final q in queries) {
    if (listData.contains(q)) {
      listFoundCount++;
    }
  }
  stopwatchList.stop();
  final listElapsedMs = stopwatchList.elapsedMilliseconds;
  final listElapsedMicros = stopwatchList.elapsedMicroseconds;

  // --------------------------------------------------------------------------
  // Benchmark 2: Set.contains() — Hash-table Lookup O(1)
  // --------------------------------------------------------------------------
  final stopwatchSet = Stopwatch()..start();
  int setFoundCount = 0;

  for (final q in queries) {
    if (setData.contains(q)) {
      setFoundCount++;
    }
  }
  stopwatchSet.stop();
  final setElapsedMs = stopwatchSet.elapsedMilliseconds;
  final setElapsedMicros = stopwatchSet.elapsedMicroseconds;

  // --------------------------------------------------------------------------
  // Comparison & Architectural Takeaways
  // --------------------------------------------------------------------------
  print('[1] List.contains() [O(N) Complexity]:');
  print('    Time Elapsed : $listElapsedMs ms ($listElapsedMicros µs)');
  print('    Items Matched: $listFoundCount');

  print('\n[2] Set.contains() [O(1) Complexity]:');
  print('    Time Elapsed : $setElapsedMs ms ($setElapsedMicros µs)');
  print('    Items Matched: $setFoundCount');

  print('\n=== PERFORMANCE SUMMARY & ANALYSIS ===');
  if (setElapsedMicros > 0) {
    final speedupFactor = (listElapsedMicros / setElapsedMicros).toStringAsFixed(1);
    print('>> Set hash lookup was ~${speedupFactor}x faster than List linear scan!');
  }

  print('\n=== KEY TAKEAWAY FOR DART & FLUTTER ENGINEERS ===');
  print('Never use a `List` to check for item membership or uniqueness in loops!');
  print('Convert to `Set` or `Map` whenever lookups are frequent to maintain constant-time O(1) performance.');
}
