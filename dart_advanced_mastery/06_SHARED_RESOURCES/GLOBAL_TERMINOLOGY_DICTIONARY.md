# Global Terminology Dictionary — قاموس المصطلحات الهندسية الموحد

يحتوي هذا القاموس على المفاهيم والمصطلحات الأساسية والمتقدمة في علوم الحاسب ولغة Dart ومعمارية النظم وFlutter، مشروحة بدقة تقنية وباللهجة المصرية التبسيطية الذكية لترسيخ الفهم الهندسي.

---

## فهرس المصطلحات الأبجدي

1. [Abstraction](#1-abstraction)
2. [Encapsulation](#2-encapsulation)
3. [Polymorphism](#3-polymorphism)
4. [Composition](#4-composition)
5. [Dependency Injection (DI)](#5-dependency-injection-di)
6. [Dependency Inversion Principle (DIP)](#6-dependency-inversion-principle-dip)
7. [Type Safety](#7-type-safety)
8. [Immutability](#8-immutability)
9. [Mutability](#9-mutability)
10. [Referential Transparency](#10-referential-transparency)
11. [Side Effects](#11-side-effects)
12. [Lazy Evaluation](#12-lazy-evaluation)
13. [Eager Evaluation](#13-eager-evaluation)
14. [Concurrency](#14-concurrency)
15. [Parallelism](#15-parallelism)
16. [Event Loop](#16-event-loop)
17. [Microtask Queue](#17-microtask-queue)
18. [Isolate](#18-isolate)
19. [Message Passing](#19-message-passing)
20. [Stream Subscription](#20-stream-subscription)
21. [Backpressure](#21-backpressure)
22. [Garbage Collection (GC)](#22-garbage-collection-gc)
23. [Memory Allocation](#23-memory-allocation)
24. [Memory Leak](#24-memory-leak)
25. [Serialization](#25-serialization)
26. [Deserialization](#26-deserialization)
27. [Reflection](#27-reflection)
28. [Code Generation](#28-code-generation)
29. [Runtime](#29-runtime)
30. [Compilation](#30-compilation)
31. [JIT (Just-In-Time)](#31-jit-just-in-time)
32. [AOT (Ahead-Of-Time)](#32-aot-ahead-of-time)
33. [Benchmarking](#33-benchmarking)
34. [Profiling](#34-profiling)
35. [Big O Notation](#35-big-o-notation)
36. [Time Complexity](#36-time-complexity)
37. [Space Complexity](#37-space-complexity)
38. [Race Condition](#38-race-condition)
39. [Deadlock](#39-deadlock)
40. [SOLID Principles](#40-solid-principles)
41. [Clean Architecture](#41-clean-architecture)
42. [Repository Pattern](#42-repository-pattern)
43. [Factory Pattern](#43-factory-pattern)
44. [Strategy Pattern](#44-strategy-pattern)
45. [Observer Pattern](#45-observer-pattern)
46. [Adapter Pattern](#46-adapter-pattern)

---

### 1. Abstraction
- **الترجمة العربية:** التجريد.
- **الشرح باللهجة المصرية:** إنك تدي اللي بيستخدم الكود الزتونة والواجهة البسيطة وتخفي عنه كل وجع الدماغ والتفاصيل المعقدة اللي جوه. زي ما بتدوس على دواسة البنزين في العربية وتمشي من غير ما تعرف الموتور حقن كام ملي وقود.
- **المعنى التقني الدقيق:** A design technique that hides internal implementation details and exposes only the essential interface to the consumer.
- **مثال عملي:** `abstract class PaymentGateway { Future<bool> pay(double amount); }`
- **استخدامه في Dart:** الـ `abstract class` والـ `interface class` لإلزام الفئات بتنفيذ سلوك معين دون كشف التفاصيل.
- **علاقته بـ Flutter:** كل الـ Widgets عبارة عن Abstraction لرسم مستطيلات وبكسلات على شاشة الـ Skia/Impeller.
- **متى تحتاجه مستقبلاً؟** عند بناء كود نظيف وتصميم طبقات الـ Clean Architecture.

---

### 2. Encapsulation
- **الترجمة العربية:** الكبسلة / إخفاء البيانات.
- **الشرح باللهجة المصرية:** إنك تحبس المتغيرات الحساسة جوه الكلاس وتقفل عليها بالضبة والمفتاح، ومحدش يقدر يعدل فيها من بره إلا بحساب ومن خلال شروط واضحة عبر Getters وSetters أو دوال محددة.
- **المعنى التقني الدقيق:** Bundling data and the methods that operate on that data within a single unit, and restricting direct access to internal state.
- **مثال عملي:** جعل الحقل `_balance` خاصاً واستخدام دالة `deposit(double amount)`.
- **استخدامه في Dart:** استخدام الـ Underscore `_` قبل اسم المتغير أو الفئة لجعله خاصاً على مستوى الـ Library (Library-private).
- **علاقته بـ Flutter:** الحفاظ على الـ Private State داخل الـ `StatefulWidget` أو الـ `Cubit`.
- **متى تحتاجه؟** في أي نظام مالي أو قواعد أعمال لمنع التعديل العشوائي للبيانات.

---

### 3. Polymorphism
- **الترجمة العربية:** تعدد الأشكال.
- **الشرح باللهجة المصرية:** إن كائن واحد يقدر ياخد كذا شكل ويتصرف بطرق مختلفة حسب نوعه، وإنت كديفلوبر تنادي نفس الأمر وهو ينفذه بطريقته الخاصة. زي زرار الباور بيطفي الموبايل بس بيطفي التلفزيون بشكل تاني.
- **المعنى التقني الدقيق:** The ability of different classes to respond to the same interface or method call with their own distinct implementations.
- **مثال عملي:** استدعاء `shape.area()` سواء كان الكائن `Circle` أو `Square`.
- **استخدامه في Dart:** عمل `@override` لدوال الفئة الأب في الفئات المشتقة.
- **علاقته بـ Flutter:** تمرير أي ويدجت ترث من `Widget` داخل قائمة `children: <Widget>[]`.
- **متى تحتاجه؟** عند بناء أنظمة مرنة تدعم إضافات متعددة (Plugins/Adapters).

---

### 4. Composition
- **الترجمة العربية:** التركيب / التجميع.
- **الشرح باللهجة المصرية:** بدل ما تورث كل حاجة من أب واحد وتعمل شجرة عائلة معقدة، ركب الكلاس بتاعك من قطع صغيرة جاهزة بتعمل مهام محددة. مبدأ: "يمتلك كذا" (Has-A) أفضل من "هو كذا" (Is-A).
- **المعنى التقني الدقيق:** Assembling complex objects by combining simpler, independent objects rather than inheriting behavior through class inheritance.
- **مثال عملي:** كلاس `Car` يحتوي على كائن `Engine` وكائن `Battery`.
- **استخدامه في Dart:** تفضيل حقن الكائنات المستقلة في الـ Constructor بدل الـ `extends`.
- **علاقته بـ Flutter:** جوهر فلاتر قائم على الكومبوزيشن: `Container(child: Padding(child: Text()))`.
- **متى تحتاجه؟** لتجنب فخاخ الوراثة الصلبة (Brittle Base Class Problem).

---

### 5. Dependency Injection (DI)
- **الترجمة العربية:** حقن التبعيات.
- **الشرح باللهجة المصرية:** بدل ما الكلاس يروح يعمل `new` للحاجات اللي محتاجها بنفسه، إنت اللي بتجهزهاله وتديهاله من بره في الـ Constructor. الكلاس ملوش دعوة الحاجة اتعملت إزاي، هو بيستلمها ويشتغل بيها علطول.
- **المعنى التقني الدقيق:** A software design pattern where an object receives its dependencies from an external source rather than creating them internally.
- **مثال عملي:** `UserRepository(this.apiClient);` بدل كتابة `final apiClient = ApiClient();` جوه.
- **استخدامه في Dart:** استخدام Constructor Injection واستخدام مكتبات مثل `get_it`.
- **علاقته بـ Flutter:** توفير الخدمات والـ Blocs عبر `RepositoryProvider` أو `GetIt`.
- **متى تحتاجه؟** لكتابة كود قابل للاختبار (Testable) وعزل السيرفر الحقيقي عن الـ Mock.

---

### 6. Dependency Inversion Principle (DIP)
- **الترجمة العربية:** مبدأ عكس الاعتمادية (حرف الـ D في SOLID).
- **الشرح باللهجة المصرية:** الكلاسات الكبيرة والسيستم الحساس ميعتمدش على كلاسات صغيرة وتفاصيل متغيرة؛ الاتنين لازم يعتمدوا على تجريد (Interface). زي ما الفيشة في الحيطة مش متفصلة على تلاجة معينة، هي Interface يركب عليه أي جهاز.
- **المعنى التقني الدقيق:** High-level modules should not depend on low-level modules; both should depend on abstractions. Abstractions should not depend on details.
- **مثال عملي:** طبقة الـ UseCase تعتمد على `abstract class AuthRepository` وليس على `FirebaseAuthServiceImpl`.
- **استخدامه في Dart:** تعريف Interfaces واستخدامها كأنواع للمتغيرات.
- **علاقته بـ Flutter:** فصل الـ Business Logic تماماً عن مكتبات الـ HTTP أو قواعد البيانات مثل Hive وSqflite.
- **متى تحتاجه؟** في معمارية Clean Architecture لتبديل أي مكتبة خارجية بغيرها بسهولة دون لمس المنطق الأساسي.

---

### 7. Type Safety
- **الترجمة العربية:** الأمان النوعي.
- **الشرح باللهجة المصرية:** إن لغة البرمجة متسمحلكش تعك وتحط قيمة رقمية مكان نص أو تبعت نوع غلط لدالة، وتكشفلك الهبل ده وإنت بتكتب الكود (Compile Time) قبل ما التطبيق يروح للعميل ويقفل في وشه.
- **المعنى التقني الدقيق:** The extent to which a programming language prevents type errors, ensuring that operations are only executed on valid, compatible types.
- **مثال عملي:** منع كتابة `int x = "hello";` بواسطة الـ Analyzer.
- **استخدامه في Dart:** لغة Dart تتمتع بـ Sound Type System يضمن سلامة الأنواع وعدم حدوث انهيارات نوعية غير متوقعة.
- **علاقته بـ Flutter:** منع الـ Red Screen of Death الناتجة عن محاولة قراءة حقول غير موجودة.
- **متى تحتاجه؟** طوال حياتك المهنية لكتابة كود مستقر يمكن الاعتماد عليه.

---

### 8. Immutability
- **الترجمة العربية:** الثبات / عدم القابلية للتغيير.
- **الشرح باللهجة المصرية:** إن الكائن بعد ما يتولد ويتعمله إنشاء في الذاكرة، مفيش أي كائن حي يقدر يغير حرف فيه. لو عايز تغير، بتعمل نسخة جديدة بالقيم المعدلة.
- **المعنى التقني الدقيق:** The property of an object whose state cannot be modified after it is instantiated in memory.
- **مثال عملي:** استخدام `final` و`@immutable` ونمط `copyWith`.
- **استخدامه في Dart:** فئات `const` وسجلات `Records` والـ Collections المغلفة بـ `List.unmodifiable`.
- **علاقته بـ Flutter:** مبدأ أساسي في الـ State Management؛ تغيير الحالة يعني إرسال State جديد Immutable لتحديث الـ UI.
- **متى تحتاجه؟** لمنع أخطاء التزامن والـ Race Conditions وجعل سلوك التطبيق متوقعاً بنسبة 100%.

---

### 9. Mutability
- **الترجمة العربية:** القابلية للتعديل.
- **الشرح باللهجة المصرية:** إن الكائن تقدر تمد إيدك وتغير في المتغيرات بتاعته وهو قاعد في نفس مكانه في الذاكرة. ميزة في السرعة أحياناً، بس صداع في تتبع الأخطاء.
- **المعنى التقني الدقيق:** The property of an object that allows its internal state to be altered after its creation.
- **مثال عملي:** إضافة عناصر لقائمة `list.add(5)`.
- **استخدامه في Dart:** استخدام متغيرات `var` و`Lists` القياسية القابلة للزيادة.
- **علاقته بـ Flutter:** الـ State الداخلية لـ `StatefulWidget` قابلة للتغيير عبر استدعاء `setState`.
- **متى تحتاجه؟** في معالجة الخوارزميات الحسابية عالية الكفاءة (In-place sorting).

---

### 10. Referential Transparency
- **الترجمة العربية:** الشفافية المرجعية.
- **الشرح باللهجة المصرية:** إن الدالة تكون محترمة ومستقيمة؛ لو اديتها نفس المدخلات كل يوم تديك نفس النتيجة بالظبط، وممكن تشيل استدعاء الدالة وتحط بداله قيمتها من غير ما أي حاجة في البرنامج تتأثر.
- **المعنى التقني الدقيق:** An expression is referentially transparent if it can be replaced with its corresponding value without changing the program's behavior.
- **مثال عملي:** دالة رياضية `int add(int a, int b) => a + b;`
- **استخدامه في Dart:** كتابة Pure Functions في البرمجة الوظيفية.
- **علاقته بـ Flutter:** دوال الـ Reducers في Redux أو الـ Mappers في BLoC.
- **متى تحتاجه؟** في الـ Unit Testing السريع والموثوق.

---

### 11. Side Effects
- **الترجمة العربية:** الآثار الجانبية.
- **الشرح باللهجة المصرية:** إن الدالة تكون بتعمل حاجة زيادة من ورا ضهرك غير حساب القيمة المرجعة، زي إنها تعدل متغير عام بره، أو تمسح ملف، أو تبعت ريكويست، فتغير حالة السيستم الخارجي.
- **المعنى التقني الدقيق:** Any modification of state or interaction with the outside world (I/O, database, global state) that occurs within a function.
- **مثال عملي:** دالة بتحسب السعر وتقوم معدلة متغير `totalRevenue` جلوبال.
- **استخدامه في Dart:** حصر الـ Side effects في أماكن محددة مثل Repositories والخدمات.
- **علاقته بـ Flutter:** استدعاء `print()` أو كتابة بيانات على الـ Local Storage داخل دالة `build()` يعتبر كارثة معمارية بسبب الآثار الجانبية.
- **متى تحتاجه؟** لفهم كيف تعزل الكود الحسابي النقي عن كود الاتصالات والملفات.

---

### 12. Lazy Evaluation
- **الترجمة العربية:** التقييم الكسول.
- **الشرح باللهجة المصرية:** السيستم ميتعبش نفسه ويحسب الحاجة أو يحجز مكانها في الذاكرة إلا في الثانية اللي إنت تطلبها فيها فعلياً وتكون محتاجها بالاسم.
- **المعنى التقني الدقيق:** An evaluation strategy that delays the computation of an expression until its value is explicitly required.
- **مثال عملي:** الكلمة المفتاحية `late final service = ComplexService();` أو استخدام `Iterable.map()`.
- **استخدامه في Dart:** استهلاك البيانات عبر `Iterable` و`sync*` و`yield`.
- **علاقته بـ Flutter:** عمل `ListView.builder`؛ لا يقوم ببناء الـ Widget إلا لما تظهر على الشاشة.
- **متى تحتاجه؟** عند التعامل مع كميات داتا ضخمة لمنع استهلاك الذاكرة وتجميد التطبيق.

---

### 13. Eager Evaluation
- **الترجمة العربية:** التقييم الحريص / الفوري.
- **الشرح باللهجة المصرية:** إن الكود يحسب كل القيم ويولد كل العناصر فوراً أول ما يوصل للسطر ده، حتى لو مش هتستخدم نص الداتا دي دلوقتي.
- **المعنى التقني الدقيق:** An evaluation strategy where an expression is evaluated as soon as it is bound to a variable.
- **مثال عملي:** إنشاء قائمة صريحة `final list = [1, 2, 3].map((e) => e * 2).toList();`
- **استخدامه في Dart:** المتغيرات العادية التي تأخذ قيمتها فور الإعلان عنها.
- **علاقته بـ Flutter:** استخدام `Column(children: [...])` بدلاً من `ListView.builder` عند بناء عدد كبير من العناصر يسبب مشاكل أداء بسبب التقييم الفوري.
- **متى تحتاجه؟** عند التأكد أن كل القيم مطلوبة فوراً ولتجنب إعادة الحساب المتكرر.

---

### 14. Concurrency
- **الترجمة العربية:** التزامن / المعالجة المتزامنة.
- **الشرح باللهجة المصرية:** إن البرنامج يتعامل مع كذا مهمة في نفس الوقت من خلال التبديل السريع بينهم (Juggling). زي شيف شغال لوحده في المطبخ، حط المكرونة تتسلق، وفي نفس الدقيقة بيقطع الطماطم، مش قاعد مستني المية تغلي.
- **المعنى التقني الدقيق:** The ability of an execution environment to manage multiple computations simultaneously by interleaving their execution steps.
- **مثال عملي:** استخدام `Future` و`async/await` داخل الـ Single Isolate.
- **استخدامه في Dart:** تنظيم الأحداث والـ I/O عبر الـ Event Loop.
- **علاقته بـ Flutter:** الحفاظ على سلاسة واجهة المستخدم واستقبال لمسات الشاشة أثناء تحميل البيانات من السيرفر.
- **متى تحتاجه؟** في أي كود شبكة أو قواعد بيانات.

---

### 15. Parallelism
- **الترجمة العربية:** التوازي الفعلي.
- **الشرح باللهجة المصرية:** هنا بقى مفيش شيف واحد بيتنطط، هنا جبنا كذا شيف بجد (تعدد أنوية المعالج Multi-core)، وكل شيف ماسك طبخة شغالة في نفس الثانية الحقيقية جنباً إلى جنب.
- **المعنى التقني الدقيق:** Executing multiple calculations simultaneously at the exact same physical instant using multiple processor cores.
- **مثال عملي:** تشغيل كود Dart داخل عدة `Isolates`.
- **استخدامه في Dart:** `Isolate.run()` و`Isolate.spawn()`.
- **علاقته بـ Flutter:** معالجة الصور وفك ملفات الـ JSON العملاقة في الخلفية لمنع نزول معدل الـ FPS.
- **متى تحتاجه؟** في العمليات الرياضية الشاقة (CPU-intensive tasks).

---

### 16. Event Loop
- **الترجمة العربية:** حلقة الأحداث.
- **الشرح باللهجة المصرية:** دي المايسترو الخفي اللي واقف في نص Dart VM؛ بيفضل يلف في حلقة لا نهائية، أول ما يلاقي الـ Call Stack فضي، يجيب الحدث اللي عليه الدور من الطابور وينفذه، وهكذا مبيقفش.
- **المعنى التقني الدقيق:** An endless architectural loop in the runtime that dispatches events and messages from queues to the call stack for execution.
- **مثال عملي:** كيف يتم تشغيل الـ Callbacks والـ Timer والـ Network responses.
- **استخدامه في Dart:** المحرك الأساسي لكامل معمارية الـ Asynchronous Execution.
- **علاقته بـ Flutter:** فهم ترتيب الـ Rebuilds والرسم على الشاشة واستجابة اللمس.
- **متى تحتاجه؟** لحل الأخطاء المعقدة الناتجة عن توقيت التنفيذ (Timing bugs).

---

### 17. Microtask Queue
- **الترجمة العربية:** طابور المهام الدقيقة / العاجلة.
- **الشرح باللهجة المصرية:** ده طابور الـ VIP اللي بيقف قدام طابور الأحداث العادي. أي مهمة محطوطة فيه لازم تتنفذ فوراً قبل ما الـ Event Loop يبص حتى على أي نقرة شاشة أو رد شبكة في الطابور التاني.
- **المعنى التقني الدقيق:** A high-priority queue processed by the Dart Event Loop immediately after the call stack empties and before the standard Event Queue.
- **مثال عملي:** `scheduleMicrotask(() => print('VIP Task'));`
- **استخدامه في Dart:** العمليات الداخلية الحساسة وتنفيذ أجزاء من وعود الـ Futures.
- **علاقته بـ Flutter:** الحذر الشديد من وضع عمليات طويلة فيه لعدم تجميد الواجهة تماماً.
- **متى تحتاجه؟** عند كتابة مكتبات متقدمة تحتاج أسبقية تنفيذ قبل معالجة باقي الأحداث.

---

### 18. Isolate
- **الترجمة العربية:** المسار المعزول.
- **الشرح باللهجة المصرية:** جزيرة مستقلة بذاتها جوا Dart؛ ليها الـ Memory Heap بتاعتها والـ Event Loop المستقل، مفيش أي كائن يقدر يلمس كائن في Isolate تاني، والتعامل بينهم بيكون بس بتبادل الرسائل عبر البحر.
- **المعنى التقني الدقيق:** An isolated execution thread in Dart with its own private heap memory and event loop, sharing no mutable state with other isolates.
- **مثال عملي:** `await Isolate.run(() => heavyCalculation());`
- **استخدامه في Dart:** تحقيق الـ True Parallelism وتفادي أخطاء الـ Memory Sharing.
- **علاقته بـ Flutter:** حل مشاكل تقطيع الأنيميشن وتأخر استجابة الشاشة.
- **متى تحتاجه؟** في التشفير، وضغط الملفات، ومعالجة النصوص والصور الضخمة.

---

### 19. Message Passing
- **الترجمة العربية:** تبادل الرسائل.
- **الشرح باللهجة المصرية:** طريقة التواصل الوحيدة بين الـ Isolates؛ بتبعت نسخة من البيانات على شكل رسالة من البوابة دي للبوابة التانية، ومفيش أي كلاس بيشارك مرجع ذاكرة مع غيره.
- **المعنى التقني الدقيق:** A communication pattern where independent execution units coordinate by transmitting messages via ports instead of accessing shared memory.
- **مثال عملي:** إرسال بيانات عبر `SendPort.send(message)` واستقبالها في `ReceivePort.listen()`.
- **استخدامه في Dart:** التواصل بين الـ Background Isolates والـ Main Thread.
- **علاقته بـ Flutter:** الطريقة التي يتواصل بها كود Dart مع الـ Platform Channels ومحرك الرسوميات.
- **متى تحتاجه؟** عند بناء تطبيقات معقدة متعددة المهام المتزامنة.

---

### 20. Stream Subscription
- **الترجمة العربية:** الاشتراك في تدفق البيانات.
- **الشرح باللهجة المصرية:** العقد اللي بينك وبين ماسورة البيانات (Stream)؛ بيفضل ودنه مع الماسورة، أول ما ينزل فيها رقم أو حدث، ينفذ الكود بتاعك، وتقدر بأمر واحد توقفه مؤقتاً أو تلغيه نهائياً.
- **المعنى التقني الدقيق:** An active listener handle returned when listening to a Stream, providing control over pausing, resuming, or cancelling event consumption.
- **مثال عملي:** `final sub = stream.listen((data) => print(data)); sub.cancel();`
- **استخدامه في Dart:** إدارة دورة حياة الاشتراكات وتجنب تسريب الذاكرة (Memory Leaks).
- **علاقته بـ Flutter:** إلغاء الـ Subscriptions في دالة `dispose()` داخل الـ State.
- **متى تحتاجه؟** عند التعامل مع الـ WebSockets، مستشعرات الهاتف (Sensors)، أو الـ State Management.

---

### 21. Backpressure
- **الترجمة العربية:** الضغط الارتدادي / فائض التدفق.
- **الشرح باللهجة المصرية:** لما السيرفر أو المصدر يفضل يرمي عليك داتا بسرعة خارقة إنت كجهاز مش قادر تعالجها بالسرعة دي؛ الماسورة بتتملي وهتفرقع في وشك لو مفيش آلية تنظم أو تخنق التدفق (Throttle/Debounce).
- **المعنى التقني الدقيق:** The resistance or handling strategy implemented when a data producer generates events faster than the consumer can process them.
- **مثال عملي:** مربع بحث في تطبيق؛ لا تبعت ريكويست مع كل حرف، بل انتظر 300 ملي ثانية حتى يتوقف المستخدم عن الكتابة (Debounce).
- **استخدامه في Dart:** استخدام Custom StreamTransformers أو حزمة `rxdart`.
- **علاقته بـ Flutter:** منع تهنيج حقول الإدخال والـ Auto-complete.
- **متى تحتاجه؟** في أي تدفق بيانات سريع مثل أسعار البورصة أو البحث اللحظي.

---

### 22. Garbage Collection (GC)
- **الترجمة العربية:** جامع القمامة / تفريغ الذاكرة التلقائي.
- **الشرح باللهجة المصرية:** عامل النظافة الصامت اللي شغال في خلفية Dart VM؛ يلف على الـ Heap يشوف الكائنات اللي مبقاش ليها أي مرجع أو حد باصص عليها ويمسحها من الذاكرة علشان يرجع المساحة دي للنظام.
- **المعنى التقني الدقيق:** An automatic memory management subsystem that reclaims memory occupied by objects that are no longer accessible by the running program.
- **مثال عملي:** الـ Generational GC في Dart (Scavenger للكائنات حديثة الولادة وMark-Sweep للكائنات المعمرة).
- **استخدامه في Dart:** إدارة الذاكرة دون تدخل يدوي مثل C/C++.
- **علاقته بـ Flutter:** لو الـ GC اشتغل في وقت مش مناسب بسبب كثرة تخصيص الكائنات، هيحصل سقوط في الفريمات (Dropped Frames).
- **متى تحتاجه؟** لتحليل أداء التطبيق وتقليل عمليات الـ Allocation المتكررة.

---

### 23. Memory Allocation
- **الترجمة العربية:** تخصيص الذاكرة.
- **الشرح باللهجة المصرية:** عملية حجز مكان فيزيائي في شرائح الذاكرة العشوائية (RAM) لكائن أو متغير جديد طلبته بالـ `new` أو بإنشاء كلاس.
- **المعنى التقني الدقيق:** The process of reserving a block of computer memory (Stack or Heap) for storing program instructions and data structures.
- **مثال عملي:** `final order = Order();` تقوم بحجز مساحة في الـ Heap لحقول الكائن.
- **استخدامه في Dart:** Dart توظف تخصيص سريع للغاية (Bump Allocation) في منطقة الـ Young Generation.
- **علاقته بـ Flutter:** إعادة تدوير الكائنات واستخدام `const` لتفادي حجز أماكن مكررة.
- **متى تحتاجه؟** عند تحسين سرعة التطبيق وتقليل استهلاك البطارية.

---

### 24. Memory Leak
- **الترجمة العربية:** تسريب الذاكرة.
- **الشرح باللهجة المصرية:** كارثة هندسية صامتة! كائن إنت خلصت شغل بيه ومش محتاجه خلاص، بس سايب مرجع بالغلط باصص عليه (زي StreamSubscription مش مقفول)، فـ الـ GC ميعرفش يمسحه، والرام تفضل تتملي لحد ما النظام يقفل البرنامج بالقوة (OOM Crash).
- **المعنى التقني الدقيق:** An unintended retention of memory by unreachable or obsolete objects that cannot be reclaimed by the garbage collector.
- **مثال عملي:** نسيان `streamSubscription.cancel()` أو حفظ كائنات في قائمة `static` للأبد.
- **استخدامه في Dart:** كشف التسريبات باستخدام Dart DevTools Memory Tab.
- **علاقته بـ Flutter:** بطء التطبيق بمرور الوقت وانهياره على الأجهزة الضعيفة.
- **متى تحتاجه؟** في مراحل الـ Profiling ومراجعة الكود قبل الإطلاق.

---

### 25. Serialization
- **الترجمة العربية:** التسلسل / الترميز.
- **الشرح باللهجة المصرية:** تحويل كائن Dart حي بكل علاقاته ومحتوياته إلى صيغة نصوص أو بايتات مسطحة (زي سلسلة JSON) علشان نقدر نحفظه في ملف أو نبعته عبر كابل الشبكة للسيرفر.
- **المعنى التقني الدقيق:** Converting an in-memory object into a standardized, storable, or transmittable format (such as JSON or binary byte buffer).
- **مثال عملي:** دالة `user.toJson()`.
- **استخدامه في Dart:** مكتبة `dart:convert` وحزم توليد الكود مثل `json_serializable`.
- **علاقته بـ Flutter:** التواصل مع REST APIs والـ Caching المحلي.
- **متى تحتاجه؟** في أي تطبيق يتواصل مع خادم سحابي.

---

### 26. Deserialization
- **الترجمة العربية:** فك التسلسل / استعادة الكائنات.
- **الشرح باللهجة المصرية:** العملية العكسية للتسلسل؛ استلام نص الـ JSON الخام اللي جاي من السيرفر وإعادة بعثه وتجسيده في الذاكرة ككائن Dart نوعي (Strongly Typed Object) نقدر ننادي حقوله بأمان.
- **المعنى التقني الدقيق:** Reconstructing an active data structure or object in memory from a serialized string or byte stream.
- **مثال عملي:** استدعاء `User.fromJson(jsonMap)`.
- **استخدامه في Dart:** تحويل الـ JSON Maps إلى Data Classes.
- **علاقته بـ Flutter:** تحويل استجابات الـ HTTP Responses إلى نماذج Model نظيفة.
- **متى تحتاجه؟** في طبقة الـ Data Layer في Clean Architecture.

---

### 27. Reflection
- **الترجمة العربية:** الانعكاس / فحص الكود الذاتي.
- **الشرح باللهجة المصرية:** إن البرنامج وهو شغال في وقت التشغيل (Runtime) يقف يبص في المراية ويكتشف الكلاسات والمتغيرات بتاعته والدوال اللي جواه ويناديها بالاسم بدون ما يكون عارفها وقت الـ Compile.
- **المعنى التقني الدقيق:** The ability of a program to inspect, introspect, and modify its own structure and behavior at runtime.
- **مثال عملي:** مكتبة `dart:mirrors` القديمة.
- **استخدامه في Dart:** **معطلة عمداً** في تطبيقات Flutter والـ AOT المجمعة لأنها تدمر الـ Tree Shaking وتضخم حجم التطبيق.
- **علاقته بـ Flutter:** استبدال الانعكاس بالكامل بآلية الـ Code Generation المسبق.
- **متى تحتاجه؟** لفهم لماذا تفرض Dart أدوات مثل `build_runner`.

---

### 28. Code Generation
- **الترجمة العربية:** توليد الكود البرمجي الآلي.
- **الشرح باللهجة المصرية:** سكربت ذكي شغال في وقت التطوير بيبص على الكود بتاعك وعلامات الـ Annotations، ويكتب هو بدالك مئات أسطر الكود الروتينية والمملة (Boilerplate) ويحفظها في ملفات منفصلة `.g.dart` قبل ما تترجم البرنامج.
- **المعنى التقني الدقيق:** Generating source code programmatically during the build phase before compilation, ensuring type safety without runtime reflection overhead.
- **مثال عملي:** تشغيل `dart run build_runner build` مع حزم مثل `freezed` أو `json_serializable`.
- **استخدامه في Dart:** الحل القياسي الحديث بدلاً من الـ Reflection.
- **علاقته بـ Flutter:** بناء نماذج الـ State والـ Routing والـ Network clients بدقة متناهية.
- **متى تحتاجه؟** في المشاريع الكبيرة لتسريع التطوير ومنع الأخطاء اليدوية.

---

### 29. Runtime
- **الترجمة العربية:** بيئة وقت التشغيل.
- **الشرح باللهجة المصرية:** المرحلة أو البيئة اللي بيكون فيها البرنامج خلاص اتجمع وعمال يشتغل فعلياً على جهاز المستخدم وبيتعامل مع المعالج والذاكرة ومدخلات الشاشة الحية.
- **المعنى التقني الدقيق:** The phase in a program's lifecycle during which it is actively executing on the hardware, supported by execution libraries and VM services.
- **مثال عملي:** حدوث خطأ `RangeError (index)` أثناء تشغيل التطبيق.
- **استخدامه في Dart:** الـ Dart Runtime الذي يدير الـ GC وحلقة الأحداث والـ Isolates.
- **علاقته بـ Flutter:** متابعة الأداء ومعدل الفريمات أثناء تشغيل الواجهة.
- **متى تحتاجه؟** لفهم الفارق بين أخطاء الـ Compile Time وأخطاء الـ Runtime.

---

### 30. Compilation
- **الترجمة العربية:** الترجمة البرمجية.
- **الشرح باللهجة المصرية:** تحويل كود لغة Dart الإنجليزي المقروء للبشر إلى لغة الآلة المباشرة (Machine Code أو Bytecode) اللي بيفهمها البروسيسور.
- **المعنى التقني الدقيق:** The translation process of human-readable source code into machine code or intermediate representations by a compiler.
- **مثال عملي:** خط أنابيب CFE (Common Front End) وترجمة الكود إلى Kernel Binary (`.dill`).
- **استخدامه في Dart:** تدعم لغة Dart استراتيجيات تجميع متعددة تجعلها فريدة (JIT وAOT وDart2JS).
- **علاقته بـ Flutter:** السر وراء سرعة التطوير عبر Hot Reload وسرعة الإنتاج النهائي عبر AOT.
- **متى تحتاجه؟** لتحسين حجم الـ Binary وسرعة الإقلاع (Startup Time).

---

### 31. JIT (Just-In-Time)
- **الترجمة العربية:** الترجمة في الوقت الفعلي.
- **الشرح باللهجة المصرية:** المترجم يقف جنب البرنامج وهو شغال، ويترجم الكود حتة بحتة وقت ما يطلب تشغيلها. ميزتها الجبارة إنها بتخليك تعدل الكود وتشوف النتيجة في ثانية من غير ما تعيد بناء المشروع كله.
- **المعنى التقني الدقيق:** Compilation that translates code dynamically into machine code during program execution, enabling rapid development cycles and profiling.
- **مثال عملي:** تشغيل الكود عبر `dart run` في وضع الـ Debug.
- **استخدامه في Dart:** هو الأساس التقني لميزة الـ **Stateful Hot Reload**.
- **علاقته بـ Flutter:** السحر الذي يسمح لك بتعديل الواجهة ورؤيتها فوراً دون فقدان الـ App State.
- **متى تحتاجه؟** طوال مرحلة التطوير وتصحيح الأخطاء (Development Phase).

---

### 32. AOT (Ahead-Of-Time)
- **الترجمة العربية:** الترجمة المسبقة.
- **الشرح باللهجة المصرية:** الكود كله يترجم ويتضغط ويتفصل بالكامل للغة الآلة الصريحة قبل ما التطبيق يطلع من جهازك أصلاً. مفيش مترجم شغال جوه موبايل العميل، النتيجة أداء صاروخي وإقلاع فوري.
- **المعنى التقني الدقيق:** Compiling higher-level source code directly into native machine architecture instructions prior to deployment.
- **مثال عملي:** `dart compile exe bin/main.dart` أو بناء Release في Flutter.
- **استخدامه في Dart:** إنتاج ملفات تنفيذية سريعة وخفيفة على الذاكرة ومحمية الكود.
- **علاقته بـ Flutter:** هو المسؤول عن أداء فلاتر العالي بنسبة 60 أو 120 إطار في الثانية في وضع الـ Release.
- **متى تحتاجه؟** عند تجهيز التطبيق للنشر في الإنتاج (Production).

---

### 33. Benchmarking
- **الترجمة العربية:** القياس المعياري للأداء.
- **الشرح باللهجة المصرية:** تجارب معملية هندسية دقيقة بتشغل فيها الكود ملايين المرات تحت ظروف محكومة وبالميكرو ثانية، علشان تعرف مين أسرع علمياً ومثبتاً بالأرقام مش بالفهلوة.
- **المعنى التقني الدقيق:** Measuring the execution performance, throughput, and latency of a code snippet or algorithm under controlled, repeatable conditions.
- **مثال عملي:** استخدام حزمة `benchmark_harness` ومقارنة `for loop` بـ `map()`.
- **استخدامه في Dart:** تقييم الخوارزميات وتحسين الحزم قبل نشرها.
- **علاقته بـ Flutter:** اختبار سرعة دوال المعالجة قبل استدعائها في الواجهات الحية.
- **متى تحتاجه؟** عند الاختيار بين معماريتين مختلفتين بناءً على الأرقام الصريحة.

---

### 34. Profiling
- **الترجمة العربية:** التحليل التشخيصي للأنظمة.
- **الشرح باللهجة المصرية:** زي جهاز رسم القلب وأشعة الرنين المغناطيسي للبرنامج؛ بيسجل في كل لحظة استهلاك المعالج، والرامات، وتوزيع الكائنات، ومين الدالة اللي سحبت وقت أطول من حقها وعطلت الشاشة.
- **المعنى التقني الدقيق:** Dynamic analysis of a software application to measure resource consumption (memory, CPU, network, thread allocations) during execution.
- **مثال عملي:** فتح **Dart DevTools** واستخدام الـ CPU Profiler والـ Memory Inspector.
- **استخدامه في Dart:** تتبع استهلاك الموارد واكتشاف الـ Bottlenecks.
- **علاقته بـ Flutter:** حل مشكلة تساقط الإطارات (UI Jank) والبحث عن تسريبات الذاكرة.
- **متى تحتاجه؟** عند فحص جودة التطبيق وتجهيزه للملايين من المستخدمين.

---

### 35. Big O Notation
- **الترجمة العربية:** مقياس O الكبير لتعقيد الخوارزميات.
- **الشرح باللهجة المصرية:** الميزان الرياضي اللي بنقيس بيه شطارة الكود؛ بيقولك لما حجم الداتا يكبر من 10 لعشرة ملايين، وقت التشغيل واستهلاك الذاكرة هيزيد بمقدار أد إيه؟
- **المعنى التقني الدقيق:** A mathematical notation describing the limiting behavior of an algorithm's resource consumption as input size approaches infinity.
- **مثال عملي:** البحث في `Set` يستغرق $O(1)$ بينما البحث الخطي في `List` يستغرق $O(N)$.
- **استخدامه في Dart:** اختيار الـ Collection المناسبة لكل سيناريو عملي.
- **علاقته بـ Flutter:** الحفاظ على سرعة الشاشات مهما تضخمت قوائم المستخدم.
- **متى تحتاجه؟** في مقابلات العمل الهندسية وعند تصميم أنظمة البيانات الكبيرة.

---

### 36. Time Complexity
- **الترجمة العربية:** التعقيد الزمني.
- **الشرح باللهجة المصرية:** عدد العمليات الحسابية والخطوات اللي البروسيسور مضطر ينفذها لإنهاء الخوارزمية كدالة في حجم المدخلات $N$.
- **المعنى التقني الدقيق:** The quantified measure of computational time required by an algorithm relative to the size of the input.
- **مثال عملي:** $O(N^2)$ في الحلقات المتداخلة (Nested loops) مقابل $O(N \log N)$ في الفرز السريع (QuickSort).
- **استخدامه في Dart:** ترشيد العمليات الحسابية ومنع كتابة حلقات مفرطة في البطء.
- **علاقته بـ Flutter:** منع تجميد الـ UI Thread وتفادي تأخر بناء الشجرة.
- **متى تحتاجه؟** في حل المسائل الخوارزمية وتصميم معالجات البيانات.

---

### 37. Space Complexity
- **الترجمة العربية:** التعقيد المكاني.
- **الشرح باللهجة المصرية:** كمية الذاكرة العشوائية الإضافية اللي البرنامج محتاجها علشان يخزن المتغيرات المؤقتة والقوائم أثناء حل المشكلة.
- **المعنى التقني الدقيق:** The amount of working memory space an algorithm requires during execution relative to its input size.
- **مثال عملي:** خوارزمية تنشئ مصفوفة جديدة بحجم المدخلات تستهلك $O(N)$ Space مقارنة بـ In-place algorithm تستهلك $O(1)$.
- **استخدامه في Dart:** تفادي إنشاء نسخ مكررة غير ضرورية من القوائم الكبيرة.
- **علاقته بـ Flutter:** الحفاظ على التطبيق من الإغلاق القسري على الهواتف ذات الرامات المحدودة.
- **متى تحتاجه؟** في معالجة الملفات والبيانات المتدفقة (Streaming).

---

### 38. Race Condition
- **الترجمة العربية:** سباق العمليات / التضارب التزامني.
- **الشرح باللهجة المصرية:** لما عمليتين شغالين مع بعض ويحاولوا يعدلوا في نفس البيانات في نفس اللحظة، والنتيجة النهائية تعتمد على مين فيهم هيسبق التاني بالصدفة البحتة، فتطلع نتائج عشوائية ومصايب في الحسابات.
- **المعنى التقني الدقيق:** A flaw in a concurrent system where the output is dependent on the uncontrollable sequence or timing of concurrent execution threads.
- **مثال عملي:** عمليتي سحب رصيد في نفس اللحظة تقرآن نفس القيمة قبل أن تحدث إحداهما الخصم.
- **استخدامه في Dart:** نادرة الحدوث في كود Dart العادي بسبب الـ Single Isolate، لكنها شائعة جداً في العمليات غير المتزامنة (Async Race Conditions) والاتصالات الخارجية.
- **علاقته بـ Flutter:** ظهور بيانات قديمة وتجاوزها لبيانات حديثة في شاشة البحث السريع بسبب تأخر الردود.
- **متى تحتاجه؟** لتصميم أنظمة حجز ومدفوعات آمنة تماماً.

---

### 39. Deadlock
- **الترجمة العربية:** الانسداد التام / القفل المميت.
- **الشرح باللهجة المصرية:** حالة شلل تام؛ عملية (أ) ماسكة مورد ومستنية عملية (ب) تخلص، وعملية (ب) ماسكة مورد ومستنية (أ) تخلص، والاتنين يفضلوا باصين لبعض في سكوت للأبد ومفيش سطر يتحرك.
- **المعنى التقني الدقيق:** A situation in concurrent computing where two or more processes are permanently blocked because each is waiting for a resource held by the other.
- **مثال عملي:** دالتان تنتظر كل منهما Future الأخرى بصورة دائرية مغلقة.
- **استخدامه في Dart:** تجنب الحلقات التزامنية المتبادلة في الـ Streams والـ Ports.
- **علاقته بـ Flutter:** تجمد التطبيق تماماً دون حتى ظهور رسالة خطأ.
- **متى تحتاجه؟** عند بناء بروتوكولات الاتصال والـ Microservices.

---

### 40. SOLID Principles
- **الترجمة العربية:** مبادئ SOLID الخمسة للتصميم الكائني.
- **الشرح باللهجة المصرية:** الدستور الذهبي لهندسة البرمجيات النظيفة؛ 5 قواعد لو مشيت عليهم تضمن إن كودك يفضل متماسك، سهل الصيانة، سهل التعديل، ومش بيفرقع لما يطلب منك العميل تعديل صغير.
- **المعنى التقني الدقيق:** Five fundamental software design principles: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion.
- **أركان المبدأ:**
  - **S:** المسؤولية الواحدة (Single Responsibility).
  - **O:** مفتوح للتوسيع، مغلق للتعديل (Open/Closed).
  - **L:** استبدال ليسكوف (Liskov Substitution).
  - **I:** فصل الواجهات (Interface Segregation).
  - **D:** عكس الاعتمادية (Dependency Inversion).
- **استخدامه في Dart:** تصميم الفئات والخدمات والـ Repositories.
- **علاقته بـ Flutter:** هيكلة مجلدات المشروع وطبقات الـ State Management.
- **متى تحتاجه؟** في أي مشروع احترافي يعمل عليه فريق برمجيات.

---

### 41. Clean Architecture
- **الترجمة العربية:** المعمارية النظيفة (معمارية البصلة / Uncle Bob).
- **الشرح باللهجة المصرية:** تقسيم كود المشروع لطبقات منفصلة تماماً في شكل دوائر؛ قلب المشروع (Domain) بيضم قواعد العمل النظيفة وميعرفش أي حاجة عن فلاتر أو النت أو السيرفر، وطبقة البيانات (Data) بتخدم عليه بره، وطبقة الواجهة (Presentation) بتعرض بس.
- **المعنى التقني الدقيق:** An architectural pattern that enforces strict separation of concerns into concentric layers, prioritizing core business rules independent of frameworks and UI.
- **مثال عملي:** تقسيم الكود إلى `domain/`، `data/`، `presentation/`.
- **استخدامه في Dart:** بناء المشاريع الكبيرة المستقلة عن الـ Framework.
- **علاقته بـ Flutter:** الهيكل الأكثر طلباً واعتماداً في وظائف مهندسي Flutter الكبار.
- **متى تحتاجه؟** في تطبيقات البنوك والتطبيقات الضخمة (Enterprise Apps).

---

### 42. Repository Pattern
- **الترجمة العربية:** نمط المستودع.
- **الشرح باللهجة المصرية:** أمين المخزن المسؤول عن جلب البيانات؛ الكود اللي فوق ملوش دعوة الداتا جاية من الكاش ولا من السيرفر ولا من ملف محلي، هو بيطلب من المستودع: "هاتلي بيانات المستخدم"، والمستودع يتصرف ويجيبها.
- **المعنى التقني الدقيق:** A design pattern that abstracts data access logic, serving as an in-memory collection-like interface between domain logic and persistence stores.
- **مثال عملي:** `abstract class ProductRepository { Future<List<Product>> getProducts(); }`
- **استخدامه في Dart:** الفصل بين الـ Data Sources والـ Business Use Cases.
- **علاقته بـ Flutter:** حقن المستودعات في الـ Blocs والـ Controllers.
- **متى تحتاجه؟** لتمكين الـ Offline Caching والتبديل السلس بين مصادر البيانات.

---

### 43. Factory Pattern
- **الترجمة العربية:** نمط المصنع.
- **الشرح باللهجة المصرية:** إنك تفوض عملية خلق الكائنات لـ "مصنع" أو دالة متخصصة تقرر هي على حسب الظروف والمدخلات أي كائن وأي نوع فرعي بالضبط هيتم إنشاؤه، بدل ما العميل يروح يعمل `new` صريح لكلاس معين.
- **المعنى التقني الدقيق:** A creational design pattern that provides an interface for creating objects in a superclass while allowing subclasses to alter the type of objects created.
- **مثال عملي:** استخدام `factory` constructors في Dart: `factory Database.create(String type) => ...`
- **استخدامه في Dart:** مدمج ككلمة مفتاحية رسمية في اللغة `factory Constructor`.
- **علاقته بـ Flutter:** في تصميم عناصر الواجهة الديناميكية حسب المنصة (Platform-specific widgets).
- **متى تحتاجه؟** عند بناء كائنات معقدة أو تطبيق الـ Singleton Pattern.

---

### 44. Strategy Pattern
- **الترجمة العربية:** نمط الاستراتيجية.
- **الشرح باللهجة المصرية:** إنك تحط الخوارزميات وطرق التنفيذ المتعددة (زي طرق دفع مختلفة: فودافون كاش، فيزا، فوري) كل واحدة في كلاس مستقل بنفس الـ Interface، والبرنامج يغير الاستراتيجية أثناء الشغل بمرونة شديدة وبدون `if-else` عملاقة.
- **المعنى التقني الدقيق:** A behavioral design pattern that enables selecting an algorithm or execution strategy at runtime from a family of interchangeable algorithms.
- **مثال عملي:** كلاس `OrderCheckout` يأخذ كائن `PaymentStrategy` وينفذ الدفع حسب اختيار المستخدم.
- **استخدامه في Dart:** تطبيق مبدأ Open/Closed وإلغاء جمل الـ Switch الطويلة المسببة للأخطاء.
- **علاقته بـ Flutter:** بناء أنماط الرسوم وتغيير الثيمات وطرق التحقق من المدخلات.
- **متى تحتاجه؟** عند وجود عدة طرق لتنفيذ نفس المهمة وتوقع إضافة طرق جديدة مستقبلاً.

---

### 45. Observer Pattern
- **الترجمة العربية:** نمط المراقب.
- **الشرح باللهجة المصرية:** نظام اشتراك الجرائد؛ كائن رئيسي بينشر الأخبار (Subject/Observable)، وكائنات تانية مشتركة معاه ومراقباه (Observers). أول ما يحصل عنده أي تحديث، بيبعت إشعار فوري لكل المشتركين معاه في نفس اللحظة.
- **المعنى التقني الدقيق:** A behavioral design pattern where an object maintains a list of dependents and notifies them automatically of any state changes.
- **مثال عملي:** الـ `Stream` والـ `StreamSubscription`، أو `ValueNotifier` و`ChangeNotifier`.
- **استخدامه في Dart:** هو الأساس التقني للبرمجة التفاعلية (Reactive Programming).
- **علاقته بـ Flutter:** هو القلب النابض لـ `setState`، `ChangeNotifier`، `BLoC`، `Riverpod`، و`RxDart`.
- **متى تحتاجه؟** في أي معمارية تحتاج مزامنة فورية بين الأحداث والواجهة.

---

### 46. Adapter Pattern
- **الترجمة العربية:** نمط المهايئ / المشترك الكهربائي.
- **الشرح باللهجة المصرية:** لما يكون عندك فيشة بتلات سنون، وفي الحيطة بريزة بفتحتين بس وميركبوش على بعض؛ بتجيب "مشترك مهايئ" وسيط يركب بينهم ويخليهم يتفاهموا من غير ما تكسر الحيطة ولا تقطع سلك الجهاز.
- **المعنى التقني الدقيق:** A structural design pattern that allows incompatible interfaces to collaborate by converting the interface of one class into another expected by clients.
- **مثال عملي:** تحويل كائن طرف ثالث (Third-party SDK response) إلى Domain Entity خاص بنظامك.
- **استخدامه في Dart:** تغليف المكتبات الخارجية (3rd party packages) داخل طبقة الـ Data.
- **علاقته بـ Flutter:** ربط حزم Native بتطبيقات فلاتر دون تشويه كود الواجهة.
- **متى تحتاجه؟** عند دمج نظام قديم مع نظام حديث أو تغيير مزود خدمة خارجي.
