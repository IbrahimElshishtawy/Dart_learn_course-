/// ==============================================================================
/// Executable Test Runner for Lecture 01 Problem Solving Solutions
/// Runs all 6 algorithm implementations against edge cases.
///
/// Execution:
///   dart run dart_advanced_mastery/01_WEEK_01/lecture_01/04_PROBLEM_SOLVING/solutions/lecture_01_solutions.dart
/// ==============================================================================

// Problem 1: Monotonic Sequence
bool isValidTimeline(List<int> timestamps, int maxGap) {
  if (timestamps.length <= 1) return true;
  for (int i = 0; i < timestamps.length - 1; i++) {
    final current = timestamps[i];
    final next = timestamps[i + 1];
    if (next <= current) return false;
    if ((next - current) > maxGap) return false;
  }
  return true;
}

// Problem 2: Null Sanitizer
List<String> sanitizeCustomerNames(List<String?> rawInputs) {
  return rawInputs.map((entry) {
    if (entry == null) return 'ANONYMOUS';
    final trimmed = entry.trim();
    return trimmed.isEmpty ? 'ANONYMOUS' : trimmed.toUpperCase();
  }).toList();
}

// Problem 3: First Non-Repeating
String? firstUniqueTransaction(List<String> codes) {
  final frequencyMap = <String, int>{};
  for (final code in codes) {
    frequencyMap[code] = (frequencyMap[code] ?? 0) + 1;
  }
  for (final code in codes) {
    if (frequencyMap[code] == 1) return code;
  }
  return null;
}

// Problem 4: Group Anagrams
List<List<String>> groupTransactionBatches(List<String> tags) {
  final groups = <String, List<String>>{};
  for (final tag in tags) {
    final chars = tag.split('')..sort();
    final key = chars.join();
    groups.putIfAbsent(key, () => <String>[]).add(tag);
  }
  return groups.values.toList();
}

// Problem 5: Zero-Sum Pair
List<int>? findZeroSumPair(List<int> transactions) {
  final seen = <int, int>{};
  for (int i = 0; i < transactions.length; i++) {
    final current = transactions[i];
    final targetComplement = -current;
    if (seen.containsKey(targetComplement)) {
      return [seen[targetComplement]!, i];
    }
    seen[current] = i;
  }
  return null;
}

// Problem 6: Minimum Window Subarray
int minSubArrayLen(int threshold, List<int> amounts) {
  int left = 0;
  int currentSum = 0;
  int minLength = 1 << 30;

  for (int right = 0; right < amounts.length; right++) {
    currentSum += amounts[right];
    while (currentSum >= threshold) {
      final currentWindowLength = right - left + 1;
      if (currentWindowLength < minLength) {
        minLength = currentWindowLength;
      }
      currentSum -= amounts[left];
      left++;
    }
  }

  return minLength == (1 << 30) ? 0 : minLength;
}

void main() {
  print('=== Running Verification on Lecture 01 Solutions ===');

  // Test Problem 1
  assert(isValidTimeline([100, 105, 112, 115], 10) == true);
  assert(isValidTimeline([100, 105, 105, 110], 10) == false);
  assert(isValidTimeline([100, 120], 10) == false);
  assert(isValidTimeline([], 10) == true);
  print('✓ Problem 1 passed all test cases.');

  // Test Problem 2
  final sanitized = sanitizeCustomerNames(['  ali ', null, '  ', 'sara']);
  assert(sanitized[0] == 'ALI');
  assert(sanitized[1] == 'ANONYMOUS');
  assert(sanitized[2] == 'ANONYMOUS');
  assert(sanitized[3] == 'SARA');
  print('✓ Problem 2 passed all test cases.');

  // Test Problem 3
  assert(firstUniqueTransaction(['TX_A', 'TX_B', 'TX_A', 'TX_C', 'TX_B']) == 'TX_C');
  assert(firstUniqueTransaction(['TX_X', 'TX_X']) == null);
  print('✓ Problem 3 passed all test cases.');

  // Test Problem 4
  final grouped = groupTransactionBatches(['eat', 'tea', 'tan', 'ate', 'nat', 'bat']);
  assert(grouped.length == 3);
  print('✓ Problem 4 passed all test cases.');

  // Test Problem 5
  final pair = findZeroSumPair([150, -40, 200, 40, -10]);
  assert(pair != null && pair[0] == 1 && pair[1] == 3);
  assert(findZeroSumPair([10, 20, 30]) == null);
  print('✓ Problem 5 passed all test cases.');

  // Test Problem 6
  assert(minSubArrayLen(7, [2, 3, 1, 2, 4, 3]) == 2);
  assert(minSubArrayLen(4, [1, 4, 4]) == 1);
  assert(minSubArrayLen(11, [1, 1, 1, 1, 1]) == 0);
  print('✓ Problem 6 passed all test cases.');

  print('\n>>> ALL 6 ALGORITHM SOLUTIONS VERIFIED SUCCESSFULLY (EXIT CODE 0) <<<');
}
