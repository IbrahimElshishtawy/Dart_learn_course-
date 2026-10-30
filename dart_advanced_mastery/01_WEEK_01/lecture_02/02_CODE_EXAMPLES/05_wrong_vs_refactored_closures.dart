/// ==============================================================================
/// File: 05_wrong_vs_refactored_closures.dart
/// Educational Objective: Contrast an impure implementation that introduces subtle
/// state corruption and memory leaks via closures with a pure, refactored implementation
/// adhering to Functional Programming and Referential Transparency.
///
/// Execution:
///   dart run 05_wrong_vs_refactored_closures.dart
/// ==============================================================================

// ==============================================================================
// 1. THE WRONG IMPLEMENTATION (Impure, Mutable Global Side-Effects & Memory Retain)
// ==============================================================================

// ANTI-PATTERN: Global mutable state manipulated by closures
int globalTransactionCounter = 0;
List<String> auditSink = [];

class HeavyService {
  // 100,000 integers occupying substantial heap memory
  final List<int> hugePayload = List<int>.generate(100000, (i) => i);

  void Function() getLeakyCallback() {
    // ANTI-PATTERN: This closure implicitly captures 'this' (the entire HeavyService instance)
    // even though it only needs a simple greeting!
    // The entire hugePayload list cannot be garbage-collected as long as this callback lives.
    return () {
      globalTransactionCounter++; // Side-effect 1
      auditSink.add('Leaky execution'); // Side-effect 2
      print('Leaky callback executed. Global counter: $globalTransactionCounter');
    };
  }
}

// ==============================================================================
// 2. THE REFACTORED IMPLEMENTATION (Pure, Self-Contained, Memory-Safe)
// ==============================================================================

class CleanService {
  final List<int> hugePayload = List<int>.generate(100000, (i) => i);

  /// Safe Factory returning a callback that captures ONLY the primitive it needs
  void Function() getSafeCallback(String identifier) {
    // We extract the exact scalar value needed. 'this' is NOT captured.
    final localId = identifier;

    return () {
      // Pure execution without mutating global state
      print('Safe callback [$localId] executed independently.');
    };
  }

  /// Pure transformation function: depends only on its inputs, returns new state
  static (int newCount, String logEntry) pureProcess(int currentCount, String tag) {
    final next = currentCount + 1;
    final log = 'Processed tag: $tag at count $next';
    return (next, log);
  }
}

void main() {
  print('=== RUNNING WRONG IMPLEMENTATION (SIDE EFFECTS) ===');
  final heavy = HeavyService();
  final leakyCb = heavy.getLeakyCallback();
  leakyCb();
  leakyCb();
  print('Global mutable counter contaminated: $globalTransactionCounter');

  print('\n=== RUNNING REFACTORED IMPLEMENTATION (PURE) ===');
  final clean = CleanService();
  final safeCb = clean.getSafeCallback('TX_SAFE_101');
  safeCb();

  // Pure function invocation
  var localCount = 0;
  final (updatedCount1, log1) = CleanService.pureProcess(localCount, 'BATCH_A');
  final (updatedCount2, log2) = CleanService.pureProcess(updatedCount1, 'BATCH_B');

  print('Pure Result 1: $log1 (Count: $updatedCount1)');
  print('Pure Result 2: $log2 (Count: $updatedCount2)');
  print('Zero global contamination. Perfect testability.');
}
