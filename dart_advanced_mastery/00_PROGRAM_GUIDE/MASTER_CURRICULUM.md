# Master Curriculum — Dart Advanced Mastery Training Program

## 1. فلسفة ورؤية البرنامج (Program Philosophy & Educational Vision)

صُمم هذا البرنامج لسد الفجوة الكبيرة بين **"التعلم السطحي للـ Syntax"** و**"الهندسة المعمارية العميقة للغة Dart"**.
في الواقع البرمجي، يتعامل أغلب مطوري التطبيقات مع Dart كمجرد أداة مساعدة لكتابة واجهات Flutter دون فهم كيف يعمل نظام الأنواع (Type System)، وماذا يحدث داخل الذاكرة (Memory Heap & Stack)، وكيف تدور حلقة الأحداث (Event Loop)، أو كيف يستغل المترجم تقنيات AOT وJIT لإنتاج كود فائق الكفاءة.

يقدم هذا البرنامجDart كـ **General-Purpose Object-Oriented Language** ذات قدرات هائلة في الـ Concurrency ومعالجة البيانات والبرمجة الوظيفية والأنظمة الموزعة، مما يؤهل الطالب ليكون مهندس برمجيات حقيقياً (Software Engineer) وليس مجرد مستخدم لمكتبات جاهزة.

---

## 2. مواصفات البرنامج (Program Specifications)

| المعيار | التفاصيل |
| :--- | :--- |
| **اسم البرنامج** | Dart Advanced Mastery Training Program |
| **المدة الإجمالية** | 4 أسابيع تدريبية مكثفة |
| **عدد المحاضرات** | 12 محاضرة |
| **الكثافة الأسبوعية** | 3 محاضرات أسبوعياً |
| **زمن المحاضرة الواحدة** | ساعتان (120 دقيقة) من الشرح التفاعلي والتحليل الهندسي |
| **إجمالي ساعات الاتصال المباشر** | 24 ساعة تدريب مباشر |
| **إجمالي ساعات التطبيقات والواجبات** | أكثر من 40 ساعة عمل تطبيقي موجه |
| **البيئة المعتمدة واللغة** | Dart SDK `3.8.1+` مع معايير Null Safety الصارمة |
| **لغة الشرح والتوثيق** | مصطلحات تقنية إنجليزية معتمدة عالمياً + شرح تفاعلي عميق باللغة العربية (مع نصوص المحاضر باللهجة المصرية التقنية) |

---

## 3. مصفوفة الكفاءات المستهدفة (Competency Matrix)

بنهاية هذا البرنامج، يكتسب المتدرب الكفاءات التالية:

1. **Language Architecture & Internals:**
   فهم خط أنابيب المترجم (Dart Compiler Pipeline: Parsing -> AST -> CFE -> Kernel -> JIT/AOT)، والفروق الجوهرية بين التفسير والتجميع في وقت التشغيل.
2. **Sound Type System & Static Analysis:**
   فهم التماسك النوعي (Type Soundness)، استنتاج الأنواع (Type Inference)، التغاير والتضاد (Covariance / Contravariance)، والـ Null Safety الصارمة.
3. **Advanced Object-Oriented Modeling:**
   تجاوز الوراثة التقليدية نحو الـ Composition، واستخدام Mixins، وAbstract Interfaces، وExtension Types، وPattern Matching في تمثيل البيانات.
4. **Asynchronous Architecture & Concurrency:**
   إتقان الـ Event Loop، الفرق الدقيق بين Microtask Queue وEvent Queue، وبرمجة الـ Streams المعقدة والـ Reactive Patterns، ثم العزل التام للمهام الثقيلة باستخدام Isolates والـ Actor Model.
5. **Software Quality & Testing:**
   كتابة كود قابل للاختبار (Test-Driven Mindset)، وتطبيق Unit / Integration / Property-based Testing، وقياس التغطية (Code Coverage).
6. **Ecosystem & Performance Optimization:**
   بناء ونشر Packages احترافية متوافقة مع معايير Pub.dev العالمية، واستخدام أدوات القياس (Profiling & Benchmarking)، وكشف تسريبات الذاكرة (Memory Leaks).

---

---

## 4. المنهج التفصيلي للأربعة أسابيع والتكييف البيداغوجي (Beginner-to-Engineer Syllabus)

> **إطار التكييف من الصفر:**  
> كل مفهوم يُدرس وفق **سلم المراحل التسع** (تشبيه حياتي $\rightarrow$ شرح بسيط $\rightarrow$ تمثيل بصري $\rightarrow$ كود بسيط $\rightarrow$ تتبع باليد $\rightarrow$ مثال متوسط $\rightarrow$ مثال متقدم $\rightarrow$ تطبيق هندسي $\rightarrow$ حل مشكلات مستقل).  
> وتُصنف موضوعات كل محاضرة إلى 4 مستويات استيعابية:
> - 🟢 **Core Learning:** إتقان إلزامي وتطبيق مستقل 100% خلال الشهر.
> - 🟡 **Introduction:** مقدمة عملية وفهم سياقي واضح.
> - 🔵 **Advanced Exposure:** اطلاع وفهم معماري عام دون إلزام تعجيزي.
> - 🟣 **Future Learning:** تمهيد للمستقبل والتوسع الذاتي أثناء Flutter وما بعدها.

---

### الأسبوع الأول: التأسيس الحاسوبي، المتغيرات، الدوال، والمجموعات
*الهدف:* بناء التفكير الحاسوبي من الصفر المطلق، وفهم كيف يخزن الكمبيوتر البيانات ويتخذ القرارات ويكرر المهام.

- **Lecture 01: Computational Thinking, Variables, Data Types & Decisions**
  - **المتطلبات السابقة:** لا شيء إطلاقاً (Zero Prior Knowledge).
  - 🟢 **Core Learning:**
    - ما هو البرنامج والكمبيوتر؟ دالة البداية `void main()` والطباعة `print()`.
    - الصناديق والذاكرة: المتغيرات والأنواع الأساسية (`int`, `double`, `String`, `bool`).
    - العمليات الحسابية والدمج النصي (`$variable`).
    - اتخاذ القرار والمنطق: الشروط وجمل `if`, `else if`, `else`، وعمليات المقارنة (`==`, `!=`, `<`, `>`).
  - 🟡 **Introduction:**
    - استنتاج الأنواع التلقائي عبر `var` وتثبيته.
    - مفهوم الـ Null والـ Sound Null Safety البسيط كـ "صندوق آمن يمنع الفراغ المفاجئ" (`?`, `??`).
    - الثوابت الأساسية: الفرق البسيط بين `final` (تثبيت وقت التشغيل) و `const` (تثبيت وقت التجميع).
  - 🔵 **Advanced Exposure:** نظرة سريعة على بنية الـ Dart VM (كيف يتحول الكود لبرنامج يعمل).
  - 🟣 **Future Learning:** التعمق في `Never` type و Canonicalization الذاكري المتقدم.
  - *المشروع العملي:* Financial Transaction Validator Core.

- **Lecture 02: Repetition, Loops, Scope & Functions**
  - **المتطلبات السابقة:** إتقان المتغيرات والأنواع وجمل `if/else` من المحاضرة الأولى.
  - 🟢 **Core Learning:**
    - لماذا نكرر؟ حلقات التكرار البسيطة: `for` و `while`.
    - الدوال كوصفات طهي: المدخلات (Parameters) والمخرجات (Return Types).
    - تفكيك المشكلة الكبيرة إلى 3 أو 4 دوال صغيرة ومستقلة (Problem Decomposition).
    - نطاق رؤية المتغيرات (Scope) وعمر المتغير داخل القوسين `{ }`.
  - 🟡 **Introduction:**
    - الباراميترات المسماة والاختيارية (Named & Optional Parameters `{}` `[]`).
    - الدوال كقيم قابلة للتمرير والتخزين (First-Class Functions).
    - قراءة رسائل الخطأ من الـ Compiler وإصلاح الـ Syntax بهدوء.
  - 🔵 **Advanced Exposure:** مفهوم الـ Closures وتخزين الذاكرة في الـ Heap، ومزايا الـ Tear-offs.
  - 🟣 **Future Learning:** البرمجة الوظيفية المتقدمة وتطوير الـ Higher-Order Pipelines المعقدة.
  - *المشروع العملي:* Flexible Data Transformation Pipeline.

- **Lecture 03: Data Organization: Collections, Records & Basic Patterns**
  - **المتطلبات السابقة:** إتقان المتغيرات، الشروط، الحلقات، والدوال.
  - 🟢 **Core Learning:**
    - كيف ننظم بيانات متعددة معاً؟
    - القائمة (`List`): ترتيب العناصر، الإضافة، الحذف، والوصول عبر الـ Index.
    - المجموعة الفريدة (`Set`): منع التكرار وفحص الوجود السريع.
    - القاموس (`Map`): ربط المفتاح بالقيمة (Key-Value) كدليل هاتف.
    - المرور على المجموعات باستخدام `for-in`.
  - 🟡 **Introduction:**
    - تجميع قيمتين معاً ببساطة باستخدام Dart 3 Records: `(int, String)`.
    - تفكيك البيانات البسيط (Destructuring) دون كلاسات وسيطة.
    - استبدال الـ `if` المتكررة بـ `switch expression`.
  - 🔵 **Advanced Exposure:** مطابقة الأنماط المعقدة (Object Pattern Matching)، والـ Spread Operator `...`.
  - 🟣 **Future Learning:** بنى البيانات المتقدمة وإثبات الـ Big O Complexity الرياضي للهاش كود.
  - *المشروع العملي:* E-Commerce Pattern-Based Order Engine.

- **Weekly Assessment 1:**
  - اختبار قياس الفهم التأسيسي، كتابة دوال وشروط بمفرده، وقراءة كود بسيط وتوقع مخرجاته.
  - تحدي تطبيقي متدرج يدمج الحلقات والمجموعات.

---

### الأسبوع الثاني: التفكير الكائني، النمذجة، والواجهات
*الهدف:* الانتقال من البرمجة الإجرائية إلى التفكير كائني التوجه (OOP) وتصميم الكيانات.

- **Lecture 04: Classes, Objects & The State Blueprint**
  - **المتطلبات السابقة:** إتقان المجموعات والدوال والتفكير الحسابي من الأسبوع الأول.
  - 🟢 **Core Learning:**
    - ما هو الكائن (Object)؟ تمثيل أشياء الواقع (السيارة، المستخدم، الحساب البنكي).
    - الكلاس كـ "قالب صب أو مخطط معماري" (Blueprint).
    - الخصائص (Properties/Fields) والوظائف (Methods).
    - دالة البناء (Generative Constructor) والكلمة المفتاحية `this`.
    - إنشاء كائنات متعددة وتعديل وقراءة خصائصها.
  - 🟡 **Introduction:**
    - حماية البيانات وتغليفها (Encapsulation) عبر الـ Private Fields `_`.
    - الـ Named Constructors لإنشاء كائنات بطرق متعددة.
    - مفهوم الكائنات غير القابلة للتعديل (`const` constructors).
  - 🔵 **Advanced Exposure:** الـ Initializer Lists ومساواة الكائنات (`==` و `hashCode`).
  - 🟣 **Future Learning:** الـ Factory Pattern المتقدم والـ Identity Caching على مستوى الـ VM.
  - *المشروع العملي:* Robust Configuration Management System.

- **Lecture 05: OOP Principles: Inheritance, Abstraction & Composition**
  - **المتطلبات السابقة:** إتقان الكلاسات والكونستركتورز من المحاضرة الرابعة.
  - 🟢 **Core Learning:**
    - مبدأ الوراثة وإعادة الاستخدام: `extends` و استدعاء الـ `super`.
    - إعادة كتابة الدوال (Method Overriding) واستخدام `@override`.
    - التجريد البسيط: الفئات المجردة `abstract class` لتحديد عقود العمل.
  - 🟡 **Introduction:**
    - مبدأ الواجهات: `implements` وكيف نفرض عقداً صارماً على الكلاسات.
    - مشاركة الوظائف أفقياً عبر الـ Mixins (`with`).
    - مبدأ "التركيب أولى من الوراثة" (Composition over Inheritance) بمثال بسيط.
  - 🔵 **Advanced Exposure:** ميزات Dart 3: الـ Class Modifiers (`sealed`, `base`, `interface`) والـ Extension Methods.
  - 🟣 **Future Learning:** الـ Extension Types (Zero-Cost Abstractions) والـ Mixin Linearization العميقة.
  - *المشروع العملي:* Modular Payment Processing Gateway.

- **Lecture 06: Flexible Types: Introduction to Generics**
  - **المتطلبات السابقة:** إتقان الـ OOP والواجهات والمجموعات.
  - 🟢 **Core Learning:**
    - لماذا نحتاج الأنواع العامة؟ كتابة كود مرن يتعامل مع أي نوع بأمان.
    - الـ Generic Collections: لماذا نكتب `List<String>` بدلاً من قائمة عامة؟
    - إنشاء دالة عامة بسيطة: `T getFirstElement<T>(List<T> items)`.
  - 🟡 **Introduction:**
    - إنشاء كلاس عام بسيط مثل صندوق تخزين: `Box<T>`.
    - نمط الـ Result البسيط لحمل النتيجة أو الخطأ: `Result<T>`.
  - 🔵 **Advanced Exposure:** قيود الأنواع (Type Bounds: `<T extends Comparable<T>>`).
  - 🟣 **Future Learning:** التغاير النوعي (Covariance / Contravariance) في محركات اللغات والـ Reified Generics في C++.
  - *المشروع العملي:* Type-Safe Generic Entity Cache Engine.

- **Weekly Assessment 2:**
  - مراجعة وبناء نظام كائنات متكامل، واختبار قراءة وتعديل الكلاسات وتصميم الواجهات.

---

### الأسبوع الثالث: الزمن والبرمجة غير المتزامنة والتوازي
*الهدف:* استيعاب مفهوم الوقت، والانتظار دون تجميد البرنامج، والتعامل مع تدفقات البيانات.

- **Lecture 07: Time, Futures & The Asynchronous Model**
  - **المتطلبات السابقة:** إتقان الـ OOP والدوال ونظام الأنواع.
  - 🟢 **Core Learning:**
    - ما معنى المتزامن (Sync) وغير المتزامن (Async) في الحياة اليومية؟
    - مفهوم الـ `Future`: وعد بوصول قيمة في المستقبل (مثل طلب وجبة دليفري).
    - الكلمات المفتاحية `async` و `await`: الانتظار المنظم للبيانات دون تعليق باقي الكود.
    - معالجة الأخطاء غير المتزامنة ببساطة عبر `try / catch`.
  - 🟡 **Introduction:**
    - دوال الـ Future الشائعة: `Future.delayed()`.
    - نموذج الـ Single-Thread في لغة Dart: لماذا لا تتجمد واجهة المستخدم؟
  - 🔵 **Advanced Exposure:** حلقة الأحداث (The Event Loop) وطابور الـ Microtasks مقابل طابور الـ Events.
  - 🟣 **Future Learning:** جدولة المهام الدقيقة، وإدارة الـ Execution Slices في الـ Dart VM.
  - *المشروع العملي:* Async Job Scheduler & Resilient Worker.

- **Lecture 08: Continuous Data: Introduction to Streams**
  - **المتطلبات السابقة:** إتقان الـ Futures و async/await من المحاضرة السابعة.
  - 🟢 **Core Learning:**
    - الفرق بين القيمة الواحدة (`Future`) وتدفق القيم المستمر (`Stream`) كماسورة مياه تضخ بيانات.
    - الاستماع إلى الـ Stream عبر `stream.listen()`.
    - التكرار على التدفق باستخدام `await for`.
  - 🟡 **Introduction:**
    - تحويل البيانات أثناء التدفق عبر `stream.map()` و `stream.where()`.
    - قاعدة الأمان الذهبية: إيقاف وإلغاء الاشتراك عند الانتهاء `subscription.cancel()`.
    - إنشاء بث بسيط عبر `StreamController`.
  - 🔵 **Advanced Exposure:** الفرق بين Single-Subscription و Broadcast Streams، ومفهوم الـ Backpressure.
  - 🟣 **Future Learning:** تصميم مشغلات تفاعلية مخصصة (Custom Reactive Operators) والتعامل مع RxDart المتقدم.
  - *المشروع العملي:* Real-Time Metrics & Event Bus Engine.

- **Lecture 09: Heavy Work: Background Isolates & Concurrency Intro**
  - **المتطلبات السابقة:** إتقان البرمجة غير المتزامنة والـ Streams.
  - 🟢 **Core Learning:**
    - متى يتجمد البرنامج؟ العمليات الحسابية الضخمة التي تستهلك المعالج (CPU-Bound).
    - الحل العملي البسيط: نقل الحسابات الثقيلة للخلفية بـ `Isolate.run()`.
  - 🟡 **Introduction:**
    - مفهوم العزل: لماذا تمتلك كل Isolate ذاكرتها الخاصة تماماً؟
    - مقارنة بسيطة بين تعدد الخيوط مع الذاكرة المشتركة (خطر الـ Race Conditions) ونموذج الرسائل (Dart Message Passing).
  - 🔵 **Advanced Exposure:** إنشاء قنوات اتصال يدوية باستخدام `ReceivePort` و `SendPort`.
  - 🟣 **Future Learning:** إدارة أحواض العزل (Isolate Pools)، ونقل البيانات الكبيرة بـ `TransferableTypedData` والـ Garbage Collector Internals.
  - *المشروع العملي:* High-Throughput Heavy Data Cruncher.

- **Weekly Assessment 3:**
  - اختبار محاكاة ترتيب الأحداث غير المتزامنة، وبناء خدمة تحميل بيانات وهمية ومعالجتها.

---

### الأسبوع الرابع: الجودة، الاختبارات، وهندسة البرمجيات
*الهدف:* كتابة كود احترافي نظيف، واختباره والتأكد من صموده قبل الانتقال إلى معمارية Flutter.

- **Lecture 10: Organizing Code: Modular Packages & Libraries**
  - **المتطلبات السابقة:** القدرة على كتابة كلاسات ودوال وبرامج متكاملة.
  - 🟢 **Core Learning:**
    - تنظيم المشروع في ملفات ومجلدات منفصلة (`lib/`, `bin/`).
    - استيراد واستخدام الملفات: `import`.
    - ملف تكوين المشروع `pubspec.yaml` وإضافة مكتبات خارجية.
  - 🟡 **Introduction:**
    - قواعد كتابة الكود النظيف (Clean Code & Effective Dart).
    - التوثيق بكود Dart عبر التعليقات التوضيحية `///`.
    - إعداد وتفعيل الـ Linter عبر `analysis_options.yaml`.
  - 🔵 **Advanced Exposure:** معايير الـ Semantic Versioning (SemVer) وبناء الحزم للمكتبات المشتركة.
  - 🟣 **Future Learning:** نشر وإدارة حزم مفتوحة المصدر على Pub.dev وإعداد الـ CI/CD Workflows.
  - *المشروع العملي:* Enterprise-Grade Open Source Package.

- **Lecture 11: Software Quality: Testing & Debugging Mindset**
  - **المتطلبات السابقة:** معرفة تنظيم الملفات وبناء البرامج من المحاضرات السابقة.
  - 🟢 **Core Learning:**
    - لماذا نختبر الكود آلياً بدلاً من التجربة اليدوية المرهقة؟
    - أول اختبار آلي باستخدام مكتبة `test`: كتابة دالة `test()` و فحص النتيجة بـ `expect()`.
    - اختبار الحالات الطبيعية (Happy Path) والحالات الخاطئة.
    - استخدام الـ Debugger و الـ Breakpoints بدلاً من الـ `print` العشوائي.
  - 🟡 **Introduction:**
    - تجميع الاختبارات في مجموعات منطقية `group()`.
    - محاكاة التبعيات الخارجية البسيطة (Stubbing & Basic Mocking).
  - 🔵 **Advanced Exposure:** قياس نسبة تغطية الاختبارات للكود (Code Coverage) واستخدام `mockito`.
  - 🟣 **Future Learning:** اختبارات التوافقية الموسعة (Integration & Property-Based Testing).
  - *المشروع العملي:* Industrial Test Suite & Quality Harness.

- **Lecture 12: Foundations of Performance & The Flutter Gateway**
  - **المتطلبات السابقة:** استيعاب كامل لجميع موضوعات الأسابيع الأربعة.
  - 🟢 **Core Learning:**
    - مراجعة شاملة لجميع المفاهيم الأساسية: من المتغيرات إلى الـ OOP والـ Async.
    - كيف تفكر كمهندس قبل كتابة أي سطر كود جديد؟
    - قائمة التحقق الكاملة للجدارة والاستقلال البرمجي.
  - 🟡 **Introduction:**
    - التمهيد لمعمارية Flutter: كيف تتحول مفاهيم Dart التي تعلمناها إلى شاشات وحالات وتطبيقات حية؟
    - قياس زمن تنفيذ الكود عبر `Stopwatch`.
  - 🔵 **Advanced Exposure:** نظرة عامة على الـ Dart DevTools ومراقبة الذاكرة.
  - 🟣 **Future Learning:** تجميع الـ AOT والـ Machine Code و Profiling المعالجات المتقدمة في الـ Enterprise.
  - *المشروع العملي:* High-Performance Engine Optimizer.

- **Weekly Assessment 4:**
  - المراجعة الشاملة النهائية، تسليم مشروع التخرج، وجلسة الدفاع الهندسي المستقلة.

---

## 5. مشروع التخرج النهائي (Graduation Capstone Project)

**العنوان:** `Dart Modular Engineering Core`  
**الوصف:** بناء نظام هندسي متكامل ومكتفٍ ذاتياً بلغة Dart الخالصة دون أي اعتماد على أطر عمل واجهات، يحاكي محرك معالجة طلبات وتوزيع مدفوعات وتحليلات فورية لمؤسسة تجارية عملاقة.

**المعايير المعمارية للمشروع:**
1. Clean Architecture (Domain, Data, Presentation/CLI layers).
2. Domain Entities مع Immutability صارمة ونظام Types معتمد على Records وPattern Matching.
3. Generic Repository Pattern مع طبقة Memory Cache وطبقة تخزين مستمرة محاكية.
4. نظام معالجة أحداث غير متزامن قائم على Broadcast Streams مع Custom Transformers.
5. استغلال الـ Isolates لمعالجة الحسابات الإحصائية والتشفير في مسارات معزولة بالكامل.
6. معالجة أخطاء موثقة برمجياً باستخدام `Sealed Classes` ونمط `Result<Success, Failure>`.
7. تغطية اختبارات آلية تتجاوز 85% مع Unit Tests وMocking وIntegration Tests.
8. مقاييس أداء مثبتة (Benchmark Suite) تثبت كفاءة استهلاك الذاكرة وسرعة المعالجة.

---

## 6. سياسة التقييم وتوزيع الدرجات (Grading & Evaluation Rubric)

تعتمد شهادة إتمام البرنامج واجتيازه على نظام النقاط التراكمي من 1000 نقطة:

| المكون | التكرار / العدد | النقاط لكل وحدة | إجمالي النقاط | النسبة المئوية |
| :--- | :--- | :--- | :--- | :--- |
| **واجبات المحاضرات (Homework)** | 12 تكليفاً | 25 نقطة | 300 نقطة | 30% |
| **اختبارات المحاضرات (Quizzes)** | 12 اختباراً | 15 نقطة | 180 نقطة | 18% |
| **المشاريع الأسبوعية التجميعية** | 4 أسابيع | 40 نقطة | 160 نقطة | 16% |
| **المشاركة والنقاش المعماري** | طوال الدورة | — | 60 نقطة | 6% |
| **مشروع التخرج النهائي (Capstone)** | مشروع واحد | 300 نقطة | 300 نقطة | 30% |
| **الإجمالي** | — | — | **1000 نقطة** | **100%** |

**حدود الاجتياز:**
- **Pass (اجتياز):** 700 - 799 نقطة (70%).
- **Merit (تقدير جيد جداً):** 800 - 899 نقطة (80%).
- **Distinction (امتياز هندسي):** 900 - 1000 نقطة (90%+).
