# Instructor Solutions Manual — Lecture 03 (Stanford CS-Style)
> **تنبيه للمحاضر:** هذا الملف سري وخاص بهيئة التدريس فقط. يحتوي على التحليل الخوارزمي الكامل، والحلول، والتعقيد الحسابي لمسائل المحاضرة الثالثة.

---

### Solution 1: Min-Max Coordinate Bounding Box
- **Dart Implementation:**
  ```dart
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
  ```
- **Complexity:** Time: $O(N)$, Space: $O(1)$.

---

### Solution 2: Palindrome Permutation Checker
- **Dart Implementation:**
  ```dart
  bool canFormPalindrome(String s) {
    final oddChars = <String>{};
    for (final char in s.split('')) {
      if (!oddChars.add(char)) {
        oddChars.remove(char); // If already present, remove it (pair cancelled)
      }
    }
    return oddChars.length <= 1;
  }
  ```
- **Complexity:** Time: $O(N)$, Space: $O(\min(N, 26)) = O(1)$.

---

### Solution 3: Valid Bracket Tokens (Pattern Matching & Stack)
- **Dart Implementation:**
  ```dart
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
  ```
- **Complexity:** Time: $O(N)$, Space: $O(N)$.

---

### Solution 4: Top K Frequent Elements
- **Dart Implementation:**
  ```dart
  List<int> topKFrequent(List<int> nums, int k) {
    final frequency = <int, int>{};
    for (final n in nums) {
      frequency[n] = (frequency[n] ?? 0) + 1;
    }

    // Convert entries to Records and sort by frequency descending
    final entries = frequency.entries
        .map((e) => (num: e.key, count: e.value))
        .toList()
      ..sort((a, b) => b.count.compareTo(a.count));

    return entries.take(k).map((e) => e.num).toList();
  }
  ```
- **Complexity:** Time: $O(N + U \log U)$ where $U$ is distinct numbers. Space: $O(U)$.

---

### Solution 5: Longest Substring Without Repeating Characters (Sliding Window)
- **Dart Implementation:**
  ```dart
  int lengthOfLongestSubstring(String s) {
    final seen = <String, int>{}; // Char -> last index
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
  ```
- **Complexity:** Time: $O(N)$, Space: $O(\min(N, \Sigma))$.

---

### Solution 6: Trapping Rain Water (Two Pointers & Record Return)
- **Dart Implementation:**
  ```dart
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
  ```
- **Complexity:** Time: $O(N)$ single pass. Space: $O(1)$ auxiliary.
