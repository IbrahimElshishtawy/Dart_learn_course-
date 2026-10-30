# Lecture 03: Collections, Records & Patterns — دليل المحاضر

## 1. بطاقة تعريف المحاضرة (Lecture Metadata)
- **عنوان المحاضرة:** Collections Internals, Modern Records, Pattern Matching & Exhaustiveness Checking
- **المدة الزمنية:** 120 دقيقة (ساعتان)
- **المستوى:** من التأسيس المعماري إلى المستوى المتقدم (Dart 3.x Modern Superpowers)
- **الإصدار المعتمد:** Dart SDK 3.8.1+
- **المتطلبات السابقة:** استيعاب المحاضرتين 01 و02 (Type System, Functions, Closures).

---

## 2. أهداف المحاضرة (Lecture Learning Objectives)
بنهاية هذه المحاضرة، يجب أن يكون الطالب قادراً على:
1. فهم التشريح الداخلي لمجموعات Dart الأساسية (`List`, `Set`, `Map`) والتعقيد الزمني لكل منها ($O(1)$ vs $O(N)$).
2. استغلال الميزات التعبيرية الحديثة: Spread Operators (`...` و`...?`) وCollection `if` وCollection `for`.
3. إتقان **Records** في Dart 3 كبنى بيانات مجهولة، قوية الأنواع (Type-safe Anonymous Aggregates)، والفرق بينها وبين الفئات الكلاسيكية.
4. تطبيق **Pattern Matching** و**Destructuring** لتفكيك كائنات البيانات والقوائم والخرائط بسطر كود واحد.
5. استخدام **Switch Expressions** وGuard Clauses (`when`) في كتابة كود نظيف وتعبيري مع التحقق الشامل (Exhaustiveness Checking).
6. بناء محرك معالجة وتصنيف طلبات التجارة الإلكترونية (E-Commerce Pattern-Based Order Engine).

---

## 3. التوزيع الزمني الدقيق وفق سلم التدرج (Beginner 120-Minute Timeline)

| الوقت | المدة | النشاط التعليمي | المحتوى والهدف للمبتدئ |
| :--- | :--- | :--- | :--- |
| **00:00 - 00:15** | 15 دقيقة | **تمهيد: لماذا نحتاج تنظيم البيانات؟ (Why Collections?)** | فخ المتغيرات المنفردة: كيف نخزن 100 اسم طالب؟ مقدمة القائمة (`List`) كقائمة مشتريات. |
| **00:15 - 00:40** | 25 دقيقة | **المستوى الأول: ثلاثي المجموعات (List, Set, Map)** | القائمة المرتبة بالـ Index، سلة العناصر الفريدة (`Set`)، ودليل الهاتف (`Map: Key-Value`). المرور بـ `for-in`. |
| **00:40 - 01:05** | 25 دقيقة | **المستوى الثاني: التجميع البسيط بالـ Records (Dart 3)** | كيف نربط قيمتين معاً دون تعقيد؟ مقدمة الـ Records: `(name, age)`. تفكيك البيانات واستخراج القيم. |
| **01:05 - 01:35** | 30 دقيقة | **المستوى الثالث والرابع: مطابقة الأنماط ومحرك التجارة** | الـ Switch Expression الذكية، مطابقة أشكال البيانات (Pattern Matching)، وبناء محرك الطلبات `OrderEngine`. |
| **01:35 - 01:50** | 15 دقيقة | **تحدي تفاعلي واستقلالي للطلاب** | الطلاب يكتبون كود تصفية سلة مشتريات واستخراج المنتجات الأكثر طلباً. |
| **01:50 - 02:00** | 10 دقائق | **ملخص وتتويج الأسبوع الأول** | مراجعة خريطة الأسبوع الأول (Variables, Loops, Functions, Collections) والاستعداد للأسبوع الثاني (OOP). |

---

## 4. السيناريو الكامل للشرح باللهجة المصرية للمبتدئين (Spoken Instructor Script)

### [الدقيقة 00:00 - 00:15] التمهيد وفتح الموضوع: فخ المتغيرات المنفردة وقائمة المشتريات
> **المحاضر يبتسم ويبدأ:**  
> "مساء الخير يا شباب! المحاضرة اللي فاتت اتعلمنا الدوال والحلقات.  
> والنهارده عندنا سؤال بديهي جداً:  
> لو طلبت منك تسجل أسامي 50 طالب في الفصل، هتعمل إيه؟  
> هل هتروح تعمل 50 صندوق في الذاكرة:  
> `String student1 = 'أحمد';`  
> `String student2 = 'سارة';` ... لحد 50؟  
> طبعاً ده كابوس مستحيل أي مبرمج عاقل يعمله!  
> في الحياة لما بننزل السوبر ماركت، بنمسك ورقة واحدة ونكتب فيها **قائمة مشتريات (List)**:  
> (بيض، حليب، جبنة، خبز).  
> ده بالضبط أول وأشهر نوع في تنظيم البيانات في Dart: **القائمة (`List`)**!  
> صندوق واحد كبير جواه أدراج مرقمة بتبدأ دائماً من رقم صفر (Index 0):  
> ```dart
> List<String> students = ['أحمد', 'سارة', 'عمر'];
> print(students[0]); // هيطبع: أحمد!
> ```"

---

### [الدقيقة 00:15 - 00:40] المستوى الأول: ثلاثي المجموعات (List vs Set vs Map)
> **المحاضر يرسم على السبورة ثلاثة أشكال:**  
> "عندنا في لغة Dart ثلاثة أشكال رئيسية لتنظيم البيانات لازم كل مبرمج يحفظهم زي اسمه:  
> 1. **القائمة (`List`):** طابور منظم بالدور، مسموح فيه بالتكرار، وبنوصل لأي عنصر برقم دوره (Index).  
> 2. **المجموعة الفريدة (`Set`):** زي كيس كور سحرية؛ مستحيل تقبل أي عنصر مكرر!  
> لو حاولت تضيف رقم قومي أو إيميل موجود مسبقاً، بتهمله بهدوء: `Set<int> ids = {101, 102, 101};` الناتج هيكون فقط `{101, 102}`!  
> 3. **القاموس أو دليل الهاتف (`Map`):** هنا بنربط كل معلومة بمفتاح فريد (Key $\rightarrow$ Value):  
> زي دليل التليفون: الاسم هو المفتاح، ورقم الموبايل هو القيمة!  
> ```dart
> Map<String, String> phoneBook = {
>   'أحمد': '0101234567',
>   'سارة': '0119876543',
> };
> print(phoneBook['أحمد']); // هيطبع رقم موبايل أحمد فوراً!
> ```  
> ولما نحب نمر على كل العناصر في القائمة، بنستخدم حلقة التكرار الجميلة:  
> `for (var name in students) { print('الطالب: $name'); }`"

---

### [الدقيقة 00:40 - 01:05] المستوى الثاني: التجميع البسيط بالـ Records (Dart 3)
> **المحاضر يرسم شكلين معاً على السبورة:**  
> "طب لو عندي دالة بتجيب بيانات موقع جغرافي، وعايزها ترجع رقمين معاً: خط الطول وخط العرض `(latitude, longitude)`؟  
> في الإصدارات القديمة كنا بنضطر نعمل كلاس كامل معقد.  
> لكن Dart 3 قدمت لنا ميزة أنيقة جداً اسمها **Records**:  
> نقدر نجمع قيمتين أو أكتر بين قوسين عاديين بكل بساطة:  
> ```dart
> (double, double) getCoordinates() {
>   return (30.04, 31.23); // خط العرض وخط الطول للقاهرة!
> }
> ```  
> ونقدر نستقبلهم ونفككهم في سطر واحد:  
> `final (lat, lng) = getCoordinates();`  
> ده اللي بنسميه **Destructuring**؛ يعني فككنا الصندوق وطلعنا القيمتين في متغيرات مستقلة بلمح البصر!"
> طب إزاي نقرأ البيانات منه؟  
> بالطريقة الكلاسيكية عبر `$1` و`$2` أو اسم الـ Named field: `record.name`.  
> لكن الطريقة الهندسية الأحدث والأجمل هي: **الـ Destructuring (التفكيك)**:  
> ```dart
> final (name, age) = getUserInfo();
> print('$name is $age years old.');
> ```
> في سطر واحد فككت الـ Record وخزنت كل قيمة في متغير مستقل بنوعها الصارم!"

---

### [الدقيقة 01:00 - 01:30] المستوى الثالث والرابع: Pattern Matching & Switch Expressions
> **المحاضر يكتب كوداً متقدماً على الشاشة:**  
> "تعالوا بقى للعملاق الحقيقي في Dart 3: **Pattern Matching**!  
> زمان جملة `switch` كانت statement ممله فيها `case` و`break` كتير.  
> في Dart 3، الـ `switch` أصبحت **Expression** (تعبير برمجي يرجع قيمة)!  
> وتقدر تفحص شكل وهيئة البيانات (Shape of Data):  
> ```dart
> String describeStatus(OrderStatus status) => switch (status) {
>   OrderStatus.pending => 'الطلب قيد الانتظار',
>   OrderStatus.shipped => 'الطلب في الطريق',
>   OrderStatus.delivered => 'تم التسليم بنجاح',
>   OrderStatus.cancelled => 'تم الإلغاء',
> };
> ```
> المترجم هنا بيعمل حاجة اسمها **Exhaustiveness Checking**!  
> يعني لو إنت ضفت حالة خامسة في الـ Enum اسمها `refunded` ونسيت تكتبها في الـ switch...  
> المترجم هيديك خطأ تجميع أحمر فوري يقولك: **'الحالة refunded مش متغطية في الـ switch بتاعك!'**  
> ومفيش حاجة اسمها تسيب حالة مفتوحة تضرب عند العميل في الـ Production!"

---

### [الدقيقة 01:30 - 01:50] التحدي التفاعلي والنقاش
> **المحاضر يعرض كوداً لمعالجة ردود JSON:**  
> "شايفين الـ JSON Payload ده؟  
> جواه قائمة فيها أنواع بيانات مختلفة: نصوص وأرقام وتواريخ.  
> التحدي دلوقتي: مين يكتب لي Switch Expression مع Guard Clauses (`when`) عشان يفرز الطلبات المقبولة ذات القيمة الأعلى من 10,000 جنيه في سطرين بس؟"

---

### [الدقيقة 01:50 - 02:00] التلخيص والختام
> "يا شباب، بكده نكون ختمنا الأسبوع الأول بنجاح باهر!  
> أصبح عندنا فهم صخري للـ Type System، والـ Functions، والـ Collections والـ Modern Patterns.  
> عندكم الواجب المنزلي في `08_HOMEWORK.md`، والاختبار الأسبوعي الشامل في مجلد `weekly_assessment`.  
> شدوا حيلكم وموعدنا الأسبوع القادم مع عالم الـ OOP وهندسة الكائنات! شكراً لكم."

---

## 5. أمثلة التدرج الرباعي (The 4 Code Levels)

### LEVEL 1 — SIMPLE (البسيط):
```dart
void main() {
  // Collection if and spread operator
  final hasDiscount = true;
  final baseItems = ['Laptop', 'Mouse'];
  final cart = [
    ...baseItems,
    if (hasDiscount) 'Discount Coupon (20%)',
  ];
  print('L1 Cart: $cart');
}
```

### LEVEL 2 — INTERMEDIATE (المتوسط):
```dart
// Records and Destructuring
(double latitude, double longitude) getGeoCoordinates(String city) {
  return city == 'Cairo' ? (30.0444, 31.2357) : (0.0, 0.0);
}

void main() {
  // Destructuring into local variables
  final (lat, lng) = getGeoCoordinates('Cairo');
  print('Cairo Geo: Lat=$lat, Lng=$lng');
}
```

### LEVEL 3 — ADVANCED (المتقدم):
```dart
// Pattern Matching with Records and Guard Clauses
String evaluateTransaction((String type, double amount) tx) {
  return switch (tx) {
    ('DEPOSIT', > 50000.0) => 'LARGE_DEPOSIT_AML_CHECK',
    ('DEPOSIT', _) => 'STANDARD_DEPOSIT',
    ('WITHDRAWAL', <= 0.0) => 'INVALID_AMOUNT',
    ('WITHDRAWAL', final amt) when amt > 10000.0 => 'ATM_LIMIT_EXCEEDED',
    ('WITHDRAWAL', _) => 'STANDARD_WITHDRAWAL',
    _ => 'UNKNOWN_TRANSACTION',
  };
}

void main() {
  print(evaluateTransaction(('DEPOSIT', 75000.0)));   // LARGE_DEPOSIT_AML_CHECK
  print(evaluateTransaction(('WITHDRAWAL', 15000.0))); // ATM_LIMIT_EXCEEDED
}
```

### LEVEL 4 — ENGINEERING LEVEL (المستوى المعماري):
```dart
// Sealed Event Hierarchy with Exhaustive Pattern Matching
sealed class OrderEvent {}
class OrderCreated extends OrderEvent { final String id; final double total; OrderCreated(this.id, this.total); }
class OrderShipped extends OrderEvent { final String trackingId; OrderShipped(this.trackingId); }
class OrderCancelled extends OrderEvent { final String reason; OrderCancelled(this.reason); }

String processOrderEvent(OrderEvent event) {
  // Exhaustive switch expression: Compiler forces handling every subclass!
  return switch (event) {
    OrderCreated(:final id, :final total) => 'Order #$id created for \$$total',
    OrderShipped(:final trackingId) => 'Order in transit with carrier: $trackingId',
    OrderCancelled(:final reason) => 'Order aborted: $reason',
  };
}

void main() {
  final event = OrderCreated('ORD_991', 1250.0);
  print('Order Process: ${processOrderEvent(event)}');
}
```

---

## 8. حزمة التطوير البيداغوجي والهندسي للمحاضرة (Advanced Cognitive & Teaching Pack)

### أ. ملاحظات تطوير المحاضر (Instructor Development Notes)
- **الهدف المعرفي الأهم:** إثبات أن الـ `Record` ليس مجرد Tuple؛ بل هو نوع بيانات من الدرجة الأولى يتمتع بـ Structural Equality ومدمج في صلب الـ Type System.
- **تكتيك العرض:** عند كتابة `switch expression` مع `sealed class`، تعمد نسيان إحدى الحالات (مثلاً `OrderCancelled`) ودع المترجم يظهر الخطأ باللون الأحمر ليثبت للطلاب ميزة الـ Exhaustiveness الشاملة.
- **المقارنة الحسابية:** قارن بين زمن البحث في `List` و `Set` على الشاشة لتثبيت مفهوم $O(1)$ مقابل $O(N)$.

### ب. تمارين التفكير الإدراكي للطالب (Student Thinking Exercises)
1. *تمرين التفكيك الفوري (Destructuring):* بالنظر للـ Record التالي: `var record = (id: 101, tags: ['dart', 'mobile'], geo: (lat: 30.04, lng: 31.23));`، اكتب سطراً واحداً يستخرج `lat` و `lng` في متغيرين مستقلين.
2. *تمرين الـ Time Complexity:* إذا كان لديك تطبيق يفحص وجود 100,000 عنصر، احسب الفرق الزمني التقريبي بالثواني بين استخدام `List.contains` و `Set.contains` على معالج حديث.

### ج. سيناريو البرمجة الحية بالتفكير المسموع (Live Coding Think-Aloud Script)
- **المشكلة:** تحليل JSON معقد لطلب شراء يحتوي على بيانات العميل، وعنوان الشحن، وقائمة المنتجات دون كتابة كلاسات DTO مؤقتة.
- **التفكير بصوت مسموع:**  
  > *"بدل ما أقعد أكتب 40 سطر كود وDTOs لمجرد إني عايز أفكك حقلين من الـ JSON، هستخدم الـ Object Pattern Matching في Dart 3. بصوا كده:  
  > ```dart
  > if (json case {'user': {'id': String id, 'email': String email}, 'total': double total}) {
  >   print('User $id ($email) spent \$$total');
  > }
  > ```  
  > شايفين الأناقة؟ في سطر واحد فحصنا وجود الحقول، وفحصنا أنواعها، وفككنا القيم في متغيرات محلية غير قابلة لـ Null! ده بيوفر علينا آلاف الأسطر في المشاريع الضخمة!"*

### د. الأنشطة التفاعلية ونقاش القاعة (Discussion Activities)
- **تحدي الـ JSON Multi-Vendor Parsing:** عرض JSON مرسل من شركتي شحن مختلفتين، وتكليف الطلاب في ثنائيات بكتابة `switch expression` واحدة تعالج الشركتين بسلاسة فائقة.

### هـ. فحص المفاهيم الخاطئة (Misconception Checks)
- **السؤال الفخ:** *"هل الـ Record ذو الخصائص المسماة (Named Fields) يختلف عن الـ Record ذو الخصائص الموضعية (Positional Fields) في المقارنة والقيمة؟"*  
  - *الفهم الخاطئ:* لا، طالما أن القيم متماثلة فالـ Records متطابقة!  
  - *التصحيح الصارم:* غير صحيح! الـ Record Types تتحدد بالترتيب والأسماء؛ فـ `(int a, String b)` نوع مختلف تماماً عن `({int a, String b})` ولا يمكن إسناد أحدهما للآخر.

### و. التحدي الهندسي واتخاذ القرار (Engineering Decision Challenge)
- **المسألة:** متى نستخدم `Record` ومتى ننشئ `Class` مخصص؟  
- **الدفاع المطلوب:** الـ `Record` ممتاز للبيانات المؤقتة الداخلية ونقل القيم بين الدوال داخل نفس الـ Module أو الشاشة. أما إذا كانت البيانات تمثل كائناً يمتلك سلوكاً (Business Methods) أو يعبر عن Domain Entity معقدة في الـ Clean Architecture، فالـ `Class` هو الخيار الهندسي الصحيح.

### ز. جسر المعرفة إلى Flutter (The Flutter Connection)
- **أين سيقابل الطالب هذا في Flutter؟**
  - نمذجة الـ UI State في BLoC و Riverpod: استخدام `sealed class UIState` مع `switch` داخل دالة `build()` هو المعيار العالمي الأحدث في تطبيقات Flutter Enterprise.
  - الـ Collection-if والـ Spread Operator `...` هما الأساس في بناء القوائم الديناميكية داخل `Column` و `Row` والـ Navigation Stacks.
