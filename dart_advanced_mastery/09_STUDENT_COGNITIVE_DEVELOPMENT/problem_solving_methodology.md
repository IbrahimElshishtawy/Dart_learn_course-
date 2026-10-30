# Stanford-Style 12-Step Problem-Solving Methodology
## المنهجية الإلزامية لحل المشكلات البرمجية لمهندسي Dart

> **القانون الصارم للبرنامج:**  
> يُمنع منعاً باتاً البدء في كتابة كود Dart لحل أي مسألة أو تحدٍ قبل تدوين المراحل الخمس الأولى على الورق أو في ملف نصي. القفز مباشرة لكتابة الكود هو سلوك هواة يؤدي لضياع 80% من الوقت في تعديل أخطاء منطقية كان يمكن تفاديها بدقيقة تفكير واحدة.

---

## 1. خطوات المنهجية الاثنتا عشرة (The 12-Step Problem-Solving Pipeline)

```
┌────────────────────────────────────────────────────────────────────────┐
│ 1. إعادة صياغة المشكلة بأسلوبك الخاص (Problem Restatement)             │
├────────────────────────────────────────────────────────────────────────┤
│ 2. التوصيف الصارم للمدخلات والمخرجات (Formal I/O Specification)         │
├────────────────────────────────────────────────────────────────────────┤
│ 3. تحديد القيود الرياضية والزمنية (Constraints & Latency Budget)       │
├────────────────────────────────────────────────────────────────────────┤
│ 4. استخراج الحالات الحدية والشاذة (Edge Cases Identification)          │
├────────────────────────────────────────────────────────────────────────┤
│ 5. المحاكاة اليدوية بالأمثلة الصريحة (Manual Tracing & Dry Run)        │
├────────────────────────────────────────────────────────────────────────┤
│ 6. اقتراح حلين مختلفين على الأقل (Dual-Solution Ideation)              │
├────────────────────────────────────────────────────────────────────────┤
│ 7. حساب التعقيد الزمني والمكاني (Time & Space Complexity / Big O)      │
├────────────────────────────────────────────────────────────────────────┤
│ 8. اختيار الحل الأنسب وتبرير القرار (Approach Selection & Justification)│
├────────────────────────────────────────────────────────────────────────┤
│ 9. كتابة الثوابت المنطقية والـ Pseudocode (Invariants & Pseudocode)    │
├────────────────────────────────────────────────────────────────────────┤
│ 10. التنفيذ النظيف بلغة Dart 3.x (Clean Dart Implementation)           │
├────────────────────────────────────────────────────────────────────────┤
│ 11. الاختبار الآلي بالـ Asserts والـ Tests (Automated Assert Testing)  │
├────────────────────────────────────────────────────────────────────────┤
│ 12. المراجعة الهندسية والتحصين النهائي (Review, Refactor & Hardening)  │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 2. مثال تطبيقي عملي: تطبيق الخطوات الـ 12 على مسألة حقيقية

**المسألة:**  
لديك سجل لمعاملات مالية `List<int> transactions` تحتوي على مبالغ موجبة وسالبة. المطلوب إيجاد أقصى مجموع لمعاملات متتالية (Maximum Subarray Sum) بحيث نحدد الفترة الزمنية الأكثر ربحية للشركة.

---

### الخطوة 1: إعادة صياغة المشكلة (Problem Restatement)
- *صياغة الطالب:* "عندي قائمة أرقام، وعايز ألاقي شريحة متصلة من العناصر وراء بعض مجموعها يطلع أكبر رقم ممكن. لو كل الأرقام سالبة، هيكون الناتج هو أقل رقم سالب فيهم".

### الخطوة 2: توصيف المدخلات والمخرجات (Formal I/O Specification)
- **Input:** `List<int> nums` (قائمة أعداد صحيحة).
- **Output:** `int` يمثل أقصى مجموع شريحة متصلة.

### الخطوة 3: تحديد القيود (Constraints & Budgets)
- طول القائمة: $1 \le N \le 10^5$.
- قيمة كل معاملة: $-10^4 \le \text{nums}[i] \le 10^4$.
- الميزانية الزمنية: $O(N)$ كحد أقصى؛ لأن $O(N^2)$ ستستغرق $10^{10}$ عملية حسابية مما يؤدي لـ Timeout فوري!

### الخطوة 4: الحالات الحدية والشاذة (Edge Cases)
1. قائمة من عنصر واحد فقط: `[-5]` $\rightarrow$ الناتج `-5`.
2. جميع العناصر سالبة: `[-8, -3, -6, -2, -5]` $\rightarrow$ الناتج `-2`.
3. جميع العناصر موجبة: `[1, 2, 3, 4]` $\rightarrow$ الناتج `10` (مجموع القائمة بالكامل).
4. أرقام متذبذبة حول الصفر.

### الخطوة 5: المحاكاة اليدوية (Manual Dry Run)
- نجرب يدوياً على: `[-2, 1, -3, 4, -1, 2, 1, -5, 4]`
- نلاحظ: عند الوصول لـ 4، نبدأ شريحة جديدة لأن ما قبلها كان مجموعه سالباً ويضر بالمجموع اللاحق. الشريحة `[4, -1, 2, 1]` مجموعها 6 وهو الأكبر.

### الخطوة 6: اقتراح حلين مختلفين (Dual-Solution Ideation)
- **الحل الأول (Naive / Brute Force):** فحص جميع الشرائح الممكنة عبر حلقة ثنائية `for (i) { for (j) { ... } }`.
- **الحل الثاني (Optimized / Kadane's Algorithm):** المرور مرة واحدة وتحديد: هل أضم العنصر الحالي للشريحة السابقة أم أبدأ شريحة جديدة منه؟

### الخطوة 7: حساب التعقيد الحسابي (Complexity Analysis)
- **الحل الأول:**
  - Time Complexity: $O(N^2)$.
  - Space Complexity: $O(1)$.
- **الحل الثاني:**
  - Time Complexity: $O(N)$ — فحص كل عنصر مرة واحدة فقط.
  - Space Complexity: $O(1)$ — استخدام متغيرين فقط لتتبع المجموع الحالي والأقصى.

### الخطوة 8: اختيار الحل وتبرير القرار (Approach Selection)
- نختار **الحل الثاني (خوارزمية كادان - Kadane's Algorithm)**؛ لأن $N = 10^5$ تستغرق في $O(N)$ أقل من 5 ميلي ثانية في بيئة Dart AOT، بينما $O(N^2)$ تتجاوز 10 ثوانٍ وتفشل في بيئات الإنتاج.

### الخطوة 9: كتابة الـ Invariants والـ Pseudocode
- **المبدأ الثابت (Loop Invariant):** عند أي مؤشر $i$، يمثل `currentSum` أقصى مجموع شريحة تنتهي عند العنصر $i$.
```text
function maxSubArray(nums):
  maxSoFar = nums[0]
  currentSum = nums[0]
  for i from 1 to length - 1:
    currentSum = max(nums[i], currentSum + nums[i])
    maxSoFar = max(maxSoFar, currentSum)
  return maxSoFar
```

### الخطوة 10: التنفيذ النظيف بلغة Dart (Clean Dart Implementation)
```dart
import 'dart:math' as math;

/// Computes the maximum contiguous subarray sum using Kadane's Algorithm.
///
/// Precondition: [nums] must not be empty.
/// Time Complexity: O(N) where N is the length of [nums].
/// Space Complexity: O(1) auxiliary heap allocation.
int findMaxSubarraySum(List<int> nums) {
  if (nums.isEmpty) {
    throw ArgumentError.value(nums, 'nums', 'Transaction list must not be empty');
  }

  int currentSum = nums[0];
  int maxSoFar = nums[0];

  for (int i = 1; i < nums.length; i++) {
    final transaction = nums[i];
    // Either extend the previous subarray or start fresh from current element
    currentSum = math.max(transaction, currentSum + transaction);
    maxSoFar = math.max(maxSoFar, currentSum);
  }

  return maxSoFar;
}
```

### الخطوة 11: الاختبار الآلي والحالات الحدية (Automated Verification)
```dart
void main() {
  // Test Case 1: Standard Mixed
  assert(findMaxSubarraySum([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6, 'TC1 Failed');

  // Test Case 2: All Negatives (Boundary)
  assert(findMaxSubarraySum([-8, -3, -6, -2, -5]) == -2, 'TC2 Failed');

  // Test Case 3: Single Element
  assert(findMaxSubarraySum([-42]) == -42, 'TC3 Failed');

  // Test Case 4: All Positives
  assert(findMaxSubarraySum([1, 2, 3, 4]) == 10, 'TC4 Failed');

  print('✅ All 12-Step Verification Asserts Passed Successfully!');
}
```

### الخطوة 12: المراجعة الهندسية والتحصين النهائي (Review & Hardening)
- تم التحقق من:
  1. الـ Type Safety التام (عدم وجود `dynamic` أو Nulls غير معالجة).
  2. التعامل مع القائمة الفارغة برمي `ArgumentError` وصفي بدلاً من انهيار مفاجئ بـ `RangeError`.
  3. استهلاك الذاكرة هو $O(1)$ مع عدم إنشاء أي كائنات جديدة في الـ Heap أثناء الدوران.
