# Problem Solving Bank — Lecture 03 (Stanford CS-Style)
> **ملاحظة للمتدرب:** هذه النسخة مخصصة لك لحل المسائل بشكل مستقل وتوظيف Records وPattern Matching في الخوارزميات.

---

### Problem 1 (Level 1 — Records & Bounds): Min-Max Coordinate Bounding Box
- **Problem Statement:**  
  Given a list of 2D coordinates represented as Records `(double x, double y)`, compute the minimum bounding box containing all points. Return a Record of two points: `( (double minX, double minY), (double maxX, double maxY) )`. If the list is empty, return `null`.
- **Constraints:**
  - $0 \le N \le 10^5$.
  - Time complexity must be $O(N)$.
- **Examples:**
  - `[(1.0, 5.0), (-2.0, 3.0), (4.0, -1.0)]`  
    $\rightarrow$ `((-2.0, -1.0), (4.0, 5.0))`

---

### Problem 2 (Level 1 — Pattern Destructuring): Palindrome Permutation Checker
- **Problem Statement:**  
  Given a string `s`, determine whether a permutation of the string could form a palindrome.
- **Constraints:**
  - Time Complexity: $O(N)$.
  - Only lowercase English letters.
- **Examples:**
  - `"code"` $\rightarrow$ `false`
  - `"aab"` $\rightarrow$ `true` (`"aba"` is a palindrome)
  - `"carerac"` $\rightarrow$ `true` (`"racecar"`)
- **Hints:**
  - A palindrome can have at most ONE character with an odd frequency!
  - Can you use a `Set<String>` to track odd occurrences in a single pass?

---

### Problem 3 (Level 2 — Pattern Matching & Stack): Valid Bracket Tokens
- **Problem Statement:**  
  Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid using a stack and Dart 3 Pattern Matching.
- **Examples:**
  - `"()[]{}"` $\rightarrow$ `true`
  - `"(]"` $\rightarrow$ `false`
  - `"([)]"` $\rightarrow$ `false`
  - `"{[]}"` $\rightarrow$ `true`

---

### Problem 4 (Level 2 — Records & Frequency): Top K Frequent Elements
- **Problem Statement:**  
  Given an integer array `nums` and an integer `k`, return the `k` most frequent elements. You may return the answer in any order.
- **Constraints:**
  - $1 \le k \le \text{number of unique elements}$.
  - Time complexity must be better than $O(N^2)$ (Aim for $O(N \log N)$ or $O(N)$ with Bucket Sort).
- **Examples:**
  - `nums = [1, 1, 1, 2, 2, 3], k = 2` $\rightarrow$ `[1, 2]`
  - `nums = [1], k = 1` $\rightarrow$ `[1]`

---

### Problem 5 (Level 3 — Sliding Window & Sets): Longest Substring Without Repeating Characters
- **Problem Statement:**  
  Given a string `s`, find the length of the **longest substring without repeating characters**.
- **Constraints:**
  - $0 \le s.length \le 5 \times 10^4$.
  - Time complexity must be $O(N)$.
- **Examples:**
  - `s = "abcabcbb"` $\rightarrow$ `3` ("abc")
  - `s = "bbbbb"` $\rightarrow$ `1` ("b")
  - `s = "pwwkew"` $\rightarrow$ `3` ("wke")

---

### Problem 6 (Level 4 — Two Pointers & Records): Trapping Rain Water
- **Problem Statement:**  
  Given $n$ non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining. Use an optimal Two-Pointer approach returning `(int trappedWater, int peakHeight)`.
- **Constraints:**
  - $1 \le n \le 10^5$.
  - $0 \le height[i] \le 10^5$.
  - Time complexity: $O(N)$.
  - Space complexity: $O(1)$.
- **Examples:**
  - `height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]` $\rightarrow$ `6`
