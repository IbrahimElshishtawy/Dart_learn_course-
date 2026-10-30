# Problem Solving Bank — Lecture 02 (Stanford CS-Style)
> **ملاحظة للمتدرب:** هذه النسخة مخصصة لك لحل المسائل بشكل مستقل وتطوير مهارات التفكير المنطقي والبرمجة الوظيفية. لا توجد حلول داخل هذا الملف.

---

### Problem 1 (Level 1 — Higher-Order Partition): Functional List Partition
- **Problem Statement:**  
  Write a higher-order function `(List<T>, List<T>) partition<T>(List<T> list, bool Function(T) predicate)` that splits an input list into a Record of two separate lists: the first containing all elements satisfying `predicate`, and the second containing all elements that do not.
- **Constraints:**
  - Length $0 \le N \le 10^5$.
  - Time complexity must be $O(N)$.
  - Original element relative order must be preserved.
- **Examples:**
  - `partition([1, 2, 3, 4, 5, 6], (n) => n.isEven)` $\rightarrow$ `([2, 4, 6], [1, 3, 5])`

---

### Problem 2 (Level 1 — Functional Composition): Mathematical Function Chainer
- **Problem Statement:**  
  Write a function `int Function(int) chainFunctions(List<int Function(int)> functions)` that accepts a list of unary integer functions $[f_1, f_2, \dots, f_k]$ and returns a single composed function executing them from left to right: $f_k(\dots f_2(f_1(x))\dots)$. If the list is empty, return the identity function $x \mapsto x$.
- **Examples:**
  - `add1(x) => x + 1`, `doubleIt(x) => x * 2`.
  - `chainFunctions([add1, doubleIt])(4)` $\rightarrow$ `doubleIt(add1(4)) = doubleIt(5) = 10`.

---

### Problem 3 (Level 2 — Closure-Based Memoization): Generic Memoize Wrapper
- **Problem Statement:**  
  In computational systems, expensive pure functions are frequently called with identical arguments. Write a higher-order function `R Function(T) memoize<T, R>(R Function(T) computeFn)` that caches function results in an enclosed map. Subsequent calls with the same argument must return the cached result in $O(1)$ time without executing `computeFn`.
- **Examples:**
  - `var calls = 0; final cached = memoize((int x) { calls++; return x * x; });`
  - `cached(5)` $\rightarrow$ `25 (calls == 1)`
  - `cached(5)` $\rightarrow$ `25 (calls == 1, cached!)`

---

### Problem 4 (Level 2 — Frequency & Reducer): Functional Group By
- **Problem Statement:**  
  Implement a pure higher-order function `Map<K, List<T>> groupBy<T, K>(List<T> items, K Function(T) keySelector)` that groups elements of a collection according to a key-extraction function.
- **Examples:**
  - `groupBy(['apple', 'banana', 'avocado', 'cherry'], (s) => s[0])`  
    $\rightarrow$ `{'a': ['apple', 'avocado'], 'b': ['banana'], 'c': ['cherry']}`

---

### Problem 5 (Level 3 — Two Pointers & Predicates): In-Place Functional Compaction
- **Problem Statement:**  
  Given an integer array `nums` and a predicate `bool Function(int) shouldRemove`, remove all elements satisfying the predicate **in-place** (without allocating a new array) and return the new length $K$. The first $K$ elements of `nums` must contain the retained elements.
- **Constraints:**
  - Time Complexity: $O(N)$.
  - Auxiliary Space Complexity: $O(1)$.
- **Examples:**
  - `nums = [3, 2, 2, 3], shouldRemove = (x) => x == 3` $\rightarrow$ returns $K = 2$, with `nums` starting with `[2, 2]`.

---

### Problem 6 (Level 4 — Functional Stack Evaluation): Reverse Polish Notation Evaluator
- **Problem Statement:**  
  Evaluate the value of an arithmetic expression in **Reverse Polish Notation (Postfix Notation)**. Valid operators are `+`, `-`, `*`, `/` (integer division truncating toward zero). Each operand may be an integer or another expression. Use a stack-based functional approach.
- **Constraints:**
  - $1 \le tokens.length \le 10^4$.
  - Division by zero will not occur.
- **Examples:**
  - `["2", "1", "+", "3", "*"]` $\rightarrow$ `((2 + 1) * 3) = 9`
  - `["4", "13", "5", "/", "+"]` $\rightarrow$ `(4 + (13 / 5)) = 4 + 2 = 6`
