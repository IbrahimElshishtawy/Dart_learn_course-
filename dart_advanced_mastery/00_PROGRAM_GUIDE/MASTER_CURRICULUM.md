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

## 4. المنهج التفصيلي للأربعة أسابيع (Detailed Syllabus)

### الأسبوع الأول: Foundations, Type System & Modern Syntax
*الهدف:* إرساء الأساس الصلب لفهم معمارية اللغة، ونظام الأنواع الصارم، والميزات الحديثة في Dart 3.x.

- **Lecture 01: Language Architecture & Type System**
  - كيف تعمل Dart تحت الغطاء؟ (VM, Runtime, JIT vs AOT).
  - الـ Type System الصارم: Static Types vs Dynamic vs Object vs Never vs void.
  - Sound Null Safety: مبدأ الإثبات الرياضي لعدم وجود `NullPointerExceptions` في وقت التشغيل.
  - المتغيرات والذاكرة: `final` vs `const`، الـ Canonicalization، واستخدام `late` ومخاطرها.
  - *المشروع العملي:* Financial Transaction Validator Core.

- **Lecture 02: Functions, Scope & Execution Model**
  - دوال كـ First-Class Citizens: Higher-Order Functions, Closures, Tear-offs.
  - النطاق المعجمي (Lexical Scope) والـ Call Stack وعمر المتغيرات في الذاكرة.
  - Parameters المعمارية: Positional, Named, Optional, Required, Default values.
  - أسلوب Functional Programming في Dart وتجنب الـ Side Effects.
  - *المشروع العملي:* Flexible Data Transformation Pipeline.

- **Lecture 03: Collections, Records & Patterns**
  - تشريح بنى المجموعات: `List`, `Set`, `Map`، وكفاءة العمليات (Big-O Complexity).
  - Modern Features: Spread Operator (`...`), Collection if/for.
  - Records: التجميع النوعي للقيم غير المتجانسة بدون إنشاء فئات ثقيلة.
  - Patterns & Pattern Matching: Destructuring, Switch Expressions, Guard Clauses, Exhaustiveness Checking.
  - *المشروع العملي:* E-Commerce Pattern-Based Order Engine.

- **Weekly Assessment 1:**
  - مراجعة شاملة لمفاهيم الأسبوع الأول.
  - امتحان نظري وعملي على الـ Type System وPatterns.
  - تحدي خوارزمي (Problem Solving Challenge 1).

---

### الأسبوع الثاني: OOP, Class Hierarchy & Advanced Generics
*الهدف:* بناء نماذج برمجية قوية، قابلة لإعادة الاستخدام والصيانة وفق مبادئ هندسة البرمجيات النظيفة.

- **Lecture 04: Classes & Object Model**
  - الفئات كـ Blueprints، الـ Memory Allocation للـ Objects على الـ Heap.
  - Constructors وأنواعها: Generative, Named, Factory, Redirecting, Constant.
  - Initializer Lists وأسبقيتها، `this`، والـ Field Initialization.
  - مساواة الكائنات: `==` و`hashCode` و`identical`، والـ Immutability.
  - *المشروع العملي:* Robust Configuration Management System.

- **Lecture 05: OOP, Inheritance & Composition**
  - الوراثة (Inheritance) و`extends` والـ Super Call.
  - التجريد (Abstraction) والفئات المجردة والـ Implicit Interfaces.
  - Mixins والـ Multiple Inheritance الآمن وقيد `on`.
  - Extension Methods وExtension Types (Dart 3 Zero-cost Abstractions).
  - مبدأ Composition over Inheritance وكيف نصمم معماريات مرنة.
  - *المشروع العملي:* Modular Payment Processing Gateway.

- **Lecture 06: Generics & Advanced Type Modeling**
  - لماذا الـ Generics؟ الأمان النوعي ومنع أخطاء الـ Casting في وقت التشغيل.
  - Type Bounds (`<T extends Comparable<T>>`) والـ Constraints.
  - التغاير النوعي (Covariance in Dart Collections) وكيف تتعامل الـ VM معه.
  - بناء فئات ومستودعات عامة (Generic Repositories) ونمط Result/Either Type.
  - *المشروع العملي:* Type-Safe Generic Entity Cache Engine.

- **Weekly Assessment 2:**
  - مراجعة شاملة للأسبوع الثاني.
  - اختبار معماري على تصميم الكائنات والـ Mixins والـ Generics.
  - تحدي هندسة البرمجيات (Software Architecture Challenge 2).

---

### الأسبوع الثالث: Concurrency, Event Loop & Dart VM Runtime
*الهدف:* كشف أسرار المعالجة غير المتزامنة وتوزيع المهام الثقيلة وإدارة الذاكرة.

- **Lecture 07: Asynchronous Programming & Event Loop**
  - حقيقة الـ Single-Threaded Execution في Dart.
  - تشريح حلقة الأحداث: Microtask Queue vs Event Queue وترتيب الأسبقية.
  - كائنات `Future` ودورات حياتها، `async` و`await` وما يفعله المترجم خلف الكواليس.
  - معالجة الأخطاء غير المتزامنة: `try-catch`، `onError`، وتجنب الـ Unhandled Exceptions.
  - *المشروع العملي:* Async Job Scheduler & Resilient Worker.

- **Lecture 08: Streams & Reactive Programming**
  - ماهية الـ Streams كأنابيب للبيانات غير المتزامنة عبر الزمن.
  - Single-subscription Streams مقابل Broadcast Streams.
  - StreamControllers وSink وStreamSubscription.
  - تحويل البيانات: `StreamTransformer`، وعمليات `map`، `where`، `debounce`، `throttle`.
  - إدارة الموارد وتفادي الـ Memory Leaks وإلغاء الاشتراكات بدقة.
  - *المشروع العملي:* Real-Time Metrics & Event Bus Engine.

- **Lecture 09: Isolates, Concurrency & Memory**
  - نموذج الفاعل (Actor Model) وتعدد خطوط التنفيذ دون ذاكرة مشتركة.
  - متى نستخدم Isolates؟ (تجنب تجميد الـ UI ومعالجة العمليات الحسابية الضخمة).
  - `Isolate.spawn`، `ReceivePort`، و`SendPort`، وآلية Message Passing.
  - Dart 2.19+ `Isolate.run` والتعامل الحديث مع المهام المنفصلة.
  - نقل البيانات عالي الكفاءة عبر `TransferableTypedData`.
  - نظرة معمارية على Dart Garbage Collector (Generational GC: Scavenge vs Mark-Sweep).
  - *المشروع العملي:* High-Throughput Heavy Data Cruncher.

- **Weekly Assessment 3:**
  - مراجعة تفاعلية ومحاكاة يدوية لترتيب الـ Event Loop.
  - اختبار عملي في إنشاء Isolates والتحكم في تدفق الـ Streams.
  - تحدي التزامن المعقد (Concurrency Challenge 3).

---

### الأسبوع الرابع: Engineering Quality, Tooling & Dart VM Internals
*الهدف:* تحويل الكود إلى برمجيات صناعية جاهزة للإنتاج، واختبارها وقياس أدائها وتجميعها.

- **Lecture 10: Dart Ecosystem & Package Engineering**
  - هيكل الحزم القياسي (Package Layout Conventions: `lib/`, `bin/`, `example/`, `test/`).
  - ملف `pubspec.yaml` وإدارة التبعيات الصارمة (Semantic Versioning `^1.0.0`).
  - التصدير والكبسلة: `library`, `part`, `part of`, و`export` وشروط الـ Public API.
  - التوثيق الاحترافي بكود Dart وعلامات `///` ومولد `dart doc`.
  - معايير التحليل الثابت (Static Analysis): `analysis_options.yaml` وقواعد Linter المتقدمة.
  - *المشروع العملي:* Enterprise-Grade Open Source Package.

- **Lecture 11: Testing, Debugging & Software Quality**
  - أهرامات الاختبار (Testing Pyramid) في Dart.
  - حزمة `test`: Unit Testing, Groups, Matchers, Setup/TearDown.
  - تقنيات الـ Mocking: `mockito` وعزل التبعيات والـ Dependency Injection.
  - قياس نسبة التغطية (Code Coverage) وتوليد تقارير LCOV.
  - تقنيات تصحيح الأخطاء المتقدمة، Breakpoints، وAssert Statements في بيئة التطوير.
  - *المشروع العملي:* Industrial Test Suite & Quality Harness.

- **Lecture 12: Runtime, Compilation & Performance**
  - تشريح Dart VM الداخلي: Memory Pages, Heap, Scavenger, Global Allocations.
  - خط أنابيب التجميع: JIT (Just-In-Time) للتطوير وAOT (Ahead-Of-Time) للإنتاج.
  - قياس الأداء العملي عبر `BenchmarkBase` والتحليل الزمني الدقيق بالـ Microseconds.
  - تجنب فخاخ الأداء: فخاخ تخصيص الكائنات المتكررة، استهلاك الذاكرة في المجموعات الكبيرة، والـ Const Canonicalization.
  - مراجعة شاملة لربط كافة أجزاء الكورس قبل الانتقال إلى المشروع النهائي.
  - *المشروع العملي:* High-Performance Engine Optimizer.

- **Weekly Assessment 4:**
  - اختبار شامل على هندسة الحزم والاختبارات وتحسين الأداء.
  - تسليم خطة مشروع التخرج النهائي.

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
