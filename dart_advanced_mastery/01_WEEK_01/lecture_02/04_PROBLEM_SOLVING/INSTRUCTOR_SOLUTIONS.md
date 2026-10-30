# Instructor Solutions Manual — Lecture 02 (Stanford CS-Style)
> **تنبيه للمحاضر:** هذا الملف سري وخاص بهيئة التدريس فقط. يحتوي على التحليل الخوارزمي الكامل، والحلول، وتحليل التعقيد الحسابي لكل مسألة من مسائل المحاضرة الثانية.

---

### Solution 1: Functional List Partition
- **Dart Implementation:**
  ```dart
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
  ```
- **Complexity:** Time: $O(N)$, Space: $O(N)$ for partition lists.

---

### Solution 2: Mathematical Function Chainer
- **Dart Implementation:**
  ```dart
  int Function(int) chainFunctions(List<int Function(int)> functions) {
    return (int input) {
      int current = input;
      for (final fn in functions) {
        current = fn(current);
      }
      return current;
    };
  }
  ```
- **Complexity:** Time: $O(K)$ per evaluation where $K$ is the number of functions. Space: $O(1)$ auxiliary memory.

---

### Solution 3: Generic Memoize Wrapper
- **Dart Implementation:**
  ```dart
  R Function(T) memoize<T, R>(R Function(T) computeFn) {
    final cache = <T, R>{};
    return (T input) {
      if (cache.containsKey(input)) {
        return cache[input] as R;
      }
      final result = computeFn(input);
      cache[input] = result;
      return result;
    };
  }
  ```
- **Complexity:** First Call: $O(\text{Cost of computeFn})$, Subsequent Calls: $O(1)$ average lookup. Space: $O(U)$ where $U$ is distinct inputs.

---

### Solution 4: Functional Group By
- **Dart Implementation:**
  ```dart
  Map<K, List<T>> groupBy<T, K>(List<T> items, K Function(T) keySelector) {
    final groups = <K, List<T>>{};
    for (final item in items) {
      final key = keySelector(item);
      groups.putIfAbsent(key, () => <T>[]).add(item);
    }
    return groups;
  }
  ```
- **Complexity:** Time: $O(N)$, Space: $O(N)$.

---

### Solution 5: In-Place Functional Compaction
- **Dart Implementation:**
  ```dart
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
  ```
- **Complexity:** Time: $O(N)$, Space: $O(1)$ strictly in-place.

---

### Solution 6: Reverse Polish Notation Evaluator
- **Dart Implementation:**
  ```dart
  int evalRPN(List<String> tokens) {
    final stack = <int>[];

    final operators = <String, int Function(int, int)>{
      '+': (a, b) => a + b,
      '-': (a, b) => a - b,
      '*': (a, b) => a * b,
      '/': (a, b) => a ~/ b, // Integer truncation in Dart
    };

    for (final token in tokens) {
      if (operators.containsKey(token)) {
        final b = stack.removeLast();
        final a = stack.removeLast();
        final op = operators[token]!;
        stack.add(op(a, b));
      } else {
        stack.add(int.parse(token));
      }
    }

    return stack.single;
  }
  ```
- **Complexity:** Time: $O(N)$, Space: $O(N)$ for operand stack.
