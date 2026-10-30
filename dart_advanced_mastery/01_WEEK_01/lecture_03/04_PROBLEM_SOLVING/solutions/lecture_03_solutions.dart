/// ==============================================================================
/// Executable Test Runner for Lecture 03 Problem Solving Solutions
///
/// Execution:
///   dart run --enable-asserts dart_advanced_mastery/01_WEEK_01/lecture_03/04_PROBLEM_SOLVING/solutions/lecture_03_solutions.dart
/// ==============================================================================

// Problem 1: Bounding Box
((double, double), (double, double))? computeBoundingBox(List<(double, double)> points) {
  if (points.isEmpty) return null;
  var (minX, minY) = points.first;
  var (maxX, maxY) = points.first;
  for (final (x, y) in points.skip(1)) {
    if (x < minX) minX = x;
    if (x > maxX) maxX = x;
    if (y < minY) minY = y;
    if (y > maxY) maxY = y;
  }
  return ((minX, minY), (maxX, maxY));
}

// Problem 2: Palindrome Permutation
bool canFormPalindrome(String s) {
  final oddChars = <String>{};
  for (final char in s.split('')) {
    if (!oddChars.add(char)) {
      oddChars.remove(char);
    }
  }
  return oddChars.length <= 1;
}

// Problem 3: Valid Brackets
bool isValidBrackets(String s) {
  final stack = <String>[];
  for (final char in s.split('')) {
    switch (char) {
      case '(' || '{' || '[':
        stack.add(char);
      case ')':
        if (stack.isEmpty || stack.removeLast() != '(') return false;
      case '}':
        if (stack.isEmpty || stack.removeLast() != '{') return false;
      case ']':
        if (stack.isEmpty || stack.removeLast() != '[') return false;
    }
  }
  return stack.isEmpty;
}

// Problem 4: Top K Frequent
List<int> topKFrequent(List<int> nums, int k) {
  final frequency = <int, int>{};
  for (final n in nums) {
    frequency[n] = (frequency[n] ?? 0) + 1;
  }
  final entries = frequency.entries
      .map((e) => (num: e.key, count: e.value))
      .toList()
    ..sort((a, b) => b.count.compareTo(a.count));
  return entries.take(k).map((e) => e.num).toList();
}

// Problem 5: Longest Substring Without Repeating
int lengthOfLongestSubstring(String s) {
  final seen = <String, int>{};
  int maxLength = 0;
  int left = 0;
  for (int right = 0; right < s.length; right++) {
    final char = s[right];
    if (seen.containsKey(char) && seen[char]! >= left) {
      left = seen[char]! + 1;
    }
    seen[char] = right;
    final currentLen = right - left + 1;
    if (currentLen > maxLength) maxLength = currentLen;
  }
  return maxLength;
}

// Problem 6: Trapping Rain Water
(int trappedWater, int peakHeight) trapRainWater(List<int> height) {
  if (height.isEmpty) return (0, 0);
  int left = 0;
  int right = height.length - 1;
  int leftMax = 0;
  int rightMax = 0;
  int totalWater = 0;
  int overallPeak = 0;

  while (left < right) {
    if (height[left] < height[right]) {
      if (height[left] >= leftMax) {
        leftMax = height[left];
      } else {
        totalWater += leftMax - height[left];
      }
      if (height[left] > overallPeak) overallPeak = height[left];
      left++;
    } else {
      if (height[right] >= rightMax) {
        rightMax = height[right];
      } else {
        totalWater += rightMax - height[right];
      }
      if (height[right] > overallPeak) overallPeak = height[right];
      right--;
    }
  }
  if (height[left] > overallPeak) overallPeak = height[left];
  return (totalWater, overallPeak);
}

void main() {
  print('=== Running Verification on Lecture 03 Solutions ===');

  // Test 1: Bounding Box
  final box = computeBoundingBox([(1.0, 5.0), (-2.0, 3.0), (4.0, -1.0)]);
  assert(box != null && box.$1 == (-2.0, -1.0) && box.$2 == (4.0, 5.0));
  print('✓ Problem 1 (Bounding Box) passed.');

  // Test 2: Palindrome Permutation
  assert(canFormPalindrome('code') == false);
  assert(canFormPalindrome('aab') == true);
  assert(canFormPalindrome('carerac') == true);
  print('✓ Problem 2 (Palindrome Permutation) passed.');

  // Test 3: Valid Brackets
  assert(isValidBrackets('()[]{}') == true);
  assert(isValidBrackets('(]') == false);
  assert(isValidBrackets('([)]') == false);
  assert(isValidBrackets('{[]}') == true);
  print('✓ Problem 3 (Valid Brackets) passed.');

  // Test 4: Top K Frequent
  final topK = topKFrequent([1, 1, 1, 2, 2, 3], 2);
  assert(topK.length == 2 && topK.contains(1) && topK.contains(2));
  print('✓ Problem 4 (Top K Frequent) passed.');

  // Test 5: Longest Substring
  assert(lengthOfLongestSubstring('abcabcbb') == 3);
  assert(lengthOfLongestSubstring('bbbbb') == 1);
  assert(lengthOfLongestSubstring('pwwkew') == 3);
  print('✓ Problem 5 (Longest Substring) passed.');

  // Test 6: Trapping Rain Water
  final (water, peak) = trapRainWater([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]);
  assert(water == 6 && peak == 3);
  print('✓ Problem 6 (Trapping Rain Water) passed.');

  print('\n>>> ALL L03 ALGORITHM SOLUTIONS VERIFIED (EXIT CODE 0) <<<');
}
