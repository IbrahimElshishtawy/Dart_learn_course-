# Homework Assignment — Lecture 01: Language Architecture & Type System
> **إرشادات تسليم التكليف:**  
> يُرفع هذا التكليف في مستودع GitHub الخاص بالطالب قبل بداية المحاضرة القادمة.  
> التقييم الإجمالي: **25 نقطة**.

---

## القسم الأول: أسئلة الفهم النظري المعماري (5 أسئلة | 5 درجات | الوقت المقدر: 20 دقيقة)

1. **(درجة واحدة - سهلة):** اشرح ما الفرق بين مرحلة التجميع JIT ومرحلة التجميع AOT في لغة Dart، ولماذا تستخدم Dart كلاً منهما في مراحل مختلفة؟
2. **(درجة واحدة - متوسطة):** ما هي الخاصية الرياضية التي تجعل Dart Sound Null Safe مقارنةً بـ TypeScript التي قد تسمح بـ Type Bypassing؟
3. **(درجة واحدة - متوسطة):** فسر مفهوم الـ **Canonicalization** في كائنات `const` وما هو دوره في تخفيف عبء الـ Garbage Collector؟
4. **(درجة واحدة - صعبة):** متى يفشل الـ Flow Analyzer في عمل Type Promotion لحقل كلاس (Class Field) غير معرف كـ `final`؟
5. **(درجة واحدة - صعبة):** اشرح الغرض الهندسي من النوع `Never` وكيف يستفيد منه المترجم في تحليل الكود الميت (Dead Code Detection).

---

## القسم الثاني: تتبع الكود واستخراج المخرجات (5 أسئلة | 5 درجات | الوقت المقدر: 25 دقيقة)

تتبع الأكواد التالية بدون تشغيلها على الـ IDE واكتب الناتج المتوقع مع التعليل الدقيق:

### السؤال 6:
```dart
void main() {
  const a = [1, 2, 3];
  const b = [1, 2, 3];
  final c = [1, 2, 3];

  print(identical(a, b));
  print(identical(a, c));
}
```

### السؤال 7:
```dart
void main() {
  int? count;
  count ??= 10;
  count ??= 20;
  print(count);
}
```

### السؤال 8:
```dart
void main() {
  dynamic value = '100';
  Object safeValue = value;
  // What happens here?
  if (safeValue is int) {
    print(safeValue + 50);
  } else {
    print('Not an integer');
  }
}
```

### السؤال 9:
```dart
class Worker {
  late final String task = _computeTask();

  String _computeTask() {
    print('Task Computed');
    return 'CLEAN_UP';
  }
}

void main() {
  print('Creating Worker...');
  final w = Worker();
  print('Worker Created.');
  print('Task: ${w.task}');
  print('Task Again: ${w.task}');
}
```

### السؤال 10:
```dart
Never raise(String msg) => throw FormatException(msg);

void check(int? val) {
  if (val == null) raise('Value is null');
  print('Value is: ${val + 10}');
}

void main() {
  check(5);
}
```

---

## القسم الثالث: مسائل حل المشكلات الخوارزمية (5 مسائل | 5 درجات | الوقت المقدر: 45 دقيقة)

اكتب دوال Dart نظيفة لحل المسائل التالية داخل مجلد `homework/`:

11. **(درجة واحدة):** اكتب دالة `bool isStrictlyIncreasing(List<int> numbers)` تتحقق مما إذا كانت الأرقام تتصاعد بدقة دون تكرار.
12. **(درجة واحدة):** اكتب دالة `String coalesceFirstNonNull(List<String?> items, String fallback)` تعيد أول نص غير فارغ وغير null.
13. **(درجة واحدة):** اكتب دالة `Map<String, int> countWordFrequency(String sentence)` تقوم بإحصاء تكرار كل كلمة مع تجاهل حالة الأحرف.
14. **(درجة واحدة):** اكتب دالة `bool hasComplementPair(List<int> sortedList, int target)` تحدد هل يوجد عنصران مجموعهما `target` بتعقيد زمني $O(N)$ واستخدام تقنية Two Pointers.
15. **(درجة واحدة):** اكتب دالة `int maxSubarraySum(List<int> nums)` تطبق خوارزمية Kadane لإيجاد أكبر مجموع لمصفوفة متصلة بتعقيد $O(N)$ وذاكرة $O(1)$.

---

## القسم الرابع: مهام مراجعة الكود (Code Review) (مهمتان | 4 درجات | الوقت المقدر: 20 دقيقة)

قم بمراجعة الكودين التاليين كأنك Senior Engineer، واذكر العيوب ونقاط الضعف واقترح الكود المصحح:

### المهمة 16 (Review Task 1):
```dart
class PaymentManager {
  dynamic clientIban;
  double? transferLimit;
  late double currentBalance;

  void pay(double amt) {
    if (amt > transferLimit!) {
      print('Exceeded limit');
      return;
    }
    currentBalance = currentBalance - amt;
  }
}
```

### المهمة 17 (Review Task 2):
```dart
double calculateFinalPrice(double price, double? discountPercent) {
  if (discountPercent != null) {
    return price - (price * (discountPercent / 100));
  } else {
    return price;
  }
}
```

---

## القسم الخامس: المهمة العملية التطبيقية (المهمة 18 | 6 درجات | الوقت المقدر: 40 دقيقة)

**المطلوب:** بناء فئة `SafeApiKeyVault` لإدارة مفاتيح الـ API في تطبيق مالي:
1. المفاتيح يجب أن تكون سرية ومشفرة وغير قابلة للتعديل (`immutable`).
2. دعم الـ Lazy Initialization لتحميل المفاتيح فقط عند أول طلب.
3. التحقق من أن المفتاح لا يقل طوله عن 32 حرفاً ولا يحتوي على مسافات.
4. كتابة اختبارين آليين (Unit Tests) للتحقق من رفض المفاتيح الضعيفة ونجاح المفاتيح السليمة.
