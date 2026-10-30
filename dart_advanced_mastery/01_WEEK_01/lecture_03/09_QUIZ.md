# Quiz Assessment — Lecture 03: Collections, Records & Patterns
> **تعليمات الاختبار:**  
> - مدة الاختبار: 20 دقيقة.  
> - الدرجة الكلية: 15 درجة.  
> - أجب عن الأسئلة بدقة دون الاستعانة بالـ IDE.

---

## الجزء الأول: أسئلة الاختيار من متعدد (MCQ) — 10 أسئلة (5 درجات)

1. **ما هي ميزة الـ Records الأساسية في Dart 3؟**
   - (A) كائنات قابلة للتعديل بحجم ديناميكي.
   - (B) بنى بيانات مجمعة مجهولة ومصمتة (Immutable) ومحمية نوعياً.
   - (C) بديل كامل للـ Isolates وقنوات الاتصال.
   - (D) تدعم الوراثة والتعديل في وقت التشغيل.

2. **كيف يتم الوصول إلى الحقل الموضعي الأول في Record مثل `var r = ('Alice', 25);`؟**
   - (A) `r[0]`
   - (B) `r.first`
   - (C) `r.$1`
   - (D) `r.item1`

3. **ماذا يحدث إذا قمت بعمل مقارنة `r1 == r2` بين سجلين (Records) يمتلكان نفس الحقول والقيم تماماً؟**
   - (A) تعطي `false` لأنهما يحجزان عنوانين مختلفين في الذاكرة.
   - (B) تعطي `true` بفضل خاصية المساواة الهيكلية (Structural Equality).
   - (C) يحدث Compile-Time Error لعدم وجود دالة مقارنة مخصصة.
   - (D) تعتمد النتيجة على ما إذا كانا معرفين بـ `const`.

4. **ما الذي يضمنه المترجم عند عمل `switch` على فئة معرفة بـ `sealed class`؟**
   - (A) تنفيذ الحالات في مسارات معالجة متوازية (Parallel Threads).
   - (B) التحقق الشامل (Exhaustiveness) وإلزام المطور بتغطية كل الفئات الفرعية.
   - (C) تحويل كل الكائنات إلى JSON تلقائياً.
   - (D) منع استخدام الحراس `when`.

5. **أي من المشغلات التالية يُستخدم لإدراج عناصر قائمة قابلة للـ null بأمان داخل قائمة أخرى؟**
   - (A) `...`
   - (B) `...?`
   - (C) `?.`
   - (D) `??`

6. **في الـ Pattern Matching، ما هو الرمز المستخدم لتجاهل قيمة معينة وعدم ربطها بمتغير؟**
   - (A) `void`
   - (B) `null`
   - (C) `_` (Underscore)
   - (D) `ignore`

7. **ما هو التعقيد الزمني (Time Complexity) للبحث عن عنصر في `Set` يحتوي على $N$ عنصر؟**
   - (A) $O(N)$
   - (B) $O(\log N)$
   - (C) $O(1)$ في المتوسط.
   - (D) $O(N^2)$

8. **ما الذي يفعله الحارس `when` في نمط `case (int x) when x > 100`؟**
   - (A) ينتظر اكتمال دالة Future قبل الدخول.
   - (B) يضيف شرطاً منطقياً إضافياً يجب أن يكون صائباً لمطابقة الحالة.
   - (C) يعيد تشغيل الـ Switch من البداية.
   - (D) يحول الـ Switch إلى حلقة تكرار While.

9. **أي من العبارات التالية صحيحة بخصوص الـ Destructuring في Dart؟**
   - (A) لا يمكن تطبيقه إلا على القوائم فقط.
   - (B) يسمح بتفكيك واستخراج حقول السجلات والخرائط والكائنات إلى متغيرات محلية في سطر واحد.
   - (C) يتطلب كتابة دالة `unapply` يدوياً في كل كلاس.
   - (D) يبطئ من سرعة تنفيذ التطبيق في الـ Production.

10. **ما هو ناتج تفكيك الـ Record المسمى `({String name, int age})`؟**
    - (A) `var (name: n, age: a) = record;`
    - (B) `var [n, a] = record;`
    - (C) `var {n, a} = record;`
    - (D) `var (n, a) = record;`

---

## الجزء الثاني: أسئلة صح أم خطأ (True / False) — 5 أسئلة (2.5 درجات)

11. [ ] يمكن تعديل قيمة أحد حقول الـ Record بعد إنشائه إذا كان معرفاً بـ `var`.
12. [ ] جملة `switch expression` في Dart 3 تتطلب وضع كلمة `break` بعد كل سطر.
13. [ ] الـ Rest Pattern `[first, ...rest, last]` يسمح بالتقاط العناصر الوسطى داخل قائمة جديدة.
14. [ ] يمكن استخدام Collection if داخل الـ Sets والـ Maps كما في الـ Lists.
15. [ ] إذا كان المتغير من نوع `sealed class`، يجب كتابة فرع `default: _` في الـ switch دائماً حتى لو غطينا كل الفئات.

---

## الجزء الثالث: توقع المخرجات (Code Output) — 5 أسئلة (2.5 درجات)

### 16. ما ناتج الكود التالي؟
```dart
void main() {
  final (a, b) = (5, 10);
  print(a + b);
}
```

### 17. ما ناتج الكود التالي؟
```dart
void main() {
  final items = [1, 2, ...[3, 4]];
  print(items.length);
}
```

### 18. ما ناتج الكود التالي؟
```dart
void main() {
  final r1 = (name: 'Dart', version: 3);
  final r2 = (version: 3, name: 'Dart');
  print(r1 == r2);
}
```

### 19. ما ناتج الكود التالي؟
```dart
String eval(int score) => switch (score) {
  >= 90 => 'A',
  >= 75 => 'B',
  _ => 'C',
};
void main() {
  print(eval(82));
}
```

### 20. ما ناتج الكود التالي؟
```dart
void main() {
  final [x, y, ...rest] = [10, 20, 30, 40, 50];
  print('$x, $y, ${rest.length}');
}
```

---

## الجزء الرابع: تصحيح الأخطاء (Debugging) — 3 أسئلة (3 درجات)

21. **حدد الخطأ الذي يعترضه الـ Compiler وكيف تصححه:**
    ```dart
    sealed class Status {}
    class Active extends Status {}
    class Inactive extends Status {}
    class Suspended extends Status {}

    String label(Status s) => switch (s) {
      Active() => 'Active User',
      Inactive() => 'Inactive User',
    };
    ```

22. **حدد سبب الخطأ في هذا التفكيك:**
    ```dart
    void main() {
      final record = (title: 'Master', 2026);
      print(record.$1);
    }
    ```

23. **حدد سبب الانهيار في الـ Runtime:**
    ```dart
    void main() {
      final list = [1, 2];
      final [a, b, c] = list; // What will happen?
      print('$a, $b, $c');
    }
    ```

---

## الجزء الخامس: الأسئلة العملية القصيرة (Practical) — سؤالان (2 درجتان)

24. اكتب دالة بسيطة بعنوان `(int min, int max) findMinMax(List<int> numbers)` ترجع أصغر وأكبر رقم في قائمة كـ Record في مسار خطي واحد $O(N)$.

25. اكتب Switch Expression لفحص كائن `dynamic input`؛ إذا كان نصاً يبدأ بـ 'OK' يرجع 'SUCCESS'، وإذا كان رقماً سالباً يرجع 'NEGATIVE'، وغير ذلك يرجع 'UNKNOWN'.
