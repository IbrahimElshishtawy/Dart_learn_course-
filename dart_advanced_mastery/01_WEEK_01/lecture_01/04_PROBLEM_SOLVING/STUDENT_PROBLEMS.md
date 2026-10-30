# Problem Solving Bank — Lecture 01 (Stanford CS-Style)
> **ملاحظة للمتدرب:** هذه النسخة مخصصة لك لحل المسائل بشكل مستقل. لا توجد حلول داخل هذا الملف.
> اقرأ المسألة، حلل القيود (Constraints)، فكر بالورقة والقلم، واكتب كود Dart واختبره مع الـ Edge Cases.

---

### Problem 1 (Level 1 — Basic Logic): Safe Monotonic Sequence Validator
- **Problem Statement:**  
  You are given an array of transaction timestamps represented as 64-bit integers. An audit rule requires that all recorded timestamps must be **strictly monotonically increasing** ($A[i] < A[i+1]$) and the difference between any two consecutive timestamps must not exceed a maximum permissible gap `maxGap`. Write a function `bool isValidTimeline(List<int> timestamps, int maxGap)`.
- **Input:**
  - `List<int> timestamps`: A list of integer timestamps ($0 \le \text{length} \le 10^5$).
  - `int maxGap`: Maximum allowed time difference between consecutive events ($maxGap > 0$).
- **Output:**
  - Returns `true` if the sequence is strictly increasing and all consecutive gaps are $\le maxGap$; otherwise `false`.
- **Constraints:**
  - List length $N$: $0 \le N \le 100,000$.
  - Values inside list: $1 \le timestamps[i] \le 10^{15}$.
- **Examples:**
  - *Example 1:* `timestamps = [100, 105, 112, 115], maxGap = 10` $\rightarrow$ `true`
  - *Example 2:* `timestamps = [100, 105, 105, 110], maxGap = 10` $\rightarrow$ `false` (Duplicates violate strict increase)
  - *Example 3:* `timestamps = [100, 120], maxGap = 10` $\rightarrow$ `false` (Gap is 20 > 10)
- **Hints:**
  - What should happen if the list is empty or has only one element?
  - Be careful with strict inequality vs non-strict.

---

### Problem 2 (Level 1 — Conditions & Nullables): Safe Null-Coalescing Sanitizer
- **Problem Statement:**  
  You receive a list of nullable strings representing customer names input from legacy databases. Return a cleaned list containing only valid, trimmed names converted to uppercase, with all `null` or whitespace-only entries replaced by the literal `'ANONYMOUS'`.
- **Input:**
  - `List<String?> rawInputs`
- **Output:**
  - `List<String>`
- **Constraints:**
  - Length of list $0 \le N \le 10^4$.
- **Examples:**
  - *Example:* `['  ali ', null, '  ', 'sara']` $\rightarrow$ `['ALI', 'ANONYMOUS', 'ANONYMOUS', 'SARA']`
- **Hints:**
  - Leverage Dart's null-aware operators (`?.`, `??`) or explicit flow checks (`trim().isEmpty`).

---

### Problem 3 (Level 2 — Frequency & Collections): First Non-Repeating Transaction Code
- **Problem Statement:**  
  Given an array of alphanumeric transaction identifier strings, find and return the **first transaction identifier that appears exactly once** in the array. If no unique identifier exists, return `null`.
- **Input:**
  - `List<String> codes`
- **Output:**
  - `String?`
- **Constraints:**
  - $1 \le N \le 2 \times 10^5$.
  - Each code has length between 4 and 16 characters.
- **Examples:**
  - *Example 1:* `['TX_A', 'TX_B', 'TX_A', 'TX_C', 'TX_B']` $\rightarrow$ `'TX_C'`
  - *Example 2:* `['TX_X', 'TX_X']` $\rightarrow$ `null`
- **Hints:**
  - A naive nested loop takes $O(N^2)$ time and will Time Out on large inputs!
  - Consider two passes: one to count frequencies using a Map, and a second to find the first code with frequency 1.

---

### Problem 4 (Level 2 — Strings & Bucketing): Group Disordered Transaction Batches
- **Problem Statement:**  
  Two transaction tags are considered "equivalent batches" if one can be rearranged into another (anagrams, e.g., `'batch_ab'` and `'batch_ba'`). Given a list of transaction tag strings, group equivalent batches together.
- **Input:**
  - `List<String> tags`
- **Output:**
  - `List<List<String>>` (Order of groups does not matter).
- **Constraints:**
  - $1 \le tags.length \le 10^4$.
  - $1 \le tags[i].length \le 100$.
- **Examples:**
  - *Example:* `['eat', 'tea', 'tan', 'ate', 'nat', 'bat']` $\rightarrow$ `[['eat', 'tea', 'ate'], ['tan', 'nat'], ['bat']]`
- **Hints:**
  - What canonical representation can uniquely identify all anagrams of a string? (Sorting the characters or character frequency vector).

---

### Problem 5 (Level 3 — Two Pointers / Hash Map): Zero-Sum Transaction Offset Pair
- **Problem Statement:**  
  In financial settlement, offsetting transactions occur when one credit amount exactly balances a corresponding debit amount ($Amount_1 + Amount_2 = 0$). Given a list of non-zero integers representing transactions, determine if there exists at least one pair of distinct transactions that sum to zero. Return their indices as a 2-element list `[index1, index2]` with $index1 < index2$. If multiple pairs exist, return any one. If none exists, return `null`.
- **Input:**
  - `List<int> transactions`
- **Output:**
  - `List<int>?`
- **Constraints:**
  - $2 \le N \le 10^5$.
  - $-10^9 \le transactions[i] \le 10^9$, $transactions[i] \ne 0$.
- **Examples:**
  - *Example 1:* `[150, -40, 200, 40, -10]` $\rightarrow$ `[1, 3]` (Because `transactions[1] == -40` and `transactions[3] == 40`)
  - *Example 2:* `[10, 20, 30]` $\rightarrow$ `null`
- **Hints:**
  - Can you achieve $O(N)$ time using a HashMap storing values and their indices?

---

### Problem 6 (Level 4 — Sliding Window & Optimization): Minimum Transaction Window Exceeding Threshold
- **Problem Statement:**  
  Given an array of strictly positive integer transaction amounts `amounts` and a target liquidity threshold `threshold`, find the **minimal length of a contiguous subarray** of which the sum is greater than or equal to `threshold`. If there is no such subarray, return `0`.
- **Input:**
  - `int threshold` ($1 \le threshold \le 10^9$)
  - `List<int> amounts` ($1 \le amounts.length \le 10^5$)
- **Output:**
  - `int` (minimum length of matching contiguous subarray)
- **Constraints:**
  - Time complexity MUST be $O(N)$. $O(N^2)$ solutions will fail performance tests.
  - Auxiliary Space Complexity must be $O(1)$.
- **Examples:**
  - *Example 1:* `threshold = 7, amounts = [2, 3, 1, 2, 4, 3]` $\rightarrow$ `2` (Subarray `[4, 3]` sums to 7 with length 2)
  - *Example 2:* `threshold = 4, amounts = [1, 4, 4]` $\rightarrow$ `1` (Subarray `[4]` is length 1)
  - *Example 3:* `threshold = 11, amounts = [1, 1, 1, 1, 1]` $\rightarrow$ `0` (No subarray sums to $\ge 11$)
- **Hints:**
  - Use the Sliding Window (Two Pointers) technique.
  - Expand the right pointer to accumulate sum; once sum $\ge threshold$, shrink from the left to find minimal length.
