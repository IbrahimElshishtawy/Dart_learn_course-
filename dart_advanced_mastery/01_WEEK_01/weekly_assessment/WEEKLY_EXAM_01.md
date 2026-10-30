# Weekly Comprehensive Exam 01 — Week 01 (Foundations & Modern Syntax)
> **توجيهات الاختبار الأسبوعي:**  
> - مدة الاختبار: 60 دقيقة.  
> - الدرجة الكلية: 40 درجة.  
> - يغطي الاختبار: معمارية المترجم والـ VM، الـ Sound Null Safety، الـ Functions والـ Closures، والـ Collections والـ Records والـ Patterns.

---

## القسم الأول: الأسئلة النظرية المعمارية (10 درجات)
1. **(درجتان):** اشرح خط إنتاج مترجم Dart من الكود المصدري حتى الـ Native Machine Code، موضحاً دور CFE وKernel وJIT وAOT.
2. **(درجتان):** قارن بين `var` و`Object` و`dynamic` و`Never` مع ذكر مثال لكل منها في الـ Type Hierarchy.
3. **(درجتان):** ما هي المعجزة المعمارية لـ Sound Null Safety وكيف يستغلها المترجم في تحسين الأداء وتقليل حجم التطبيق؟
4. **(درجتان):** فسر مفهوم الـ Lexical Closure: أين تعيش المتغيرات الملتقطة، ولماذا لا تُحذف بانتهاء الـ Stack Frame للدالة الأب؟
5. **(درجتان):** اشرح ما هي الـ Records في Dart 3 وما الفارق بين المساواة المرجعية (Reference Identity) والمساواة الهيكلية (Structural Equality)؟

---

## القسم الثاني: تحليل وتتبع الكود (Code Tracing) (10 درجات)

### السؤال 6 (درجتان):
تتبع المخرجات مع الشرح:
```dart
void main() {
  const p1 = (10, 20);
  const p2 = (10, 20);
  final p3 = (10, 20);

  print(identical(p1, p2));
  print(identical(p1, p3));
  print(p1 == p3);
}
```

### السؤال 7 (درجتان):
تتبع المخرجات مع الشرح:
```dart
void main() {
  var x = 5;
  int Function() generate() {
    return () => x += 10;
  }
  final fn1 = generate();
  final fn2 = generate();
  print('${fn1()} - ${fn2()} - $x');
}
```

### السؤال 8 (درجتان):
تتبع ناتج الـ Pattern Matching:
```dart
String inspect(Object? val) => switch (val) {
  {'type': 'ALERT', 'code': >= 500} => 'SERVER_ERROR',
  {'type': 'ALERT', 'code': >= 400} => 'CLIENT_ERROR',
  [String first, ...final rest] when rest.isNotEmpty => 'LIST_HEAD_${first}_TAIL_${rest.length}',
  _ => 'UNKNOWN',
};

void main() {
  print(inspect({'type': 'ALERT', 'code': 503}));
  print(inspect(['ROOT', 'NODE1', 'NODE2']));
}
```

### السؤال 9 (درجتان):
هل سيمر هذا الكود من الـ Compiler أم سيفشل؟ ولماذا؟
```dart
sealed class Shape {}
class Circle extends Shape { final double r; Circle(this.r); }
class Square extends Shape { final double s; Square(this.s); }

double area(Shape shape) => switch (shape) {
  Circle(:final r) => 3.14 * r * r,
  Square(:final s) => s * s,
};
```

### السؤال 10 (درجتان):
ما ناتج الكود التالي:
```dart
void main() {
  final raw = ['a', 'b'];
  final combined = [
    ...raw,
    if (raw.length > 5) 'EXTRA',
    for (var char in raw) char.toUpperCase(),
  ];
  print(combined.join(', '));
}
```

---

## القسم الثالث: تصحيح أخطاء الأنظمة (System Debugging) (10 درجات)

### السؤال 11 (5 درجات):
قام مبرمج مبتدئ بكتابة دالة لمعالجة خصومات العملاء؛ راجع الكود، استخرج 3 أخطاء معمارية ونوعية، وأعد كتابته بأفضل ممارسات Dart 3:
```dart
class DiscountCalculator {
  dynamic userTier;
  late double calculatedDiscount;

  void apply(double cartTotal, dynamic promo) {
    if (promo != null && promo == 'VIP100') {
      calculatedDiscount = cartTotal;
    } else if (userTier == 'GOLD') {
      calculatedDiscount = cartTotal * 0.2;
    }
    print('Discount: $calculatedDiscount');
  }
}
```

### السؤال 12 (5 درجات):
الكود التالي يفشل في مرحلة الـ Runtime عند تشغيله تحت ضغط عالي؛ اكتشف سبب الانهيار واكتب الحل الصحيح:
```dart
String formatUserData(Map<String, dynamic> json) {
  final name = json['user']['name']!;
  final score = json['user']['score'] as int;
  return '$name has score $score';
}
```

---

## القسم الرابع: التصميم البرمجي التطبيقي (10 درجات)

### السؤال 13 (10 درجات):
صمم نظام فحص وتوجيه طلبات بنكية `BankTransferRouter`:
1. استخدم `Record` لتمثيل كائن المعاملة `(String id, double amount, String sourceCountry)`.
2. استخدم `Switch Expression` مع Guard Clauses لتقسيم المعاملات:
   - أي معاملة من `'EGYPT'` أكبر من 100,000 تعود بـ `'LOCAL_HIGH_VALUE'`.
   - أي معاملة من دولة أخرى تعود بـ `'INTERNATIONAL_CROSS_BORDER'`.
   - أي معاملة سالبة أو صفر ترمي استثناء فورياً عبر دالة ترجع `Never`.
3. اكتب كود Dart كامل وقابل للتشغيل.
