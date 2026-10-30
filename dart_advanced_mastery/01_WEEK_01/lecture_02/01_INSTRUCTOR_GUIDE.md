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

## 3. التوزيع الزمني الدقيق (120-Minute Breakdown)

| الوقت | المدة | النشاط التعليمي | المحتوى والهدف |
| :--- | :--- | :--- | :--- |
| **00:00 - 00:10** | 10 دقائق | **تمهيد وسؤال افتتاحي (The Hook)** | مراجعة سريعة لـ L01 + لغز الذاكرة: أين تعيش المتغيرات عندما تحتفظ بها دالة داخل دالة أخرى؟ |
| **00:10 - 00:35** | 25 دقيقة | **المستوى الأول (Level 1 — Simple)** | الدوال الأساسية، تشريح المعاملات (Positional vs Named)، وقيم الـ Default مع Null Safety. |
| **00:35 - 01:00** | 25 دقيقة | **المستوى الثاني (Level 2 — Intermediate)** | الدوال ككائنات (First-Class)، الـ Callbacks، وTear-offs vs Anonymous Lambdas. |
| **01:00 - 01:30** | 30 دقيقة | **المستوى الثالث والرابع (Advanced & Engineering)** | تشريح الـ Closures والـ Stack Frames، ومحاكاة خط أنابيب تحويل البيانات (Data Pipeline Architecture). |
| **01:30 - 01:50** | 20 دقيقة | **تحدي تفاعلي ونقاش جماعي** | كشف خطأ شائع في الـ Closures وحلقات التكرار (The Loop Variable Capture Trap). |
| **01:50 - 02:00** | 10 دقائق | **ملخص وتقييم سريع** | استعراض الـ Quiz وتكليف واجب المحاضرة الثانية. |

---

## 4. السيناريو الكامل للشرح باللهجة المصرية التقنية (Spoken Instructor Script)

### [الدقيقة 00:00 - 00:10] التمهيد وفتح الموضوع
> **المحاضر يبدأ بحماس:**  
> "مساء الخير يا شباب! المحاضرة اللي فاتت فهمنا الـ Type System وعرفنا إن مفيش هزار مع الـ Compiler.  
> النهارده بقى هندخل في قلب المحرك المنطقي للغة: **الدوال (Functions)**.  
> في أغلب لغات البرمجة القديمة، الدالة كانت مجرد كتلة كود بتناديها وخلاص.  
> لكن في Dart، الدالة تعتبر **First-Class Citizen**!  
> يعني إيه الكلمة الفخمة دي؟  
> يعني الدالة مواطن من الدرجة الأولى؛ ليها نفس حقوق المتغيرات بالظبط!  
> تقدر تحط الدالة في متغير، تقدر تمرر دالة كـ Parameter لدالة تانية، وتقدر تخلي دالة تصنع دالة تانية وترجعها في الـ Return!  
> 
> وعندي لغز هندسي عايزكم تفكروا فيه:  
> إحنا عارفين إن المتغيرات المحلية (Local Variables) بتعيش في الـ Stack، وأول ما الدالة تخلص، الـ Stack Frame بيطير والمتغيرات بتتمسح!  
> طب لو الدالة دي جواها دالة صغيرة، والدالة الصغيرة دي رجعت بره وعمالة تستخدم المتغير المحلي ده بعد ما الدالة الأب ماتت وخصلت شغلها...  
> المتغير ده هيفضل عايش فين وإزاي؟ ده اللي اسمه **Closure**، وده اللي هنكشف سره النهارده."

---

### [الدقيقة 00:10 - 00:35] المستوى الأول: تشريح الـ Parameters
> **المحاضر يفتح ملف الكود:**  
> "تعالوا نبص على طريقة تعريف المعاملات في Dart لأنها من أذكى وأروع اللغات في تصميم المعاملات:  
> عندنا نوعين رئيسيين:  
> 1. **Positional Parameters:** الترتيب فيها إجباري. لو الدالة بتاخد `(String name, int age)`، لازم تبعت الاسم الأول بعدين العمر.  
> 2. **Named Parameters:** بنحطها بين أقواس مجعدة `{required String name, int age = 18}`.  
> هنا الترتيب مبقاش فارق خالص! وكمان كود الاستدعاء بيبقى مقروء جداً (Self-Documenting):  
> `createUser(name: 'Ali', age: 25)`.  
> 
> طب إيه علاقة ده بالـ Null Safety؟  
> لو المعامل Named، إنت مجبر على واحدة من تلاتة:  
> - إما تعمله `required`.  
> - أو تعمله Nullable بعلامة استفهام `int?`.  
> - أو تديله قيمة افتراضية Default value: `int age = 18`.  
> لو معملتش واحدة من دول، الـ Compiler هيزعقلك فوراً!"

---

### [الدقيقة 00:35 - 01:00] المستوى الثاني: First-Class Functions والـ Tear-offs
> **المحاضر يكتب كوداً توضيحياً:**  
> "بصوا على السطر ده:  
> ```dart
> final names = ['sara', 'omar', 'mona'];
> names.forEach((name) => print(name));
> ```
> ده كود شغال ومية مية، بس هل هو كود مهندس محترف؟  
> الإجابة: لأ! ليه؟  
> لأنك عملت دالة مجهولة (Anonymous Lambda Function) اسمها `(name)` ملهاش أي لازمة في الحياة غير إنها تاخد الـ Parameter وتمرره لدالة `print`!  
> يعني حجزت كائن Closure جديد في الذاكرة بدون أي داعي!  
> في Dart نقدر نكتبها كده:  
> ```dart
> names.forEach(print);
> ```
> دي ميزة اسمها **Tear-off**!  
> يعني قطعت اسم الدالة واستخدمته كمرجع دالي مباشر بدون ما تلفه جوه lambda.  
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
