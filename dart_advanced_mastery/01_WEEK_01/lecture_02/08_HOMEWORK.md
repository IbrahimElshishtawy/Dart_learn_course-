# Homework Assignment — Lecture 02: Functions, Scope & Execution Model
> **إرشادات تسليم التكليف:**  
> يُرفع هذا التكليف في مستودع GitHub الخاص بالطالب قبل موعد المحاضرة القادمة.  
> التقييم الإجمالي: **25 نقطة**.

---

## القسم الأول: أسئلة الفهم النظري المعماري (5 أسئلة | 5 درجات | الوقت المقدر: 20 دقيقة)

1. **(درجة واحدة - سهلة):** ما الفرق بين الدالة المجهولة (Anonymous Lambda Function) والدالة المسماة (Named Function) في لغة Dart؟
2. **(درجة واحدة - متوسطة):** اشرح آلية انتقال المتغيرات من الـ Call Stack إلى الـ Heap Memory عندما يتم التقاطها داخل كائن Closure.
3. **(درجة واحدة - متوسطة):** ما الفارق بين الـ Method Tear-off والـ Constructor Tear-off، ولماذا توفر كلاهما أداءً أفضل من الـ Lambdas المكررة؟
4. **(درجة واحدة - صعبة):** فسر مفهوم "Lexical Scope" وكيف يقوم Dart Compiler بتحديد نطاق الرؤية للمتغيرات في الكود المتداخل.
5. **(درجة واحدة - صعبة):** كيف تؤثر الـ Closures المحتفظة بـ `this` على الـ Garbage Collector، وما هو الخطر المعماري المصاحب لذلك؟

---

## القسم الثاني: تتبع الكود واستخراج المخرجات (5 أسئلة | 5 درجات | الوقت المقدر: 25 دقيقة)

تتبع الأكواد التالية بدون تشغيلها على الـ IDE واكتب الناتج المتوقع مع التعليل الدقيق:

### السؤال 6:
```dart
void Function() makeLogger(String prefix) {
  int counter = 0;
  return () {
    counter++;
    print('$prefix: $counter');
  };
}

void main() {
  final logA = makeLogger('DEV');
  final logB = makeLogger('PROD');
  logA();
  logA();
  logB();
  logA();
}
```

### السؤال 7:
```dart
void main() {
  final numbers = [10, 20, 30];
  final fns = <int Function()>[];

  for (var n in numbers) {
    fns.add(() => n * 2);
  }

  for (var f in fns) {
    print(f());
  }
}
```

### السؤال 8:
```dart
int Function(int) curriedAdd(int a) => (int b) => a + b;

void main() {
  final addFive = curriedAdd(5);
  print(addFive(15));
  print(curriedAdd(10)(20));
}
```

### السؤال 9:
```dart
String format({required String text, String prefix = '>>', bool uppercase = false}) {
  final result = '$prefix $text';
  return uppercase ? result.toUpperCase() : result;
}

void main() {
  print(format(text: 'alert', uppercase: true));
}
```

### السؤال 10:
```dart
void main() {
  var multiplier = 2;
  int calculate(int x) => x * multiplier;

  print(calculate(4));
  multiplier = 5;
  print(calculate(4));
}
```

---

## القسم الثالث: مسائل حل المشكلات الخوارزمية (5 مسائل | 5 درجات | الوقت المقدر: 45 دقيقة)

11. **(درجة واحدة):** اكتب دالة `List<R> myMap<T, R>(List<T> list, R Function(T) mapper)` تحاكي دالة `map()` الأصلية باستخدام حلقة وظيفية.
12. **(درجة واحدة):** اكتب دالة `T myReduce<T>(List<T> list, T Function(T acc, T element) combiner)` تطبق دمج عناصر القائمة بدون استخدام `reduce` الجاهزة.
13. **(درجة واحدة):** اكتب دالة `bool Function(String) createPrefixMatcher(String prefix)` ترجع دالة تفحص هل النص يبدأ بالبادئة المحددة أم لا.
14. **(درجة واحدة):** اكتب دالة `List<int> takeWhileFunctional(List<int> list, bool Function(int) predicate)` تأخذ العناصر المتتالية من بداية القائمة طالما الشرط محقق.
15. **(درجة واحدة):** اكتب دالة `int Function() createFibonacciGenerator()` ترجع في كل استدعاء الرقم التالي في متتالية فيبوناتشي باستخدام الـ Closures.

---

## القسم الرابع: مهام مراجعة الكود (Code Review) (مهمتان | 4 درجات | الوقت المقدر: 20 دقيقة)

### المهمة 16 (Review Task 1):
```dart
class DataFetcher {
  List<String> cache = [];
  void fetchAndProcess(List<String> rawItems) {
    // Review: Look at the closure and list mutation
    rawItems.forEach((item) {
      cache.add(item.toUpperCase());
    });
  }
}
```

### المهمة 17 (Review Task 2):
```dart
void sendEmail({String recipient, String subject = 'No Subject', String body}) {
  // Review: Null safety annotations and required parameters
  print('Sending to $recipient: $subject\n$body');
}
```

---

## القسم الخامس: المهمة العملية التطبيقية (المهمة 18 | 6 درجات | الوقت المقدر: 40 دقيقة)

**المطلوب:** بناء `LoggingMiddlewareInterceptor`:
- دالة ذات رتبة عليا تستقبل أي دالة `T Function(T)` وتعيد دالة مطابقة تقوم بـ:
  1. طباعة وقت وتاريخ بداية التنفيذ.
  2. قياس الوقت المستغرق بالميكروثانية باستخدام `Stopwatch`.
  3. طباعة المدخلات والمخرجات.
  4. التقاط ومعالجة أي استثناء وإعادة رميه بعد تسجيله.
- كتابة اختبارين آليين للتحقق من عمل الـ Interceptor.
