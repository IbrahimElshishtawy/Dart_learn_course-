# Lecture 02: Functions, Scope & Execution Model — دليل المحاضر

## 1. بطاقة تعريف المحاضرة (Lecture Metadata)
- **عنوان المحاضرة:** Functions as First-Class Citizens, Lexical Scope, Closures & Execution Stack
- **المدة الزمنية:** 120 دقيقة (ساعتان)
- **المستوى:** من التأسيس المعماري إلى المستوى المتقدم
- **الإصدار المعتمد:** Dart SDK 3.8.1+
- **المتطلبات السابقة:** استيعاب المحاضرة الأولى (Type System, Sound Null Safety, Memory Allocations).

---

## 2. أهداف المحاضرة (Lecture Learning Objectives)
بنهاية هذه المحاضرة، يجب أن يكون الطالب قادراً على:
1. استيعاب مفهوم **Functions as First-Class Citizens** وتمرير وإرجاع الدوال كقيم برمجية.
2. التفريق الدقيق بين أنواع الـ Parameters في Dart: Positional, Named, Optional, Required, Default values.
3. فهم تشريح **Lexical Scope** ودورة حياة المتغيرات على الـ Call Stack مقابل الـ Heap.
4. إتقان الـ **Closures** وكيف تحتفظ الدالة بمتغيرات البيئة المحيطة بها في الذاكرة حتى بعد انتهاء الدالة الأب.
5. استغلال ميزة الـ **Tear-offs** لكتابة كود نظيف وتفادي استهلاك الذاكرة عبر الـ Lambdas المكررة.
6. تطبيق مبادئ البرمجة الوظيفية (Functional Composition, Pure Functions, Avoiding Side Effects).
7. بناء محرك معالجة وتحويل بيانات مرن (Flexible Data Transformation Pipeline).

---

## 3. التوزيع الزمني الدقيق وفق سلم التدرج (Beginner 120-Minute Timeline)

| الوقت | المدة | النشاط التعليمي | المحتوى والهدف للمبتدئ |
| :--- | :--- | :--- | :--- |
| **00:00 - 00:15** | 15 دقيقة | **تمهيد: التكرار الذكي (Why Repetition & Loops)** | لماذا نكرر؟ حلقات `for` و `while`. عداد التكرار ومخاطر الحلقة اللانهائية (Infinite Loop). |
| **00:15 - 00:40** | 25 دقيقة | **المستوى الأول: الدوال كوصفات طهي (Functions as Recipes)** | ما هي الدالة؟ المدخلات والمخرجات، تفكيك المشكلة لدوال صغيرة، والفرق بين Positional و Named Parameters. |
| **00:40 - 01:05** | 25 دقيقة | **المستوى الثاني: نطاق الرؤية والدوال كقيم (Scope & First-Class Functions)** | أين تعيش المتغيرات؟ (Lexical Scope). تمرير الدوال كمعاملات (Callbacks) واختصار الـ Tear-offs. |
| **01:05 - 01:35** | 30 دقيقة | **المستوى الثالث والرابع: حقيبة الذاكرة وخط أنابيب التحويل** | الـ Closures وحفظ المتغيرات في الـ Heap، وبناء خط معالجة البيانات (Data Transformation Pipeline). |
| **01:35 - 01:50** | 15 دقيقة | **تحدي تفاعلي واستقلالي للطلاب** | الطلاب يكتبون دوال تصفية وحساب ضريبة ويجرون تتبعاً يدوياً للمتغيرات. |
| **01:50 - 02:00** | 10 دقائق | **ملخص وتثبيت بالاستدعاء النشط** | مراجعة مهارة الـ Decomposition، والتمهيد للمحاضرة القادمة (Collections: List, Set, Map). |

---

## 4. السيناريو الكامل للشرح باللهجة المصرية للمبتدئين (Spoken Instructor Script)

### [الدقيقة 00:00 - 00:15] التمهيد وفتح الموضوع: لماذا نحتاج التكرار؟ (The Power of Loops)
> **المحاضر يبتسم ويكتب على السبورة:**  
> "مساء الخير يا شباب! المحاضرة اللي فاتت عرفنا الصناديق والأنواع وإزاي ناخد قرارات بـ `if/else`.  
> النهارده بقى عندنا تحدي جديد:  
> لو طلب منك تطبع أرقام من 1 لـ 100، هل هتقعد تكتب 100 سطر `print`؟  
> طبعاً لأ، دي شغلة الكمبيوتر اللي مبيتعبش ولا بيمل!  
> في البرمجة عندنا تعويذة سحرية اسمها **حلقات التكرار (Loops)**:  
> ```dart
> for (int i = 1; i <= 5; i++) {
>   print('رقم التكرار: $i');
> }
> ```  
> بنقول للكمبيوتر: 'ابداً العداد `i` من 1، وافضل كرر طالما `i <= 5`، وكل لفة زوّد العداد بواحد `i++`'.  
> سطرين كود بس بينفذوا ملايين العمليات في لمح البصر!"

---

### [الدقيقة 00:15 - 00:40] المستوى الأول: الدوال كوصفات طهي وتفكيك المشكلات
> **المحاضر يرسم على السبورة خلاط عصير:**  
> "تخيل إنك بتعمل كيكة أو عصير برتقال. هل كل ما تيجي تعمل كيكة بتخترع طريقة الخَبز من الصفر؟  
> لأ، عندك **وصفة جاهزة (Recipe)** مكتوبة في ورقة:  
> بتدخلها المكونات (سكر، دقيق، بيض)، هي بتخلطهم وتخبز، وبتطلع لك في الآخر الكيكة الجاهزة!  
> ده بالضبط تعريف **الدالة (Function)** في البرمجة:  
> كتلة كود بنكتبها مرة واحدة بس، ونقدر ننادي عليها 1000 مرة من أي مكان في البرنامج!  
> ```dart
> int calculateTotal(int price, int tax) {
>   return price + tax;
> }
> ```  
> - `int price, int tax`: دي المكونات اللي الدالة محتاجاها (المدخلات أو الـ Parameters).  
> - `return price + tax;`: دي النتيجة النهائية اللي بترجع لنا في إيدينا (المخرجات أو الـ Return Value).  
> 
> وعشان نسهل القراءة، Dart بتسمح لنا بنوع عبقري اسمه **Named Parameters**:  
> بنحط المعاملات بين أقواس `{ }`: `({required int price, int discount = 0})`.  
> ساعتها نقدر ننادي الدالة بالأسماء واضحة وصريحة: `calculateTotal(price: 100, discount: 10)` بدون ما نقلق من الترتيب!"

---

### [الدقيقة 00:40 - 01:05] المستوى الثاني: أين تعيش المتغيرات؟ والدوال كمواطن درجة أولى
> **المحاضر يرسم غرفتين مغلقتين على السبورة:**  
> "شايفين القوسين المجعدين دول `{ }`؟  
> أي متغير يتولد جوه القوسين، بيعيش ويموت جواهم! مفيش حد برة القوسين يقدر يشوفه أو يلمسه. ده اللي بنسميه **نطاق الرؤية (Scope)**.  
> 
> طب إيه حكاية إن الدوال في Dart عبارة عن **First-Class Citizens**؟  
> يعني مواطن درجة أولى له نفس حقوق الأرقام والنصوص:  
> تقدر تخزن دالة جوه متغير، وتقدر تمرر دالة كـ Parameter لدالة تانية عشان تنفذها بعدين (وده اللي بنسميه Callback)!  
> ولما تكون الدالة مجرد تمرير مباشر لمعامل، Dart بتدينا ميزة شياكة وأداء اسمها **Tear-off**:  
> بدل ما تكتب `(x) => print(x)`، بتكتب `print` على طول كمرجع دالي مباشر وتوفر حجز كائنات زائدة في الذاكرة!"  
> الـ Tear-off أنظف في القراءة، وأسرع في التنفيذ، ومبيحجزش كائنات إضافية في الـ Heap!"

---

### [الدقيقة 01:00 - 01:30] المستوى الثالث والرابع: أسرار الـ Closures والمعمارية
> **المحاضر يرسم على السبورة الـ Stack والـ Heap:**  
> "تعالوا نجاوب على لغز أول المحاضرة: الـ **Closure**:  
> يعني إيه Closure؟  
> الدالة لما بتتعرف، مش بس بتاخد الكود بتاعها، دي بتاخد لقطة (Scope Environment) للمتغيرات اللي حواليها في نفس النطاق المعجمي (Lexical Scope).  
> الـ Dart VM بتكتشف إن الدالة الداخلية بتشير لمتغير محلي للدالة الأب، فتقوم Dart بنقل المتغير ده من الـ Stack للـ **Heap**!  
> علشان يفضل عايش طالما الدالة الداخلية دي عايشة!  
> 
> المفهوم ده هو اللي بيخلينا نقدر نبني **Function Factories** و**Middleware Pipelines**، ونعمل Currying ومعالجة بيانات خطوة بخطوة زي ما هنشوف في مشروع النهاردة."

---

### [الدقيقة 01:30 - 01:50] التحدي التفاعلي: The Loop Variable Capture Trap
> **المحاضر يعرض كوداً كلاسيكياً:**  
> "مين فيكم يشوف الكود ده ويقولي هيطبع إيه؟  
> ```dart
> var callbacks = <Function>[];
> for (var i = 0; i < 3; i++) {
>   callbacks.add(() => print(i));
> }
> for (var cb in callbacks) {
>   cb();
> }
> ```
> في لغات تانية قديمة زي JavaScript زمان، كان بيطبع 3 ثلاث مرات!  
> لكن في Dart، المتغير `var i` بيتم عمل كبسلة لنطاق جديد (New Scope Binding) في كل لفة من لفات الـ for loop، فيطبع: 0 ثم 1 ثم 2!  
> ده إثبات على دقة ونظافة الـ Lexical Scoping في Dart."

---

### [الدقيقة 01:50 - 02:00] التلخيص والختام
> "يا شباب، النهارده نقلنا عقلنا من التفكير في الدوال كأوامر جامدة إلى التفكير فيها كـ Data Pipelines متدفقة.  
> كود المحاضرة موجود في `02_CODE_EXAMPLES`، والمشروع العملي خطير وممتع في `03_PRACTICAL_PROJECT`.  
> موعدنا المحاضرة القادمة مع **Collections, Records & Patterns**! شكراً لكم."

---

## 5. أمثلة التدرج الرباعي (The 4 Code Levels)

### LEVEL 1 — SIMPLE (البسيط):
```dart
// Positional vs Named with Default Value
void printGreeting(String name, {String title = 'Eng', bool isUrgent = false}) {
  final prefix = isUrgent ? 'URGENT: ' : '';
  print('$prefix$title. $name');
}

void main() {
  printGreeting('Ahmed'); // Eng. Ahmed
  printGreeting('Sara', title: 'Dr', isUrgent: true); // URGENT: Dr. Sara
}
```

### LEVEL 2 — INTERMEDIATE (المتوسط):
```dart
// Function types as parameters and return values
typedef NumberPredicate = bool Function(int number);

List<int> filterNumbers(List<int> input, NumberPredicate predicate) {
  final output = <int>[];
  for (final n in input) {
    if (predicate(n)) output.add(n);
  }
  return output;
}

void main() {
  final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // Passing anonymous lambda and named function
  final evens = filterNumbers(numbers, (n) => n % 2 == 0);
  print('Evens: $evens');
}
```

### LEVEL 3 — ADVANCED (المتقدم):
```dart
// Closure: Function Generator with enclosed state
typedef Counter = int Function();

Counter createMonotonicCounter(int startValue) {
  int internalState = startValue; // Lives on Heap due to closure capture!
  return () {
    return internalState++;
  };
}

void main() {
  final counterA = createMonotonicCounter(100);
  final counterB = createMonotonicCounter(500);

  print('Counter A: ${counterA()}'); // 100
  print('Counter A: ${counterA()}'); // 101
  print('Counter B: ${counterB()}'); // 500
}
```

### LEVEL 4 — ENGINEERING LEVEL (المستوى المعماري):
```dart
// Composable Pure Transformation Pipeline
typedef Transformer<T> = T Function(T input);

class Pipeline<T> {
  final List<Transformer<T>> _stages = [];

  Pipeline<T> addStage(Transformer<T> stage) {
    _stages.add(stage);
    return this; // Fluent interface builder pattern
  }

  T execute(T initialInput) {
    T current = initialInput;
    for (final stage in _stages) {
      current = stage(current);
    }
    return current;
  }
}

void main() {
  final stringPipeline = Pipeline<String>()
      .addStage((s) => s.trim())
      .addStage((s) => s.replaceAll('_', ' '))
      .addStage((s) => s.toUpperCase());

  final result = stringPipeline.execute('  raw_incoming_event_payload  ');
  print('Pipeline Output: "$result"'); // "RAW INCOMING EVENT PAYLOAD"
}
```

---

## 8. حزمة التطوير البيداغوجي والهندسي للمحاضرة (Advanced Cognitive & Teaching Pack)

### أ. ملاحظات تطوير المحاضر (Instructor Development Notes)
- **الهدف المعرفي الأهم:** إثبات أن الدوال كائنات حقيقية (First-Class Citizens)؛ افتح الـ Debugger واجعل الطلاب يرون دالة مخزنة كمتغير في الـ Variables View.
- **التشبيه الحياتي:** شبه الـ Closure بـ "حقيبة سفر" تأخذها الدالة الداخلية معها إلى الـ Heap تحتوي على المتغيرات التي تحتاجها حتى بعد موت الدالة الخارجية.
- **تنبيه الإلقاء:** احذر من نعت الـ Tear-off بأنه "اختصار فقط"؛ بل أكد أنه تحسين للأداء وتوفير للذاكرة.

### ب. تمارين التفكير الإدراكي للطالب (Student Thinking Exercises)
1. *تمرين تتبع الذاكرة (Memory Tracing):* إذا كانت دالة تنشئ 1,000 دالة Closure في حلقة تكرار وجميعها تشير لمتغير `int counter` واحد، كم عدد الـ Context Objects المنشأة في الـ Heap؟
2. *تمرين المفاضلة:* قارن بين `list.map((x) => doubleNumber(x))` و `list.map(doubleNumber)`. متى تضطر لاستخدام الصيغة الأولى؟ (مثلاً عند الرغبة في تمرير باراميتر إضافي ثابت).

### ج. سيناريو البرمجة الحية بالتفكير المسموع (Live Coding Think-Aloud Script)
- **المشكلة:** بناء خط أنابيب لمعالجة وتشفير البيانات `DataProcessingPipeline`.
- **التفكير بصوت مسموع:**  
  > *"عندي مدخلات نصية عايز أعمل لها Trim، وبعدين تشفير، وبعدين Base64 Encoding. بدل ما أكتب دالة ضخمة معقدة، هعرف `typedef Transformer<T> = T Function(T input);`، وهعمل كلاس يستقبل قائمة من الـ Transformers وينفذهم ورا بعض عبر `fold` أو حلقة بسيطة. الميزة هنا إيه؟ إني أقدر أضيف مرحلة جديدة بكرة الصبح بدون ما أعدل سطر واحد في الكلاس الأصلي (Open/Closed Principle)!"*
- **إظهار الخطأ وتصحيحه:** كتابة دالة بتوقيع غير متطابق ورؤية كيف يعترض الـ Type Checker في الحال.

### د. الأنشطة التفاعلية ونقاش القاعة (Discussion Activities)
- **مناظرة الـ Anonymous Functions vs Tear-offs:** تقسيم القاعة إلى فريقين، أحدهما يدافع عن سهولة قراءة الـ Lambdas والآخر يدافع عن كفاءة الـ Tear-offs، ثم تشغيل `06_performance_tearoffs_vs_lambdas.dart` لإثبات الفارق الزمني عملياً.

### هـ. فحص المفاهيم الخاطئة (Misconception Checks)
- **السؤال الفخ:** *"هل المتغير المحبوس داخل Closure يمكن تعديل قيمته من الخارج بعد انتهاء الدالة المنشئة؟"*  
  - *الفهم الخاطئ:* لا، لأنه يصبح Read-Only بمجرد موت الدالة الخارجية.  
  - *التصحيح الصارم:* نعم يمكن! الـ Closure تشارك نفس الـ Reference في الـ Heap؛ وإذا كانت هناك دالتان Closures تتشاركان نفس المتغير، فتعديل إحداهما يؤثر فورياً على الأخرى.

### و. التحدي الهندسي واتخاذ القرار (Engineering Decision Challenge)
- **المسألة:** هل نمرر دالة الـ Callback كـ `Function` عامة أم كـ `Typedef` صريح ومحدد؟  
- **الدفاع المطلوب:** الالتزام الصارم بـ `typedef` محدد (مثل `typedef EventCallback = void Function(Event event);`) لضمان الـ Static Type Safety ومنع الـ Runtime Type Errors عند تمرير باراميترات خاطئة.

### ز. جسر المعرفة إلى Flutter (The Flutter Connection)
- **أين سيقابل الطالب هذا في Flutter؟**
  - كل شاشات Flutter تعتمد على الدوال كمواطن درجة أولى: `onPressed: _submitForm` (Method Tear-off).
  - الـ `WidgetBuilder` في `ListView.builder(itemBuilder: (context, index) => ...)` هو تطبيق مباشر لـ Higher-Order Functions.
  - الـ Event Transformers في مكتبات إدارة الحالة مثل `bloc_concurrency` تعتمد بالكامل على ترويض الـ Streams عبر دوال وسيطة.
