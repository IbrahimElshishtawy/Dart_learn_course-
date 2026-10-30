/// ==============================================================================
/// Executable Test Runner for Lecture 02 Problem Solving Solutions
///
/// Execution:
///   dart run --enable-asserts dart_advanced_mastery/01_WEEK_01/lecture_02/04_PROBLEM_SOLVING/solutions/lecture_02_solutions.dart
/// ==============================================================================

// Problem 1: Partition
(List<T>, List<T>) partition<T>(List<T> list, bool Function(T) predicate) {
  final matching = <T>[];
  final nonMatching = <T>[];
  for (final item in list) {
    if (predicate(item)) {
      matching.add(item);
    } else {
      nonMatching.add(item);
    }
  }
  return (matching, nonMatching);
}

// Problem 2: Function Chainer
int Function(int) chainFunctions(List<int Function(int)> functions) {
  return (int input) {
    int current = input;
    for (final fn in functions) {
      current = fn(current);
    }
    return current;
  };
}

// Problem 3: Memoize
R Function(T) memoize<T, R>(R Function(T) computeFn) {
  final cache = <T, R>{};
  return (T input) {
    if (cache.containsKey(input)) return cache[input] as R;
    final res = computeFn(input);
    cache[input] = res;
    return res;
  };
}

// Problem 4: Group By
Map<K, List<T>> groupBy<T, K>(List<T> items, K Function(T) keySelector) {
  final groups = <K, List<T>>{};
  for (final item in items) {
    final key = keySelector(item);
    groups.putIfAbsent(key, () => <T>[]).add(item);
  }
  return groups;
}

// Problem 5: In-Place Compaction
int removeMatchingInPlace(List<int> nums, bool Function(int) shouldRemove) {
  int writeIndex = 0;
  for (int readIndex = 0; readIndex < nums.length; readIndex++) {
    if (!shouldRemove(nums[readIndex])) {
      nums[writeIndex] = nums[readIndex];
      writeIndex++;
    }
  }
  return writeIndex;
}

// Problem 6: Reverse Polish Notation
int evalRPN(List<String> tokens) {
  final stack = <int>[];
  final operators = <String, int Function(int, int)>{
    '+': (a, b) => a + b,
    '-': (a, b) => a - b,
    '*': (a, b) => a * b,
    '/': (a, b) => a ~/ b,
  };

  for (final token in tokens) {
    if (operators.containsKey(token)) {
      final b = stack.removeLast();
      final a = stack.removeLast();
      stack.add(operators[token]!(a, b));
    } else {
      stack.add(int.parse(token));
    }
  }
  return stack.single;
}

void main() {
  print('=== Running Verification on Lecture 02 Solutions ===');

  // Test 1: Partition
  final (evens, odds) = partition([1, 2, 3, 4, 5, 6], (n) => n.isEven);
  assert(evens.length == 3 && odds.length == 3);
  print('✓ Problem 1 (Partition) passed.');

  // Test 2: Chainer
  final chained = chainFunctions([(x) => x + 1, (x) => x * 2]);
  assert(chained(4) == 10);
  print('✓ Problem 2 (Chainer) passed.');

  // Test 3: Memoize
  int computeCount = 0;
  final cachedSquare = memoize((int x) {
    computeCount++;
    return x * x;
  });
  assert(cachedSquare(5) == 25 && computeCount == 1);
  assert(cachedSquare(5) == 25 && computeCount == 1); // Hit cache
  print('✓ Problem 3 (Memoize) passed.');

  // Test 4: Group By
  final grouped = groupBy(['apple', 'banana', 'avocado'], (s) => s[0]);
  assert(grouped['a']!.length == 2 && grouped['b']!.length == 1);
  print('✓ Problem 4 (Group By) passed.');

  // Test 5: In-Place Removal
  final numbers = [3, 2, 2, 3];
  final newLen = removeMatchingInPlace(numbers, (x) => x == 3);
  assert(newLen == 2 && numbers[0] == 2 && numbers[1] == 2);
  print('✓ Problem 5 (In-Place Compaction) passed.');

  // Test 6: Reverse Polish Notation
  assert(evalRPN(["2", "1", "+", "3", "*"]) == 9);
  assert(evalRPN(["4", "13", "5", "/", "+"]) == 6);
  print('✓ Problem 6 (RPN Evaluator) passed.');

  print('\n>>> ALL L02 ALGORITHM SOLUTIONS VERIFIED (EXIT CODE 0) <<<');
}
