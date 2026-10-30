# Weekly Problem Solving Challenge 01 — Week 01

## 🧠 التحدي الخوارزمي: Maximum Product Contiguous Subarray with Sign Inversion

### 1. وصف المسألة (Problem Statement)
Given an integer array `nums`, find a contiguous non-empty subarray within the array that has the **largest product**, and return that maximum product.
Because the array can contain negative numbers and zero, a negative number multiplied by another negative number turns into a positive product, making naive greedy approaches fail.

You must implement an optimal algorithm running in **$O(N)$ Time Complexity** and **$O(1)$ Auxiliary Space Complexity**, returning a structured Record:
```dart
typedef SubarrayProductResult = ({int maxProduct, int startIndex, int endIndex});
```

---

### 2. الشروط والقيود (Constraints)
- $1 \le nums.length \le 2 \times 10^4$.
- $-10 \le nums[i] \le 10$.
- The product of any prefix or suffix of `nums` is guaranteed to fit in a 64-bit integer.
- Time Limit: 1.0 second.
- Memory Limit: 64 MB.

---

### 3. أمثلة توضيحية (Examples)
- **Example 1:**
  - *Input:* `nums = [2, 3, -2, 4]`
  - *Output:* `maxProduct = 6` (Subarray `[2, 3]`).
- **Example 2:**
  - *Input:* `nums = [-2, 0, -1]`
  - *Output:* `maxProduct = 0` (The largest product is `0`).
- **Example 3:**
  - *Input:* `nums = [-2, 3, -4]`
  - *Output:* `maxProduct = 24` (Subarray `[-2, 3, -4]`, since $(-2) \times 3 \times (-4) = 24$).

---

### 4. تلميحات توجيهية (Hints)
1. في كل خطوة، الاحتفاظ بأكبر قيمة موجبة `maxSoFar` وأصغر قيمة سالبة `minSoFar` ضروري، لأن ضرب رقم سالب جديد في أصغر رقم سالب ينتج أكبر رقم موجب!
2. عند مقابلة رقم سالب، قم بتبديل `maxSoFar` و`minSoFar` فوراً باستخدام Record swap: `(maxSoFar, minSoFar) = (minSoFar, maxSoFar)`.
3. عند مقابلة الصفر، يتم إعادة ضبط الحسابات إلى `nums[i]`.
