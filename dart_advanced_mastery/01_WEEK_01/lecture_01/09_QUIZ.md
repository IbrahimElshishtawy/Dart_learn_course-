# Quiz Assessment — Lecture 01: Language Architecture & Type System
> **تعليمات الاختبار:**  
> - مدة الاختبار: 20 دقيقة.  
> - الدرجة الكلية: 15 درجة.  
> - أجب عن الأسئلة بدقة دون الاستعانة بالـ IDE.

---

## الجزء الأول: أسئلة الاختيار من متعدد (MCQ) — 10 أسئلة (5 درجات)

1. **ما الذي يحدث عند الإعلان عن متغير باستخدام `var x = 'Dart 3';`؟**
   - (A) يصبح نوع المتغير `dynamic` ويمكن إسناد رقم له لاحقاً.
   - (B) يستنتج المترجم أن نوعه `String` في الـ Compile-Time ويمنع أي نوع آخر.
   - (C) يعتبر المتغير كائناً من نوع `Object?` يقبل الـ null.
   - (D) يتم تحويله إلى كائن قابل للتعديل في الـ Runtime بدون تدقيق نوعي.

2. **أي مما يلي يعتبر الفرق الجوهري بين `Object` و`dynamic` في Dart؟**
   - (A) `dynamic` أسرع في استهلاك الذاكرة من `Object`.
   - (B) `Object` يسمح باستدعاء أي دالة افتراضية، بينما `dynamic` لا يسمح بذلك.
   - (C) `Object` يخضع للتدقيق النوعي الساكن، بينما `dynamic` يعطل التدقيق حتى الـ Runtime.
   - (D) `dynamic` لا يقبل قيم الـ `null`، بينما `Object` يقبلها دائماً.

3. **ما هي العملية التي تقوم بها الـ Dart VM عند إنشاء كائنات متطابقة باستخدام `const`؟**
   - (A) Garbage Collection.
   - (B) Memory Allocation على الـ Call Stack.
   - (C) Canonicalization في الـ Constant Pool.
   - (D) Just-In-Time Compilation.

4. **ما هو ناتج مقارنة `identical(finalA, finalB)` إذا كان كلاهما منشأ عبر `final` بنفس القيم تماماً (بدون استخدام const constructor)؟**
   - (A) `true` دائماً.
   - (B) `false` لأنهما يحجزان مكانين مختلفين في الـ Heap Memory.
   - (C) يحدث Compile-Time Error.
   - (D) تعتمد على إصدار الـ Dart SDK.

5. **في Sound Null Safety، إذا كان نوع المتغير `String` (بدون علامة استفهام)، ما الذي يضمنه المترجم؟**
   - (A) أن المتغير قد يحتوي على `null` فقط إذا تم استخدام علامة `!`.
   - (B) استحالة احتواء المتغير على `null` في كل من Compile-Time وRuntime.
   - (C) أن المتغير سيتحول تلقائياً إلى نص فارغ `""` عند إسناد null.
   - (D) أنه يمكن إسناد null له بعد استخدام `late`.

6. **ماذا يحدث إذا تم قراءة متغير معرف بـ `late` دون أن يتم إسناد قيمة له مسبقاً؟**
   - (A) يرجع القيمة الافتراضية `null`.
   - (B) يرجع قيمة عشوائية من الذاكرة (Garbage Value).
   - (C) يرمي استثناء `LateInitializationError` فوري في الـ Runtime.
   - (D) يفشل الكود في مرحلة الـ Compilation.

7. **ما هو نوع القاع (Bottom Type) في الـ Type Hierarchy في لغة Dart؟**
   - (A) `void`
   - (B) `Null`
   - (C) `Never`
   - (D) `Object`

8. **ما الذي يفعله المشغل `??=` في التعبير `a ??= b;`؟**
   - (A) يسند `b` إلى `a` فقط إذا كانت `a` خالية (`null`).
   - (B) يسند `b` إلى `a` دائماً ويتجاهل القيمة السابقة.
   - (C) يرمي استثناء إذا كانت `b` خالية (`null`).
   - (D) يتحقق من التساوي الصارم بين `a` و`b`.

9. **أي مرحلة من مراحل تجميع Dart مسؤولة عن إنتاج كود Native فائق السرعة لنسخة الـ Production؟**
   - (A) JIT (Just-In-Time).
   - (B) AOT (Ahead-Of-Time).
   - (C) CFE (Common Front End).
   - (D) Kernel AST.

10. **متى يتم تنفيذ كود التهيئة للمتغير المعرف كـ `late final int x = compute();`؟**
    - (A) فور تشغيل دالة `main()`.
    - (B) أثناء مرحلة الـ Compile Time.
    - (C) فقط عند أول قراءة أو استخدام فعلي للمتغير `x`.
    - (D) عند تدمير الكائن من الذاكرة.

---

## الجزء الثاني: أسئلة صح أم خطأ (True / False) — 5 أسئلة (2.5 درجات)

11. [ ] الكلمة المفتاحية `final` تعني أن المتغير ثابت يتم حسابه بالكامل في الـ Compile-Time.
12. [ ] استخدام المشغل `!` (Force Unwrap) يعتبر آمناً تماماً إذا كان المتغير من نوع `String?`.
13. [ ] دالة ترجع نوع `Never` لا يمكنها الوصول لسطر `return` بأي شكل من الأشكال.
14. [ ] المتغير من نوع `num` يمكنه استقبال قيم من نوع `int` وقيم من نوع `double`.
15. [ ] في لغة Dart، الكود التالي سليم: `Object x = 'Hello'; x.toUpperCase();`.

---

## الجزء الثالث: توقع المخرجات (Code Output) — 5 أسئلة (2.5 درجات)

### 16. ما ناتج الكود التالي؟
```dart
void main() {
  int? x;
  int y = x ?? 50;
  print(y * 2);
}
```

### 17. ما ناتج الكود التالي؟
```dart
void main() {
  const p1 = [1, 2];
  const p2 = [1, 2];
  print(identical(p1, p2));
}
```

### 18. ما ناتج الكود التالي؟
```dart
void main() {
  String? name = 'dart';
  if (name != null) {
    print(name.length);
  }
}
```

### 19. ما ناتج الكود التالي؟
```dart
void main() {
  dynamic a = 10;
  var b = 20;
  a = 'Thirty';
  // b = 'Forty';
  print('$a and $b');
}
```

### 20. ما ناتج الكود التالي؟
```dart
void main() {
  late int score;
  score = 95;
  print(score);
}
```

---

## الجزء الرابع: تصحيح الأخطاء (Debugging) — 3 أسئلة (3 درجات)

21. **حدد الخطأ وكيف تصححه:**
    ```dart
    void printLength(String? text) {
      print(text!.length);
    }
    // يتم استدعاؤها مع: printLength(null);
    ```

22. **حدد سبب فشل الـ Compilation:**
    ```dart
    void main() {
      const currentTime = DateTime.now();
      print(currentTime);
    }
    ```

23. **حدد سبب الانهيار في الـ Runtime:**
    ```dart
    class Profile {
      late String bio;
      void show() => print(bio);
    }
    void main() {
      Profile().show();
    }
    ```

---

## الجزء الخامس: الأسئلة العملية القصيرة (Practical) — سؤالان (2 درجتان)

24. اكتب دالة بسيطة ومثالية بعنوان `int safeParsePositiveInt(String? rawInput, int defaultValue)` تقوم بتحويل نص رقمي اختياري إلى عدد موجب، وإذا كان النص فارغاً أو غير صالح أو سالباً ترجع القيمة الافتراضية بأمان تام.

25. صمم كلاس صغير `const Coordinate` يحتوي على حقلين `x` و`y` من نوع `double` يدعم الـ Canonicalization وتوفر له `const constructor`.
