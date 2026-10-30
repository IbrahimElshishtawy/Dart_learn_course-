# Terminology Glossary — Lecture 02: Functions, Scope & Execution Model

قاموس المصطلحات التخصصي للمحاضرة الثانية مع الشرح التبسيطي باللهجة المصرية والربط المعماري مع Flutter والـ Architecture.

---

### 1. First-Class Functions
- **الترجمة العربية:** الدوال كمواطنين من الدرجة الأولى.
- **الشرح باللهجة المصرية:** إن الدالة في لغة البرمجة مش واخدة جنب لوحدها؛ دي بتتعامل معاملة الباشا زي أي متغير أو كائن؛ تقدر تشيلها في متغير، تبعتها في باراميتر، وترجعها في return.
- **المعنى التقني الدقيق:** A programming language design where functions are treated as first-class values that can be bound to identifiers, passed as arguments, and returned from other functions.
- **مثال عملي:** `final myFunc = (int x) => x * 2;`
- **استخدامه في Dart:** تمكين أسلوب البرمجة الوظيفية (Functional Programming) ونمط الـ Callbacks.
- **علاقته بـ Flutter:** تمرير دوال الـ `onPressed: () => ...` في كل أزرار وتفاعلات الـ Widgets.
- **متى تحتاجه؟** في تصميم الـ Event Handlers ومكتبات الـ Middleware.

---

### 2. Higher-Order Function (HOF)
- **الترجمة العربية:** الدوال ذات الرتبة العليا.
- **الشرح باللهجة المصرية:** دالة رئيسية بتاخد دالة تانية كمدخل ليها، أو بتصنع وترجع دالة جديدة كـ output. زي المدير اللي بيشغل موظفين تحت إيده.
- **المعنى التقني الدقيق:** A function that receives one or more functions as arguments, or returns a function as its result.
- **مثال عملي:** دوال `map()`, `where()`, و`reduce()`.
- **استخدامه في Dart:** فلترة وتحويل الـ Collections بدون كتابة حلقات for يدوية.
- **علاقته بـ Flutter:** بناء الـ Builders مثل `ListView.builder(itemBuilder: (ctx, i) => ...)`
- **متى تحتاجه؟** عند بناء Pipelines لمعالجة البيانات وتطبيق نمط الـ Strategy.

---

### 3. Lexical Scope
- **الترجمة العربية:** النطاق المعجمي.
- **الشرح باللهجة المصرية:** المساحة الجغرافية في الكود المكتوب اللي المتغير يقدر يتشاف فيها؛ القوسين المعقوفين `{ ... }` بيحددوا مين يشوف مين، والداخل يقدر يشوف الخارج لكن العكس مستحيل.
- **المعنى التقني الدقيق:** Scope resolution determined by the textual, physical position of code declarations within nested blocks at compile-time.
- **مثال عملي:** المتغير المعرف داخل دالة لا يمكن الوصول إليه من خارج أقواس الدالة.
- **استخدامه في Dart:** حماية المتغيرات من التلوث والوصول العشوائي.
- **علاقته بـ Flutter:** نطاق الـ `BuildContext` الذي يحدد موقع الويدجت في الشجرة.
- **متى تحتاجه؟** لتنظيم عمر المتغيرات وتجنب تضارب الأسماء.

---

### 4. Lexical Closure
- **الترجمة العربية:** الكبسولة / الدالة المغلقة.
- **الشرح باللهجة المصرية:** دالة ذكية أول ما بتتولد بتاخد في حضنها المتغيرات اللي حواليها في النطاق بتاعها، وتفضل محتفظة بيهم في الذاكرة حتى لو الدالة الأم اللي صنعتها خلصت وماتت.
- **المعنى التقني الدقيق:** A first-class function paired with its lexical referencing environment, maintaining access to enclosing variables across stack lifetime.
- **مثال عملي:** `Function makeCounter() { int c = 0; return () => ++c; }`
- **استخدامه في Dart:** الحفاظ على الـ Private State بدون الحاجة لإنشاء كلاس صريح.
- **علاقته بـ Flutter:** الـ Callbacks التي تحتفظ بقيم الـ `index` داخل الحلقات والقوائم.
- **متى تحتاجه؟** لتنفيذ الـ Memoization ومصانع الدوال (Function Factories).

---

### 5. Tear-off (Method & Constructor)
- **الترجمة العربية:** القطع الدالي المباشر.
- **الشرح باللهجة المصرية:** بدل ما تعمل دالة مجهولة ملهاش لازمة تلف بيها حوالين دالة تانية `(x) => print(x)`، إنت بتكتب اسم الدالة مباشرة `print` والمترجم يوصلهم ببعض في ثانية بدون أي تعقيد.
- **المعنى التقني الدقيق:** Obtaining a closure directly from a named function, method, or constructor without evaluating it or wrapping it in a lambda.
- **مثال عملي:** `names.forEach(print)` أو `items.map(User.new)`.
- **استخدامه في Dart:** تنظيف الكود وتقليل استهلاك الذاكرة وتفعيل الـ Compiler Inlining.
- **علاقته بـ Flutter:** تمرير الدوال مباشرة للـ callbacks مثل `onPressed: _handleLogin`.
- **متى تحتاجه؟** في كل مكان تستدعي فيه دالة داخل `map` أو `forEach`.

---

### 6. Pure Function
- **الترجمة العربية:** الدالة النقية.
- **الشرح باللهجة المصرية:** دالة مستقيمة ومحترمة؛ كل اللي بتعمله إنها تاخد مدخلات وترجع ناتج، مبتمدش إيدها بره تعدل متغير عام، ومبتعملش دوشة في السيرفر أو الشاشة.
- **المعنى التقني الدقيق:** A function where the return value is solely determined by its input values, without observable side effects.
- **مثال عملي:** `int square(int x) => x * x;`
- **استخدامه في Dart:** كتابة كود وظيفي قابل للاختبار بنسبة 100%.
- **علاقته بـ Flutter:** الـ Reducers والـ Mappers في BLoC وRedux.
- **متى تحتاجه؟** في الـ Unit Testing وفي منطق الحسابات الرياضية.

---

### 7. Side Effect
- **الترجمة العربية:** الأثر الجانبي.
- **الشرح باللهجة المصرية:** إن الدالة تعمل حاجة في الخفاء غير حساب الناتج، زي إنها تعدل متغير جلوبال، أو تكتب في الداتابيز، أو تمسح ملف في الهارد ديسك.
- **المعنى التقني الدقيق:** Any state modification or interaction with the outside world outside the local execution scope of a function.
- **مثال عملي:** دالة تجمع رقمين وبنفس الوقت ترسل SMS للعميل!
- **استخدامه في Dart:** عزل الآثار الجانبية في طبقة الـ Services أو Repositories.
- **علاقته بـ Flutter:** تجنب وضع أي Side Effects في دالة `build()` للويدجت لأنها تتكرر آلاف المرات.
- **متى تحتاجه؟** لتفادي الـ Bugs المعقدة والـ Non-deterministic behaviors.

---

### 8. Currying & Partial Application
- **الترجمة العربية:** التجزيء الدالي / الكرينة.
- **الشرح باللهجة المصرية:** إنك تاخد دالة بتحتاج 3 باراميترز، وتحولها لسلسلة دوال بتاخد باراميتر واحد في كل مرة، وتقدر تثبت أول باراميتر وتستنى التانيين ييجوا براحتهم.
- **المعنى التقني الدقيق:** Decomposing a multi-argument function into a sequence of nested unary functions that accept arguments one at a time.
- **مثال عملي:** `multiply(a) => (b) => a * b;`
- **استخدامه في Dart:** بناء أدوات الـ Configurable Formatting وتجهيز الدوال مسبقاً.
- **علاقته بـ Flutter:** تجهيز الـ Validators مع معايير ديناميكية في حقول الإدخال.
- **متى تحتاجه؟** عند بناء مكتبات هندسية ومعالجة البيانات المتدفقة.
