# Discussion Questions — Lecture 03: Collections, Records & Patterns

مجموعة من 18 سؤالاً نقاشياً تفاعلياً لقياس مدى استيعاب المتدربين للميزات الحديثة في Dart 3 والـ Patterns والمجموعات.

---

### Category A: Understanding Questions (أسئلة الفهم)
1. **السؤال 1:** ما هو الفارق الجوهري بين كائن الـ `Record` في Dart 3 والفئة الكلاسيكية `class` من حيث التخصيص في الذاكرة والمساواة الهيكلية؟
2. **السؤال 2:** كيف تضمن لغة Dart مبدأ "Exhaustiveness Checking" في جمل الـ `switch`، وما هي الأنواع التي ينطبق عليها هذا الفحص الصارم؟
3. **السؤال 3:** ما هو الفارق في الكفاءة والتعقيد الزمني بين فحص وجود عنصر في `List.contains()` وفحصه في `Set.contains()`؟

---

### Category B: "Why" Questions (أسئلة التعليل المعماري)
4. **السؤال 4:** لماذا تعتبر الـ Records في Dart غير قابلة للتعديل (Immutable) بصورة قطعية ولا يمكن إضافة حقول لها بعد الإنشاء؟
5. **السؤال 5:** لماذا تم تقديم المشغل `...?` (Null-aware spread) بجانب مشغل الـ Spread العادي `...`؟
6. **السؤال 6:** لماذا يعد استخدام `sealed class` مع الـ Switch Expressions أفضل معمارياً من استخدام فئة عادية مع `if (is)` cascades؟

---

### Category C: "How" Questions (أسئلة الآلية والتنفيذ)
7. **السؤال 7:** كيف يعمل تفكيك البيانات (Destructuring) عند تطبيقه على كائن معقد يحتوي على خريطة وقائمة متداخلتين؟
8. **السؤال 8:** كيف تدعم الـ Records المقارنة بالقيمة (Value Equality) والـ Hash Code تلقائياً دون الحاجة إلى كتابة كود مخصص؟
9. **السؤال 9:** كيف نستخدم حراس الشروط (Guard Clauses باستخدام `when`) داخل الـ Pattern Matching لتقييد الحالات؟

---

### Category D: "What If" Questions (أسئلة ماذا لو وسيناريوهات الفشل)
10. **السؤال 10:** ماذا يحدث إذا نسيت تغطية إحدى الحالات المشتقة من `sealed class` داخل `switch expression`؟ ما هي رسالة الـ Compiler؟
11. **السؤال 11:** ماذا لو احتوى Record على حقول موضعية وحقول مسماة في نفس الوقت؟ كيف يتم الوصول لكل منها؟
12. **السؤال 12:** ماذا لو قمنا بتفكيك قائمة طولها 2 باستخدام نمط يتوقع 3 عناصر: `var [a, b, c] = [1, 2];`؟ هل يفشل الكود وقت الـ Compilation أم في الـ Runtime؟

---

### Category E: Code Tracing Questions (أسئلة تتبع الكود)
13. **السؤال 13:** تتبع ناتج طباعة الكود التالي بدقة:
    ```dart
    void main() {
      var (x, y) = (10, 20);
      (x, y) = (y + 5, x + 5);
      print('$x, $y');
    }
    ```
14. **السؤال 14:** تتبع مخرجات الـ Switch Expression التالي:
    ```dart
    String classify(Object val) => switch (val) {
      [int a, int b] when a == b => 'EQUAL_PAIR',
      [int _, int _] => 'PAIR',
      (int x, String y) => 'RECORD_$x',
      _ => 'OTHER',
    };
    void main() {
      print(classify([5, 5]));
      print(classify((42, 'Answer')));
    }
    ```

---

### Category F: Debugging Questions (أسئلة تصحيح الأخطاء)
15. **السؤال 15:** اكتشف سبب فشل الـ Compilation في هذا الكود:
    ```dart
    sealed class Animal {}
    class Dog extends Animal {}
    class Cat extends Animal {}

    String speak(Animal a) => switch (a) {
      Dog() => 'Woof',
      // Error here
    };
    ```
16. **السؤال 16:** ما الخطأ في هذا الاستدعاء:
    ```dart
    void main() {
      final List<int>? extra = null;
      final total = [1, 2, ...extra]; // What is the bug?
      print(total);
    }
    ```

---

### Category G: Architecture & Real-World Scenarios (أسئلة المعمارية والواقع)
17. **السؤال 17:** كيف يساهم الجمع بين الـ Records والـ Pattern Matching في تبسيط طبقة الـ Data Parsing ونماذج الـ DTO في تطبيقات Flutter الكبيرة؟
18. **السؤال 18:** متى تقرر كمهندس برمجيات استخدام Record بدلاً من إنشاء Class كامل في الـ Domain Layer؟
