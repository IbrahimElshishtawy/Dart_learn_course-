# Discussion Questions — Lecture 02: Functions, Scope & Execution Model

مجموعة من 18 سؤالاً نقاشياً معماريّاً لقياس فهم المتدربين لدورة حياة الدوال ونطاق المتغيرات والبرمجة الوظيفية.

---

### Category A: Understanding Questions (أسئلة الفهم)
1. **السؤال 1:** ماذا تعني عبارة "Functions are First-Class Citizens" في لغة Dart على مستوى تخصيص الذاكرة والـ Runtime؟
2. **السؤال 2:** ما هو الفارق الدقيق بين الـ Named Parameters والـ Optional Positional Parameters في الاستدعاء والتصميم؟
3. **السؤال 3:** كيف تُعرّف دالة كـ "Pure Function"، وما هي شروط عدم وجود Side Effects؟

---

### Category B: "Why" Questions (أسئلة التعليل المعماري)
4. **السؤال 4:** لماذا تفضل Dart استخدام الـ Tear-offs مثل `items.forEach(print)` بدلاً من `items.forEach((x) => print(x))`؟
5. **السؤال 5:** لماذا تُنقل المتغيرات المحلية المحصورة داخل Closure من الـ Stack Frame إلى الـ Heap Memory؟
6. **السؤال 6:** لماذا لا تسمح Dart بخلط الـ Optional Positional Parameters `[]` مع الـ Named Parameters `{}` في نفس الدالة؟

---

### Category C: "How" Questions (أسئلة الآلية والتنفيذ)
7. **السؤال 7:** كيف تضمن لغة Dart أن كل لفة في حلقة `for (var i = 0; i < n; i++)` تمتلك متغير `i` مستقل تماماً عند التقاطه داخل Closure؟
8. **السؤال 8:** كيف يعمل الـ Constructor Tear-off (مثل `User.new`) وما هو الفارق بينه وبين استدعاء constructor عادي في الـ Performance؟
9. **السؤال 9:** كيف يتم بناء Middleware Pipeline باستخدام نمط الـ Higher-Order Function Composition؟

---

### Category D: "What If" Questions (أسئلة ماذا لو وسيناريوهات الفشل)
10. **السؤال 10:** ماذا يحدث إذا قامت دالة Closure بتعديل متغير خارجي أثناء تشغيل حلقة تكرار على قائمة؟ هل يحدث ConcurrentModificationError؟
11. **السؤال 11:** ماذا لو احتفظت دالة Closure بمرجع لكائن ضخم (مثل قائمة بها مليون عنصر) واستمرت الدالة في العمل لساعات؟ كيف يؤثر ذلك على الـ GC؟
12. **السؤال 12:** ماذا لو قمنا بتعريف Named Parameter بدون `required` وبدون Default Value وبدون علامة الاستفهام `?`؟ ماذا سيقول الـ Compiler؟

---

### Category E: Code Tracing Questions (أسئلة تتبع الكود)
13. **السؤال 13:** تتبع ناتج طباعة الكود التالي بدقة:
    ```dart
    int Function(int) makeMultiplier(int factor) {
      return (int n) => n * factor;
    }
    void main() {
      final doubleIt = makeMultiplier(2);
      final tripleIt = makeMultiplier(3);
      print(doubleIt(tripleIt(4)));
    }
    ```
14. **السؤال 14:** تتبع الكود التالي واذكر هل سينجح أم سيفشل:
    ```dart
    void main() {
      void Function()? runner;
      runner?.call();
      print('Safe execution');
    }
    ```

---

### Category F: Debugging Questions (أسئلة تصحيح الأخطاء)
15. **السؤال 15:** اكتشف العيب الخفي الذي يسبب Memory Leak في هذا الكود:
    ```dart
    class ScreenController {
      final List<int> heavyData = List.filled(500000, 1);
      void Function() createListener() {
        return () => print('Listener triggered');
      }
    }
    ```
16. **السؤال 16:** لماذا يشتكي الـ Analyzer من هذا الكود وكيف نصلحه:
    ```dart
    void executeTask({String taskName, int retryCount = 3}) {
      print('$taskName - $retryCount');
    }
    ```

---

### Category G: Architecture & Real-World Scenarios (أسئلة المعمارية والواقع)
17. **السؤال 17:** كيف نستفيد من الـ Higher-Order Functions في بناء Logging and Security Interceptors في تطبيقات البنوك؟
18. **السؤال 18:** قارن بين أسلوب Object-Oriented Command Pattern وأسلوب Functional Closure Callback في تصميم معالجات الأحداث.
