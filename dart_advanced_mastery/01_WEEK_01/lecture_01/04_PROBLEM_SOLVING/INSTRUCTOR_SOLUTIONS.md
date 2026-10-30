# Instructor Solutions Manual — Lecture 01 (Stanford CS-Style)
> **تنبيه للمحاضر:** هذا الملف سري وخاص بهيئة التدريس فقط. يحتوي على التحليل الخوارزمي الكامل، والحلول الساذجة (Naive) والمثلى (Optimized)، وتحليل التعقيد الحسابي لكل مسألة.

---

### Solution 1: Safe Monotonic Sequence Validator
- **Strategy & Analysis:**
  - A single linear scan from $i = 0$ to $N - 2$.
  - For each element, verify two invariant conditions:
    1. $timestamps[i+1] > timestamps[i]$ (Strict increase).
    2. $timestamps[i+1] - timestamps[i] \le maxGap$.
  - Base cases: If length is $0$ or $1$, the sequence is vacuously valid.
- **Dart Implementation:**
  ```dart
  bool isValidTimeline(List<int> timestamps, int maxGap) {
    if (timestamps.length <= 1) return true;

    for (int i = 0; i < timestamps.length - 1; i++) {
      final current = timestamps[i];
      final next = timestamps[i + 1];

      // Condition 1: Strict increase
      if (next <= current) return false;

      // Condition 2: Permissible gap
      if ((next - current) > maxGap) return false;
    }
    return true;
  }
  ```
- **Complexity Analysis:**
  - **Time Complexity:** $O(N)$ where $N$ is the length of `timestamps`. We visit each adjacent pair exactly once.
  - **Space Complexity:** $O(1)$ auxiliary memory (only two integer pointers).

---

### Solution 2: Safe Null-Coalescing Sanitizer
- **Strategy & Analysis:**
  - Map each element using flow analysis and String operations.
  - If the element is `null` or its trimmed form is empty, replace with `'ANONYMOUS'`.
- **Dart Implementation:**
  ```dart
  List<String> sanitizeCustomerNames(List<String?> rawInputs) {
    return rawInputs.map((entry) {
      if (entry == null) return 'ANONYMOUS';
      final trimmed = entry.trim();
      return trimmed.isEmpty ? 'ANONYMOUS' : trimmed.toUpperCase();
    }).toList();
  }
  ```
- **Complexity Analysis:**
  - **Time Complexity:** $O(N \times L)$ where $N$ is the number of strings and $L$ is their average length.
  - **Space Complexity:** $O(N \times L)$ to allocate the transformed sanitized list.

---

### Solution 3: First Non-Repeating Transaction Code
- **Naive Approach ($O(N^2)$):**
  - For each element, run an inner loop over the entire array counting occurrences.
  - Fails on $N = 200,000$ due to $(2 \times 10^5)^2 = 4 \times 10^{10}$ operations (Time Limit Exceeded).
- **Optimized Approach ($O(N)$ with HashMap):**
  - Pass 1: Build a frequency map `Map<String, int>`.
  - Pass 2: Iterate through the original list and return the first element with frequency 1.
- **Dart Implementation:**
  ```dart
  String? firstUniqueTransaction(List<String> codes) {
    final frequencyMap = <String, int>{};

    for (final code in codes) {
      frequencyMap[code] = (frequencyMap[code] ?? 0) + 1;
    }

    for (final code in codes) {
      if (frequencyMap[code] == 1) {
        return code;
      }
    }

    return null;
  }
  ```
- **Complexity Analysis:**
  - **Time Complexity:** $O(N)$ since map lookups and insertions are on average $O(1)$.
  - **Space Complexity:** $O(U)$ where $U \le N$ is the number of distinct transaction codes.

---

### Solution 4: Group Disordered Transaction Batches (Anagrams)
- **Strategy & Analysis:**
  - Two strings are anagrams if and only if their sorted character sequences are identical.
  - For each string, sort its characters to produce a canonical key (e.g. `'eat'` $\rightarrow$ `'aet'`).
  - Use a `Map<String, List<String>>` grouping strings by their canonical key.
- **Dart Implementation:**
  ```dart
  List<List<String>> groupTransactionBatches(List<String> tags) {
    final groups = <String, List<String>>{};

    for (final tag in tags) {
      // Create canonical key by sorting characters
      final chars = tag.split('')..sort();
      final key = chars.join();

      groups.putIfAbsent(key, () => <String>[]).add(tag);
    }

    return groups.values.toList();
  }
  ```
- **Complexity Analysis:**
  - **Time Complexity:** $O(N \times K \log K)$ where $N$ is the number of tags and $K$ is the maximum length of a tag.
  - **Space Complexity:** $O(N \times K)$ to store the grouped lists and map keys.

---

### Solution 5: Zero-Sum Transaction Offset Pair
- **Strategy & Analysis:**
  - For each transaction $x$, its offsetting pair is $-x$.
  - Maintain a hash table mapping the seen number to its original index: `seen[x] = index`.
  - As we iterate at index $i$, check if $-x$ already exists in the map. If yes, return `[seen[-x]!, i]`.
- **Dart Implementation:**
  ```dart
  List<int>? findZeroSumPair(List<int> transactions) {
    final seen = <int, int>{}; // Value -> Index

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
  ```
- **Complexity Analysis:**
  - **Time Complexity:** $O(N)$ single pass through the list with $O(1)$ average hash lookups.
  - **Space Complexity:** $O(N)$ auxiliary space for the hash map.

---

### Solution 6: Minimum Transaction Window Exceeding Threshold (Sliding Window)
- **Naive Approach ($O(N^2)$):**
  - Check all possible pairs of `(start, end)` calculating their sum. Time Limit Exceeded.
- **Optimized Sliding Window Approach ($O(N)$ Time, $O(1)$ Space):**
  - Maintain two pointers: `left` and `right`.
  - Expand `right` to include `amounts[right]` in running `currentSum`.
  - While `currentSum >= threshold`:
    - Update `minLength = min(minLength, right - left + 1)`.
    - Subtract `amounts[left]` from `currentSum` and advance `left++`.
  - Return `minLength == infinity ? 0 : minLength`.
- **Dart Implementation:**
  ```dart
  int minSubArrayLen(int threshold, List<int> amounts) {
    int left = 0;
    int currentSum = 0;
    int minLength = 1 << 30; // Initialize to high sentinel value

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
  ```
- **Complexity Analysis:**
  - **Time Complexity:** $O(N)$. Although there is a nested while loop, each element is added by `right` at most once and removed by `left` at most once (at most $2N$ pointer steps total).
  - **Space Complexity:** $O(1)$ auxiliary memory (only integer scalars `left`, `right`, `currentSum`, `minLength`).
