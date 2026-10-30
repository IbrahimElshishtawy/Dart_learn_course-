# Terminology Glossary — Lecture 01: Language Architecture & Type System

قاموس المصطلحات التخصصي للمحاضرة الأولى مع الشرح المبسط باللهجة المصرية والربط المعماري مع Flutter والـ Software Engineering.

---

### 1. Sound Type System
- **الترجمة العربية:** نظام الأنواع السليم / المتماسك رياضياً.
- **الشرح باللهجة المصرية:** نظام صارم بيضمنلك إن لو المتغير اتحدد نوعه كـ `int`، مستحيل في أي لحظة تحت أي ظرف في الـ Runtime يكون شايل حاجة تانية غير `int`، ومفيش أي كائن يقدر يخدع المترجم.
- **المعنى التقني الدقيق:** A static type system where the compile-time types are mathematically guaranteed to be true and respected at runtime without unexpected type pollution.
- **مثال عملي:** منع كتابة كود يسند نصاً لرقم دون فحص صريح.
- **استخدامه في Dart:** هو الأساس المعماري للغة Dart 2 وDart 3.
- **علاقته بـ Flutter:** يمنع الانهيارات المفاجئة (Red Screens) أثناء تنقل الشاشات وتبادل البيانات.
- **متى تحتاجه؟** في كل سطر كود تكتبه طوال مسيرتك.

---

### 2. Sound Null Safety
- **الترجمة العربية:** أمان المؤشرات الفارغة السليم.
- **الشرح باللهجة المصرية:** قاعدة دهبية في Dart؛ المتغيرات كلها غير قابلة للـ Null افتراضياً، ومستحيل متغير عادي يمسك `null`، إلا لو إنت رفعت إيدك وحطيت علامة الاستفهام `?` صراحة.
- **المعنى التقني الدقيق:** A type-system feature guaranteeing that non-nullable types cannot evaluate to `null` at runtime, shifting null dereference bugs to compile-time errors.
- **مثال عملي:** `String name = 'Ali';` مستحيل تقبل `null`.
- **استخدامه في Dart:** إلزام المبرمج بالتعامل الواعي مع الاحتماليات عبر `?.` و`??`.
- **علاقته بـ Flutter:** جعل شاشات فلاتر مستقرة وخالية من أخطاء الـ NullPointer.
- **متى تحتاجه؟** عند تصميم نماذج البيانات (Models) واستقبال ردود الـ API.

---

### 3. Canonicalization
- **الترجمة العربية:** توحيد الكائنات الثابتة في الذاكرة.
- **الشرح باللهجة المصرية:** حركة توفير ذكية بتعملها Dart؛ لو عملت 100 كائن `const` بنفس القيم بالظبط، Dart متكررش حجز الذاكرة 100 مرة، هي بتعمل نسخة واحدة يتيمة في الـ RAM والـ 100 متغير يبصوا عليها.
- **المعنى التقني الدقيق:** The deduplication of identical constant instances into a single shared, immutable memory address in the constant pool.
- **مثال عملي:** `identical(const Point(0, 0), const Point(0, 0))` تعطي `true`.
- **استخدامه في Dart:** الفئات التي تمتلك `const constructor`.
- **علاقته بـ Flutter:** السبب الرئيسي وراء كتابة `const` قبل الويدجتس؛ لمنع إعادة بنائها وحجزها في الذاكرة مع كل إطار.
- **متى تحتاجه؟** لتحسين استهلاك الذاكرة وتفادي الـ UI Jank.

---

### 4. Flow Analysis & Type Promotion
- **الترجمة العربية:** تحليل مسار التدفق وترقية الأنواع.
- **الشرح باللهجة المصرية:** الذكاء الاصطناعي الصغير اللي جوه المترجم؛ بيمشي ورا الكود سطر بسطر، ولو لقى جملة `if (x != null)`، يفهم لوحده إن `x` بعد السطر ده مش ممكن تكون Null، ويرقيها فوراً من `String?` لـ `String` من غير ما تطلب منه.
- **المعنى التقني الدقيق:** Static analysis of execution paths that temporarily narrows or promotes a variable's type based on conditional guards and assertions.
- **مثال عملي:** `if (item is Book) item.read();`
- **استخدامه في Dart:** تقليل الحاجة للـ Explicit Casting `as` وعلامة `!`.
- **علاقته بـ Flutter:** تسهيل التعامل مع الـ Bloc States والتحقق من حالة الـ Loading أو Success.
- **متى تحتاجه؟** في كتابة دوال التحقق والحماية (Guard Clauses).

---

### 5. The Bottom Type (`Never`)
- **الترجمة العربية:** نوع القاع المطلق.
- **الشرح باللهجة المصرية:** نوع غريب في Dart بيمثل المستحيل؛ مفيش أي قيمة في الدنيا نوعها `Never`. الدالة اللي نوعها `Never` هي دالة مستحيل ترجع قيمة لأنها بترمى Exception أو بتفضل في Infinite Loop.
- **المعنى التقني الدقيق:** The bottom type in a type lattice that is a subtype of all types and has no possible runtime instances, indicating non-termination.
- **مثال عملي:** `Never fail(String msg) => throw Exception(msg);`
- **استخدامه في Dart:** مساعدة الـ Flow Analyzer في معرفة الـ Dead Code وإتمام الـ Definite Assignment.
- **علاقته بـ Flutter:** دوال إطلاق الأخطاء الحرجة في الـ Core Architecture.
- **متى تحتاجه؟** عند بناء أدوات المعالجة الأمنية واستثناءات النظام المالي.

---

### 6. The Top Type (`Object?`)
- **الترجمة العربية:** نوع القمة المطلق.
- **الشرح باللهجة المصرية:** الجد الأكبر لكل حاجة في Dart؛ أي قيمة وأي كائن في اللغة، بما فيها الـ `null`، ينتمي للنوع ده.
- **المعنى التقني الدقيق:** The universal supertype of all types in Dart's type hierarchy, encompassing both `Object` and `Null`.
- **مثال عملي:** `Object? payload;` يمكن أن يستقبل أي شيء بأمان.
- **استخدامه في Dart:** البديل الآمن لـ `dynamic` عندما لا نعرف نوع البيانات مقدماً.
- **علاقته بـ Flutter:** تمرير بيانات مجهولة النوع عبر الـ Navigation Arguments.
- **متى تحتاجه؟** عند كتابة مكتبات عامة أو Serialization Engines.

---

### 7. Late Initialization (`late`)
- **الترجمة العربية:** التهيئة المتأخرة.
- **الشرح باللهجة المصرية:** كلمة بتقول بيها للمترجم: "سيبني أعلن عن المتغير دلوقتي من غير ما أديله قيمة، وأنا بوعدك إني هديله قيمة قبل ما أقرأه". لو نسيت وعدك، البرنامج هيفرقع في وشك فورا بـ `LateInitializationError`.
- **المعنى التقني الدقيق:** A modifier indicating that a non-nullable variable's binding is deferred to runtime, optionally providing lazy-evaluation semantics.
- **مثال عملي:** `late final ApiService _api = ApiService();`
- **استخدامه في Dart:** تفعيل الـ Lazy Evaluation للمتغيرات الثقيلة.
- **علاقته بـ Flutter:** تهيئة الـ Controllers داخل دالة `initState()`.
- **متى تحتاجه؟** لتقليل استهلاك الذاكرة وعدم تحميل الموارد إلا عند طلبها الفعلي.

---

### 8. Compiler Pipeline (CFE -> Kernel -> AOT/JIT)
- **الترجمة العربية:** خط أنابيب الترجمة البرمجية.
- **الشرح باللهجة المصرية:** المصنع اللي كودك بيمشي جواه: يبدأ ككود إنجليزي، يمر على الـ CFE يتحول لشجرة AST، بعدين Kernel Binary `.dill`، بعدين يروح للـ JIT في التطوير علشان الـ Hot Reload، أو للـ AOT علشان يطلع تطبيق Release سريع.
- **المعنى التقني الدقيق:** The multi-stage compilation toolchain of the Dart SDK translating source code to Intermediate Representation (Kernel AST) and finally to native machine code.
- **مثال عملي:** تشغيل `dart compile exe bin/main.dart`.
- **استخدامه في Dart:** السر في دعم Dart للويب والهواتف والـ Desktop والسيرفرات بنفس الكود.
- **علاقته بـ Flutter:** الأساس الهندسي الذي يوفر تجربة تطوير سريعة وتطبيقات خفيفة وسريعة للعملاء.
- **متى تحتاجه؟** عند تصحيح مشاكل الـ Build وتحسين حجم التطبيق (App Size Optimization).
