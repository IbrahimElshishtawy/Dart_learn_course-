/// ==============================================================================
/// File: 03_advanced_canonicalization_and_late.dart
/// Educational Objective: Master Dart memory management through `final` vs `const`,
/// understand object canonicalization via `identical()`, and dissect the `late`
/// modifier's internal mechanics and failure modes.
///
/// Execution:
///   dart run 03_advanced_canonicalization_and_late.dart
/// ==============================================================================

class ImmutableCoordinate {
  final double x;
  final double y;

  // A const constructor enables compile-time evaluation and canonicalization
  const ImmutableCoordinate(this.x, this.y);

  @override
  String toString() => 'Coordinate($x, $y)';
}

class HeavyCalculationService {
  HeavyCalculationService() {
    print('>> [EXPENSIVE] HeavyCalculationService constructor executed! Heavy resources loaded.');
  }

  double computeMatrixEigenValue() {
    return 42.9981;
  }
}

class SystemConfig {
  // 1. Lazy evaluation via 'late': NOT instantiated until the first read access!
  late final HeavyCalculationService heavyService = HeavyCalculationService();

  // 2. Late initialization without initializer: Requires explicit assignment before access
  late final String encryptionKey;

  void initializeSecurity(String key) {
    encryptionKey = key;
  }
}

void main() {
  print('=== STEP 1: const vs final & Canonicalization in Memory ===');

  // Both c1 and c2 are declared with 'const' and identical values.
  const c1 = ImmutableCoordinate(10.0, 20.0);
  const c2 = ImmutableCoordinate(10.0, 20.0);

  // Both f1 and f2 are declared with 'final' and created at runtime.
  final f1 = ImmutableCoordinate(10.0, 20.0);
  final f2 = ImmutableCoordinate(10.0, 20.0);

  print('c1: $c1, c2: $c2');
  print('f1: $f1, f2: $f2');

  // identical() checks whether two references point to the exact same physical memory address
  print('\nMemory Identity Checks:');
  bool constAreIdentical = identical(c1, c2);
  bool finalAreIdentical = identical(f1, f2);

  print('Are c1 and c2 identical in memory? $constAreIdentical (Canonicalization: TRUE)');
  print('Are f1 and f2 identical in memory? $finalAreIdentical (Separate Heap Allocations: FALSE)');

  print('\n=== STEP 2: The Canonicalization Rule ===');
  print('Any const constructor with identical compile-time arguments produces');
  print('EXACTLY ONE instance shared across the entire application lifetime.');

  print('\n=== STEP 3: The Mechanics of "late" (Lazy Evaluation) ===');
  print('Creating SystemConfig instance now...');
  final config = SystemConfig();
  print('SystemConfig instance created! Notice HeavyCalculationService was NOT created yet.');

  print('\nNow accessing config.heavyService for the first time:');
  double result = config.heavyService.computeMatrixEigenValue();
  print('Calculation result: $result');

  print('\nAccessing config.heavyService a second time:');
  // Constructor is NOT called again. The cached instance is returned.
  double cachedResult = config.heavyService.computeMatrixEigenValue();
  print('Second calculation result: $cachedResult');

  print('\n=== STEP 4: The Danger of "late": LateInitializationError ===');
  final uninitializedConfig = SystemConfig();

  try {
    // Attempting to read 'encryptionKey' before calling initializeSecurity()
    print('Reading encryption key: ${uninitializedConfig.encryptionKey}');
  } catch (e) {
    print('CAUGHT RUNTIME EXCEPTION: $e');
    print('Notice: It is NOT null! It is a fatal LateInitializationError.');
  }

  print('\nNow initializing properly:');
  uninitializedConfig.initializeSecurity('AES_256_GCM_SECURE_TOKEN_XYZ');
  print('Successfully read key: ${uninitializedConfig.encryptionKey}');
}

/*
================================================================================
TECHNICAL BREAKDOWN & ARCHITECTURAL IMPLICATIONS
================================================================================
1. Canonicalization:
   - When the Dart compiler encounters `const` instances with identical values,
     it deduplicates them into a single read-only constant pool.
   - Benefit: Massive memory savings and instantaneous equality checks using pointer
     identity (`identical()`), which is O(1) compared to structural field comparisons.

2. `late` Modifier Internals:
   - Under the hood, the Dart VM transforms a `late` field into a getter/setter pair
     with an internal sentinel flag (often implemented as a private uninitialized marker).
   - On every access, the VM checks: "Is this sentinel still active?".
     If yes and an initializer was provided, it executes the initializer once and caches it.
     If yes and NO initializer was provided, it throws `LateInitializationError`.
   - Architectural Rule: Use `late` primarily for lazy loading heavy singletons or services,
     never as a cheap hack to bypass Null Safety.
================================================================================
*/
