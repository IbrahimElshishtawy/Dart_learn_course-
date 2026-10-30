# Answer Key & Grading Manual — Lecture 03: Collections, Records & Patterns
> **تنبيه:** هذا الملف خاص بهيئة التدريس والمساعدين (Teaching Assistants) فقط.

---

## 1. نموذج إجابة الـ Quiz وتوزيع الدرجات

### الجزء الأول: الاختيار من متعدد (MCQ) — 0.5 درجة لكل سؤال (الإجمالي: 5 درجات)
1. **(B)** بنى بيانات مجمعة مجهولة ومصمتة (Immutable) ومحمية نوعياً.
2. **(C)** `r.$1` *(السبب: الحقول الموضعية يتم ترقيمها بداية من 1)*.
3. **(B)** تعطي `true` بفضل خاصية المساواة الهيكلية (Structural Equality).
4. **(B)** التحقق الشامل (Exhaustiveness) وإلزام المطور بتغطية كل الفئات الفرعية.
5. **(B)** `...?` *(السبب: Null-aware spread operator)*.
6. **(C)** `_` (Underscore) أو Wildcard pattern.
7. **(C)** $O(1)$ في المتوسط بفضل جدول الـ Hash.
8. **(B)** يضيف شرطاً منطقياً إضافياً يجب أن يكون صائباً لمطابقة الحالة.
9. **(B)** يسمح بتفكيك واستخراج حقول السجلات والخرائط والكائنات إلى متغيرات محلية في سطر واحد.
10. **(A)** `var (name: n, age: a) = record;` أو الصياغة المختصرة `var (:name, :age) = record;`.

---

### الجزء الثاني: صح أم خطأ (True / False) — 0.5 درجة لكل سؤال (الإجمالي: 2.5 درجات)
11. **خطأ (False):** حقول الـ Record مصمتة (Immutable) تماماً ولا يمكن تعديلها بعد إنشائها.
12. **خطأ (False):** الـ switch expression لا تستخدم `case` أو `break` بل أسهم التعيين المباشر `=>`.
13. **صح (True):** نمط الـ Rest element يلتقط العناصر المتبقية داخل قائمة جديدة.
14. **صح (True):** تدعم جميع المجموعات في Dart ميزتي collection-if وcollection-for.
15. **خطأ (False):** إذا تم تغطية كل الفئات الفرعية للـ sealed class، لا حاجة لفرع default، والمترجم يثبت ذلك رياضياً.

---

### الجزء الثالث: مخرجات الأكواد (Code Output) — 0.5 درجة لكل سؤال (الإجمالي: 2.5 درجات)
16. **الناتج:** `15` *(التعليل: `a = 5, b = 10` فيكون المجموع 15)*.
17. **الناتج:** `4` *(التعليل: تم فرد القائمتين ليصبح المجموع [1, 2, 3, 4])*.
18. **الناتج:** `true` *(التعليل: الحقول المسماة في الـ Records لا ترتبط بالترتيب الفيزيائي؛ طالما نفس الأسماء والقيم فهي متطابقة تماماً)*.
19. **الناتج:** `B` *(التعليل: 82 تقع في نطاق `>= 75`)*.
20. **الناتج:** `10, 20, 3` *(التعليل: `x = 10, y = 20` وبقية العناصر [30, 40, 50] طولها 3)*.

---

### الجزء الرابع: تصحيح الأخطاء (Debugging) — درجة واحدة لكل سؤال (الإجمالي: 3 درجات)
21. **التصحيح:** الفئة `Suspended` لم يتم تغطيتها في الـ switch على الـ sealed class! الحل: إضافة `Suspended() => 'Suspended User'`.
22. **السبب:** `record.$1` يشير إلى الحقل الموضعي الأول وهو `2026`، أما `title` فهو حقل مسمى يُقرأ عبر `record.title`.
23. **السبب:** الـ List Pattern `[a, b, c]` يتوقع مصفوفة بطول 3 تماماً، وتمرير قائمة بطول 2 يرمي `StateError (Pattern matching failed)` في الـ Runtime. التصحيح: استخدام Rest pattern: `[a, b, ...]` أو التحقق المسبق عبر `if-case`.

---

### الجزء الخامس: التطبيق العملي القصير — درجة لكل سؤال (الإجمالي: 2 درجتان)
24. **الكود:**
    ```dart
    (int min, int max) findMinMax(List<int> numbers) {
      if (numbers.isEmpty) throw ArgumentError('List cannot be empty');
      var min = numbers.first;
      var max = numbers.first;
      for (final n in numbers.skip(1)) {
        if (n < min) min = n;
        if (n > max) max = n;
      }
      return (min, max);
    }
    ```
25. **الكود:**
    ```dart
    String classify(dynamic input) => switch (input) {
      String s when s.startsWith('OK') => 'SUCCESS',
      num n when n < 0 => 'NEGATIVE',
      _ => 'UNKNOWN',
    };
    ```

---

## 2. نموذج إجابة الواجب المنزلي (Homework Solutions)
- **سؤال 6:** `true` (المساواة الهيكلية).
- **سؤال 7:** `3` (العنصر 'A' والعنصران 'Item_1' و'Item_2').
- **سؤال 8:** `'GREATER'` ثم `'LESS_OR_EQUAL'`.
- **سؤال 9:** `'Super Admin: omar'`.
- **سؤال 10:** `4 and 2`.
- **مهمة 16:** التحويل إلى `Set<String>` أو استخدام `userPermissions.contains(target)`؛ لأن الـ Loop الخطي غير كفء عند تكرار الفحص.
- **مهمة 17:** الاستبدال بنمط:
  ```dart
  String extractToken(Object? response) => switch (response) {
    {'auth': {'token': String token}} => token,
    _ => 'NO_TOKEN',
  };
  ```
