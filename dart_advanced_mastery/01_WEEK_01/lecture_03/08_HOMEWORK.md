# Homework Assignment — Lecture 03: Collections, Records & Patterns
> **إرشادات تسليم التكليف:**  
> يُرفع هذا التكليف في مستودع GitHub الخاص بالطالب قبل نهاية الأسبوع الأول.  
> التقييم الإجمالي: **25 نقطة**.

---

## القسم الأول: أسئلة الفهم النظري المعماري (5 أسئلة | 5 درجات | الوقت المقدر: 20 دقيقة)

1. **(درجة واحدة - سهلة):** اشرح ما هو الفارق بين الـ Spread Operator العادي `...` والـ Null-Aware Spread Operator `...?` في بناء القوائم.
2. **(درجة واحدة - متوسطة):** كيف تحافظ الـ Records في Dart 3 على الـ Sound Type Safety على عكس إرجاع `Map<String, dynamic>`؟
3. **(درجة واحدة - متوسطة):** ما هي الفائدة المعمارية لخاصية "Exhaustiveness Checking" عند استخدام `sealed class` مقارنة بالـ Abstract Classes العادية؟
4. **(درجة واحدة - صعبة):** فسر كيف تدعم الـ Records في Dart الـ Structural Equality والـ HashCode تلقائياً بدون كتابة دوال مقارنة.
5. **(درجة واحدة - صعبة):** ما الفرق بين "Destructuring" كعملية استخراج و"Pattern Matching" كعملية فحص شرطي واختبار لهيئة البيانات؟

---

## القسم الثاني: تتبع الكود واستخراج المخرجات (5 أسئلة | 5 درجات | الوقت المقدر: 25 دقيقة)

تتبع الأكواد التالية واكتب الناتج المتوقع مع التعليل الدقيق:

### السؤال 6:
```dart
void main() {
  final (x, y) = (100, 'Gold');
  final r2 = (100, 'Gold');
  print(r2 == (x, y));
}
```

### السؤال 7:
```dart
void main() {
  final list = [
    'A',
    if (false) 'B',
    for (var i = 1; i <= 2; i++) 'Item_$i',
  ];
  print(list.length);
}
```

### السؤال 8:
```dart
String matchVal(Object obj) => switch (obj) {
  (int a, int b) when a > b => 'GREATER',
  (int a, int b) => 'LESS_OR_EQUAL',
  _ => 'OTHER',
};

void main() {
  print(matchVal((10, 5)));
  print(matchVal((5, 10)));
}
```

### السؤال 9:
```dart
void main() {
  final json = {'user': 'omar', 'roles': ['ADMIN', 'SUPER']};
  if (json case {'user': String u, 'roles': [_, 'SUPER']}) {
    print('Super Admin: $u');
  } else {
    print('Standard');
  }
}
```

### السؤال 10:
```dart
void main() {
  var (a, b) = (1, 2);
  (a, b) = (b * 2, a * 2);
  print('$a and $b');
}
```

---

## القسم الثالث: مسائل حل المشكلات الخوارزمية (5 مسائل | 5 درجات | الوقت المقدر: 45 دقيقة)

11. **(درجة واحدة):** اكتب دالة تستقبل قائمة نصوص وتعيد أول وآخر عنصر كـ Record: `(String first, String last)?` أو `null` إذا كانت القائمة فارغة.
12. **(درجة واحدة):** اكتب دالة `bool hasDuplicates(List<int> numbers)` تفحص هل القائمة تحتوي على أي عناصر مكررة في زمن $O(N)$ باستخدام `Set`.
13. **(درجة واحدة):** اكتب دالة تستخدم Switch Expression لتصنيف زوايا المثلث `(int a, int b, int c)` إلى: حاد الزوايا، قائم، أو منفرج.
14. **(درجة واحدة):** اكتب دالة `List<(int, int)> generateCoordinateGrid(int width, int height)` تولد شبكة إحداثيات باستخدام Collection-for المتداخلة.
15. **(درجة واحدة):** اكتب دالة تفكك قائمة غير محددة الطول وتستخرج أول عنصر، وآخر عنصر، وقائمة العناصر الوسطى عبر Rest Pattern: `[first, ...middle, last]`.

---

## القسم الرابع: مهام مراجعة الكود (Code Review) (مهمتان | 4 درجات | الوقت المقدر: 20 دقيقة)

### المهمة 16 (Review Task 1):
```dart
// Review: Inefficient lookup and missing modern Dart features
bool verifyPermission(List<String> userPermissions, String target) {
  for (var p in userPermissions) {
    if (p == target) return true;
  }
  return false;
}
```

### المهمة 17 (Review Task 2):
```dart
// Review: Replace old manual parsing with modern Pattern Matching
String extractToken(Map<String, dynamic> response) {
  if (response.containsKey('auth')) {
    var auth = response['auth'];
    if (auth is Map && auth.containsKey('token')) {
      return auth['token'] as String;
    }
  }
  return 'NO_TOKEN';
}
```

---

## القسم الخامس: المهمة العملية التطبيقية (المهمة 18 | 6 درجات | الوقت المقدر: 40 دقيقة)

**المطلوب:** بناء محرك تقييم للشركات الناشئة `StartupEvaluationEngine`:
1. استخدام Sealed Class لنمذجة مراحل الشركة: `Bootstrapped`, `SeedFunded(amount)`, `SeriesA(amount, leadInvestor)`.
2. كتابة دالة `RiskAssessment` باستخدام Switch Expression تفحص مرحلة الشركة ومعدل الحرق المالي (Burn Rate) وتعيد Record يحتوي على: `(String riskLevel, int runwayMonths)`.
3. كتابة اختبارين آليين للتحقق من سلامة التقييم.
