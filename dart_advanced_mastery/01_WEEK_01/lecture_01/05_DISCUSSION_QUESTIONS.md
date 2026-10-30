# Discussion Questions — Lecture 01: Language Architecture & Type System

تضم هذه الوثيقة 18 سؤالاً نقاشياً تفاعلياً مصممة لقياس الاستيعاب المعماري العميق وتنشيط الحوار داخل القاعة التدريبية.

---

### Category A: Understanding Questions (أسئلة الفهم)
1. **السؤال 1:** ما هو الفارق الدقيق بين نظام الأنواع الديناميكي (Dynamically Typed) ونظام الأنواع الساكن الصارم (Sound Static Type System) في لغة Dart؟
2. **السؤال 2:** كيف يفسر Dart VM الفرق بين النوعين `Object` و`dynamic` عند استدعاء دالة غير موجودة في الـ Class؟
3. **السؤال 3:** ما معنى أن لغة Dart تمتلك "Sound" Null Safety، ولماذا لا يعتبر الـ Null Safety مجرد فحص تقليدي يجريه المترجم؟

---

### Category B: "Why" Questions (أسئلة التعليل والسبب المعماري)
4. **السؤال 4:** لماذا قرر مهندسو لغة Dart منع استدعاء Reflection (`dart:mirrors`) في تطبيقات AOT وFlutter، والاعتماد بدلاً من ذلك على Code Generation؟
5. **السؤال 5:** لماذا لا تقوم Dart بعمل Automatic Type Coercion (مثل تحويل رقم `int` تلقائياً إلى `double` دون كتابة `.toDouble()`)؟
6. **السؤال 6:** لماذا يعد استخدام `double` لتمثيل أرصدة المعاملات المالية في تطبيقات الإنتاج خطأً برمجياً كارثياً؟

---

### Category C: "How" Questions (أسئلة الآلية والتنفيذ)
7. **السؤال 7:** كيف تقوم الـ Dart VM بتنفيذ عملية **Canonicalization** للكائنات المعرفة بـ `const`، وأين يتم تخزينها في الذاكرة؟
8. **السؤال 8:** كيف يقوم الـ Flow Analyzer في Dart بترقية نوع المتغير (Type Promotion) من `String?` إلى `String` تلقائياً دون الحاجة إلى Casting صريح؟
9. **السؤال 9:** كيف يختلف سلوك الكلمة المفتاحية `late` عندما يتم إقرانها بـ Initializer Expression مقارنةً بتركها بدون Initializer؟

---

### Category D: "What If" Questions (أسئلة ماذا لو وسيناريوهات الفشل)
10. **السؤال 10:** ماذا يحدث إذا قمت باستدعاء `late final` variable قبل أن يتم إسناد أي قيمة له؟ ما هو نوع الـ Exception الصادر بدقة، وهل هو Null؟
11. **السؤال 11:** ماذا لو قمنا بمقارنة كائنين تم إنشاؤهما بـ `final` يمتلكان نفس القيم تماماً باستخدام `identical()`؟ ولماذا تختلف النتيجة عن `const`؟
12. **السؤال 12:** ماذا لو قامت دالة بتعريف نوع الإرجاع كـ `Never` ثم حاولت داخل جسم الدالة إرجاع قيمة رقمية مثل `return 0;`؟ ماذا سيقول الـ Compiler؟

---

### Category E: Code Tracing Questions (أسئلة تتبع الكود)
13. **السؤال 13:** تتبع ناتج طباعة الكود التالي بدقة:
    ```dart
    void main() {
      var x = 10;
      dynamic y = x;
      y = 'Dart';
      print(x.runtimeType);
      print(y.runtimeType);
    }
    ```
14. **السؤال 14:** تتبع الكود التالي واشرح هل سيمر من الـ Compiler أم سيعطي خطأ:
    ```dart
    String formatName(String? name) {
      if (name == null) {
        throw ArgumentError('Null name');
      }
      return name.toUpperCase(); // Does this require '!' or '?.'?
    }
    ```

---

### Category F: Debugging Questions (أسئلة تصحيح الأخطاء)
15. **السؤال 15:** اكتشف الخطأ الخفي في الكود التالي الذي يفشل في الـ Runtime:
    ```dart
    class SessionManager {
      late String userToken;
      bool get isAuthenticated => userToken != null;
    }
    ```
16. **السؤال 16:** لماذا يعطي الكود التالي خطأ في الـ Compilation على الرغم من أن المتغير `amount` تم التحقق منه:
    ```dart
    class Wallet {
      double? balance;
      void withdraw(double amount) {
        if (balance != null) {
          // Error: The property 'balance' cannot be promoted because it is a public getter/field
          // balance - amount;
        }
      }
    }
    ```

---

### Category G: Architecture & Real-World Scenarios (أسئلة المعمارية والواقع العملي)
17. **السؤال 17:** في نظام مصرفي يعالج 10,000 معاملة في الثانية، كيف يؤثر استبدال `final` بـ `const` في الـ Value Objects على الـ Garbage Collection ومعدل استهلاك المعالج؟
18. **السؤال 18:** متى يكون استخدام `dynamic` مبرراً هندسياً بنسبة 100% في مشروع Enterprise، ومتى يعتبر جريمة معمارية؟
