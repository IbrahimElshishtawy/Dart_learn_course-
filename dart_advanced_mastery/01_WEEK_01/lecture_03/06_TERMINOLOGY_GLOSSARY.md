# Terminology Glossary — Lecture 03: Collections, Records & Patterns

قاموس المصطلحات التخصصي للمحاضرة الثالثة مع الشرح المبسط باللهجة المصرية والربط التقني مع هندسة النظم وتطبيقات Flutter.

---

### 1. Record
- **الترجمة العربية:** السجل البرمجي.
- **الشرح باللهجة المصرية:** كبسولة بيانات خفيفة وسريعة في Dart 3؛ بتسمحلك تجمع كذا قيمة بأنواع مختلفة في كائن واحد مجهول الاسم من غير ما تضطر تروح تعمل كلاس كامل وكونستركتور وGetters.
- **المعنى التقني الدقيق:** An anonymous, immutable, aggregate value type that groups multiple fields of different types with built-in structural equality.
- **مثال عملي:** `(String, double) point = ('Latitude', 30.5);`
- **استخدامه في Dart:** إرجاع نتائج متعددة من الدوال بأمان نوعي كامل (Strong Typing).
- **علاقته بـ Flutter:** إرجاع قيم الـ Lat/Lng أو التنسيق بين حالات الواجهات بدون حزم إضافية.
- **متى تحتاجه؟** لتجميع مؤقت للبيانات دون تلويث الكود بفئات أحادية الاستخدام.

---

### 2. Pattern Matching
- **الترجمة العربية:** مطابقة الأنماط.
- **الشرح باللهجة المصرية:** إنك تفحص شكل وهيئة البيانات وهيكلها ونوعها ومحتواها في خطوة واحدة؛ لو طابقت الشكل اللي إنت راسمه، تستخرج البيانات منها فوراً بدون ما تقعد تعمل `if` و`is` وCasting بإيدك.
- **المعنى التقني الدقيق:** A language mechanism that matches a value against an expected structural pattern, validating its shape, types, and values simultaneously.
- **مثال عملي:** `if (payload case {'id': int id, 'name': String name}) ...`
- **استخدامه في Dart:** فحص ردود الـ JSON والـ Data Transfer Objects والـ Events.
- **علاقته بـ Flutter:** معالجة حالات الـ State Management (BLoC/Cubit States) بسلاسة فائقة.
- **متى تحتاجه؟** في كل كود معالجة وتصنيف بيانات.

---

### 3. Destructuring
- **الترجمة العربية:** تفكيك البيانات.
- **الشرح باللهجة المصرية:** إنك تفرط الكائن أو الـ Record أو القائمة على مائدة العمل؛ وتوزع القيم اللي جواه على متغيرات محلية مستقلة في سطر واحد بدل ما تقعد تقول `a = obj.a; b = obj.b;`.
- **المعنى التقني الدقيق:** Extracting individual fields or elements from a composite data structure (Record, List, Map, Object) directly into separate local variables.
- **مثال عملي:** `final (lat, lng) = getCoordinates();`
- **استخدامه في Dart:** تبسيط قراءة البيانات المجمعة.
- **علاقته بـ Flutter:** استخراج الحقول من كائنات الـ Model لعرضها على شاشات الواجهة.
- **متى تحتاجه؟** لتقليل أسطر الكود الروتينية وجعله معبراً ومباشراً.

---

### 4. Exhaustiveness Checking
- **الترجمة العربية:** التحقق الشامل من استيفاء الحالات.
- **الشرح باللهجة المصرية:** ميزة أمان خارقة في المترجم؛ لما تعمل `switch` على `sealed class` أو `enum`، المترجم بيقفلك بالمرصاد ويعد الحالات واحدة واحدة، ولو نسيت حالة واحدة بس يرفض يترجم الكود لحد ما تغطيها!
- **المعنى التقني الدقيق:** A compiler guarantee ensuring that a pattern-matching expression covers every possible variant of a static type hierarchy without omissions.
- **مثال عملي:** فحص حالات الدفع `PaymentState`: لو نسيت `PaymentFailed` يظهر خطأ تجميعي فوري.
- **استخدامه في Dart:** حماية التطبيقات من الانهيار عند إضافة حالات عمل جديدة.
- **علاقته بـ Flutter:** منع نسيان معالجة حالة الـ Error أو Loading في الـ Widget Tree.
- **متى تحتاجه؟** في الأنظمة المالية الحساسة ومحركات الأحداث (State Machines).

---

### 5. Sealed Class
- **الترجمة العربية:** الفئة المختومة.
- **الشرح باللهجة المصرية:** كلاس مقفول بالشمع الأحمر في Dart 3؛ محدش يقدر يورث منه إلا الكلاسات اللي معاه في نفس الملف بس! المترجم بيبقى عارف شجرة العائلة كاملة مقدماً وبيقدر يطبق عليها الـ Exhaustiveness.
- **المعنى التقني الدقيق:** A class modifier restricting direct subtyping to the same library file, enabling the compiler to know all possible subtypes at compile-time.
- **مثال عملي:** `sealed class Result<T> {}`
- **استخدامه في Dart:** بناء الـ Algebraic Data Types ومجموعات الحالات المحدودة.
- **علاقته بـ Flutter:** هو الأساس الحديث لبناء BLoC States وEvents النظيفة.
- **متى تحتاجه؟** لنمذجة نتائج العمليات (Success vs Failure).

---

### 6. Switch Expression
- **الترجمة العربية:** تعبير الاختيار المباشر.
- **الشرح باللهجة المصرية:** الـ `switch` اتطورت من مجرد جملة بتتحكم في السير إلى تعبير بيتحسب ويرجع قيمة مباشرة نقدر نسندها لمتغير أو نعملها return بدون كلمة `case` أو `break`.
- **المعنى التقني الدقيق:** An expression-level switch that matches patterns and directly returns a value from the matched branch.
- **مثال عملي:** `final title = switch (role) { Role.admin => 'Director', _ => 'Staff' };`
- **استخدامه في Dart:** استبدال سلاسل `if-else` الطويلة والمعقدة.
- **علاقته بـ Flutter:** بناء ألوان وأيقونات ونصوص الواجهات بحسب الـ Enum State.
- **متى تحتاجه؟** في أي منطق تحويل (Mapping) بين الأنواع.

---

### 7. Guard Clause (`when`)
- **الترجمة العربية:** جملة الحارس الإضافية.
- **الشرح باللهجة المصرية:** شرط إضافي بيتحط جنب الـ Pattern؛ يعني مش بس بفحص شكل الكائن، ده أنا بحط شرط إضافي على قيمته: "ادخل هنا لو هو رقم زوجي، بس بشرط يكون أكبر من 100".
- **المعنى التقني الدقيق:** An arbitrary boolean condition appended to a pattern using the `when` keyword that must evaluate to true for the case to match.
- **مثال عملي:** `case (int age) when age >= 18 => 'Adult';`
- **استخدامه في Dart:** تصفية الحالات الدقيقة دون الحاجة لتكرار فحص النوع.
- **علاقته بـ Flutter:** تفعيل أزرار الواجهة بناءً على شروط مركبة.
- **متى تحتاجه؟** في محركات الخصومات وتحديد الأولويات.

---

### 8. Structural Equality
- **الترجمة العربية:** المساواة الهيكلية.
- **الشرح باللهجة المصرية:** إن الكائنين يبقوا متساويين لو محتوياتهم وحقولهم نفس الشيء بالظبط، حتى لو كانوا كائنين منفصلين في الذاكرة. الـ Records في Dart بتعمل ده أوتوماتيك من غير أي مجهود منك.
- **المعنى التقني الدقيق:** Equivalence determined by comparing the structure and field values of objects rather than their pointer references in memory.
- **مثال عملي:** `(1, 'A') == (1, 'A')` تعطي دائماً `true`.
- **استخدامه في Dart:** الـ Records والـ Sets والـ Map Keys.
- **علاقته بـ Flutter:** مقارنة الـ States لمنع الـ Rebuild غير الضروري للويدجتس.
- **متى تحتاجه؟** عند استخدام الكائنات كمفاتيح في الخرائط أو عناصر في المجموعات.
