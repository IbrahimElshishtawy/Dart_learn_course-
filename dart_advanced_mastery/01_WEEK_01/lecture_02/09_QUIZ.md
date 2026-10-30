# Quiz Assessment — Lecture 02: Functions, Scope & Execution Model
> **تعليمات الاختبار:**  
> - مدة الاختبار: 20 دقيقة.  
> - الدرجة الكلية: 15 درجة.  
> - أجب عن الأسئلة بدقة دون الاستعانة بالـ IDE.

---

## الجزء الأول: أسئلة الاختيار من متعدد (MCQ) — 10 أسئلة (5 درجات)

1. **ماذا تعني ميزة "First-Class Functions" في Dart؟**
   - (A) الدوال يمكن كتابتها فقط داخل الـ Classes.
   - (B) الدوال تُعامل كقيم برمجية يمكن تخزينها في متغيرات وتمريرها وإرجاعها.
   - (C) الدوال تُنفذ دائماً قبل أي كود آخر في البرنامج.
   - (D) الدوال لا تقبل سوى معاملات ذات أنواع أساسية (Primitives).

2. **أي من الدوال التالية تستخدم صيغة الـ Tear-off بشكل صحيح؟**
   - (A) `list.forEach((x) => print(x));`
   - (B) `list.forEach(print());`
   - (C) `list.forEach(print);`
   - (D) `list.forEach(-> print);`

3. **إذا تم تعريف معامل مسمى بدون كلمة `required` ولم يكن Nullable، ما الذي يفرضه المترجم؟**
   - (A) يجب توفير قيمة افتراضية (Default Value) في وقت التجميع.
   - (B) يتم تحويله تلقائياً إلى نوع `dynamic`.
   - (C) يقبل القيمة `null` تلقائياً.
   - (D) يفشل في الـ Runtime فقط.

4. **ما الذي يحدث للمتغير المحلي الذي يتم التقاطه (Captured) بواسطة Closure؟**
   - (A) يتم حذفه من الذاكرة فور انتهاء الدالة المنشئة له.
   - (B) يتم نقله وتخصيصه على الـ Heap ليظل حياً مع الـ Closure.
   - (C) يتحول إلى متغير Global في كل أنحاء البرنامج.
   - (D) يتسبب في `StackOverflowError`.

5. **في لغة Dart، ما هي الصياغة الصحيحة للـ Constructor Tear-off لكلاس `Person`؟**
   - (A) `Person::new`
   - (B) `Person.new`
   - (C) `new Person()`
   - (D) `Person.constructor`

6. **أي مما يلي يعتبر خاصية للدالة النقية (Pure Function)؟**
   - (A) تقوم بتعديل متغيرات خارج نطاقها المحلي.
   - (B) تعتمد على الوقت الحالي `DateTime.now()` في حساباتها.
   - (C) تعطي نفس المخرجات دائماً لنفس المدخلات وخالية من الـ Side Effects.
   - (D) يجب أن تكون دالة غير متزامنة `async`.

7. **ما هو ناتج استدعاء دالة تقبل معاملات اختيارية موضعية `[int a = 5, int b = 10]` بدون تمرير معاملات؟**
   - (A) ترمي `ArgumentError`.
   - (B) تأخذ `a = 5` و`b = 10`.
   - (C) تأخذ `a = null` و`b = null`.
   - (D) تفشل في مرحلة الـ Compilation.

8. **ما هو المصطلح الذي يصف تحويل دالة متعددة المعاملات $f(a, b)$ إلى دوال متداخلة $f(a)(b)$؟**
   - (A) Canonicalization.
   - (B) Currying.
   - (C) Polymorphism.
   - (D) Reflection.

9. **كيف يتم الإعلان عن نوع دالة تقبل `int` وترجع `String` باستخدام `typedef`؟**
   - (A) `typedef MyFunc = String(int);`
   - (B) `typedef MyFunc = String Function(int);`
   - (C) `typedef MyFunc(int) -> String;`
   - (D) `typedef Function<int, String> MyFunc;`

10. **أين تُحفظ الـ Stack Frames أثناء تنفيذ الدوال في Dart؟**
    - (A) في الـ Call Stack.
    - (B) في الـ Heap Memory.
    - (C) في الـ Event Queue.
    - (D) في ملفات القرص الصلب.

---

## الجزء الثاني: أسئلة صح أم خطأ (True / False) — 5 أسئلة (2.5 درجات)

11. [ ] يمكن للدالة في Dart أن تحتوي على Optional Positional Parameters وNamed Parameters في نفس الوقت.
12. [ ] الـ Tear-offs توفر استهلاكاً للذاكرة مقارنةً بإنشاء Anonymous Lambdas غير ضرورية.
13. [ ] حلقة `for (var i = 0; i < 3; i++)` في Dart تشارك نفس متغير `i` في الذاكرة لكل الـ Closures الناتجة.
14. [ ] الدالة التي تطبع على الشاشة `print('Hello')` تعتبر دالة نقية (Pure Function).
15. [ ] دالة الـ Callback يمكن تمريرها كمعامل لدالة أخرى لأن الدوال في Dart كائنات (Objects).

---

## الجزء الثالث: توقع المخرجات (Code Output) — 5 أسئلة (2.5 درجات)

### 16. ما ناتج الكود التالي؟
```dart
int Function(int) multiplier(int m) => (x) => x * m;
void main() {
  final times3 = multiplier(3);
  print(times3(10));
}
```

### 17. ما ناتج الكود التالي؟
```dart
void greet(String name, [String greeting = 'Hello']) {
  print('$greeting, $name!');
}
void main() {
  greet('Sarah');
}
```

### 18. ما ناتج الكود التالي؟
```dart
void main() {
  var x = 10;
  void mutate() {
    x += 5;
  }
  mutate();
  print(x);
}
```

### 19. ما ناتج الكود التالي؟
```dart
void main() {
  int compute(int Function(int) f, int val) => f(val) * 2;
  print(compute((n) => n + 3, 4));
}
```

### 20. ما ناتج الكود التالي؟
```dart
void main() {
  final list = ['dart', 'flutter'];
  list.map((s) => s.toUpperCase()).forEach(print);
}
```

---

## الجزء الرابع: تصحيح الأخطاء (Debugging) — 3 أسئلة (3 درجات)

21. **حدد الخطأ البرمجي في تعريف الدالة:**
    ```dart
    void calculate({int a, int b}) {
      print(a + b);
    }
    ```

22. **حدد سبب الخطأ في استدعاء الدالة:**
    ```dart
    void printDetails(String name, [int age = 20]) {
      print('$name: $age');
    }
    void main() {
      printDetails('Ali', age: 25);
    }
    ```

23. **حدد العيب المعماري في الدالة التالية:**
    ```dart
    int totalTax = 0;
    int calculateTax(int income) {
      totalTax += (income * 0.1).toInt();
      return totalTax;
    }
    ```

---

## الجزء الخامس: الأسئلة العملية القصيرة (Practical) — سؤالان (2 درجتان)

24. اكتب دالة بسيطة `List<int> filterEven(List<int> numbers)` تستخدم دالة الـ HOF `where` مع Tear-off إن أمكن أو lambda نقية لإرجاع الأعداد الزوجية فقط.

25. صمم دالة Higher-Order بعنوان `bool Function(int) createRangeChecker(int min, int max)` تعيد دالة تفحص هل الرقم يقع داخل النطاق المغلق $[min, max]$.
