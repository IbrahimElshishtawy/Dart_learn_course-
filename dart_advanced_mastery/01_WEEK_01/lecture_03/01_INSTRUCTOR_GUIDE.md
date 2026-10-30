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

## 3. التوزيع الزمني الدقيق (120-Minute Breakdown)

| الوقت | المدة | النشاط التعليمي | المحتوى والهدف |
| :--- | :--- | :--- | :--- |
| **00:00 - 00:10** | 10 دقائق | **تمهيد وسؤال افتتاحي (The Hook)** | كيف أحدثت Dart 3 ثورة في طريقة كتابة الكود عبر Records وPatterns؟ ولماذا كنا نكتب كوداً مملاً في السابق؟ |
| **00:10 - 00:35** | 25 دقيقة | **المستوى الأول (Level 1 — Simple)** | تشريح الـ Collections: List, Set, Map، Spread Operator، وCollection if/for. |
| **00:35 - 01:00** | 25 دقيقة | **المستوى الثاني (Level 2 — Intermediate)** | الـ Records: الصياغة الموضعية والمسماة، إرجاع قيم متعددة بدون كلاسات، وتفكيك البيانات (Destructuring). |
| **01:00 - 01:30** | 30 دقيقة | **المستوى الثالث والرابع (Advanced & Engineering)** | Pattern Matching العميق، الـ Switch Expressions، الـ Guards (`when`)، وهندسة محرك التجارة الإلكترونية. |
| **01:30 - 01:50** | 20 دقيقة | **تحدي تفاعلي ونقاش جماعي** | تحويل كود JSON Parsing معقد ومليء بـ `if-else` إلى Switch Expression أنيق ومحمي بالـ Exhaustiveness. |
| **01:50 - 02:00** | 10 دقائق | **ملخص وتقييم سريع** | مراجعة مخرجات الأسبوع الأول، استعراض الـ Quiz، والتحضير للاختبار الشامل الأسبوعي. |

---

## 4. السيناريو الكامل للشرح باللهجة المصرية التقنية (Spoken Instructor Script)

### [الدقيقة 00:00 - 00:10] التمهيد وفتح الموضوع
> **المحاضر يبدأ بالوقوف أمام الشاشة:**  
> "مساء الخير يا شباب! المحاضرة دي هي مسك ختام الأسبوع الأول، وهي واحدة من أمتع المحاضرات في تاريخ لغة Dart!  
> حد فيكم فكر قبل كده: لما تكون عندك دالة عايزها ترجع حاجتين في نفس الوقت (مثلاً `Latitude` و`Longitude`، أو `User` و`Token`)...  
> كنا بنعمل إيه زمان قبل Dart 3؟  
> كنا بنعمل حاجة من اتنين، والاتنين أسوأ من بعض:  
> يا إما نروح نكريت Class كامل بكونستركتور وGetters عشان نرجع قيمتين يتيمين!  
> يا إما نرجع `List` أو `Map<String, dynamic>` ونفقد الـ Type Safety تماماً ونقعد نعمل كاستينج بإيدينا ونتعرض لـ Runtime Crashes!  
> فريق Dart في الإصدار 3 جه وقال: **'كفاية معاناة!'**  
> وقدموا للعالم ميزتين معماريتين غيروا شكل البرمجة: **Records** و**Patterns**!  
> النهارده هنتعلم إزاي ترجع قيم متعددة بأمان نوعي كامل وفي سطر واحد، وإزاي تفكك البيانات بالـ Pattern Matching، وإزاي الـ Switch في Dart 3 بقت أذكى بمراحل وبتقدر تفحص كل الحالات وتمنعك تنسى أي احتمال!"

---

### [الدقيقة 00:10 - 00:35] المستوى الأول: تشريح المجموعات وميزات الـ Modern Syntax
> **المحاضر يفتح ملف الكود ويشرح:**  
> "تعالوا نراجع سريعاً المجموعات الأساسية:  
> - `List`: مصفوفة مرتبة، الوصول بالعنصر $O(1)$، لكن البحث فيها $O(N)$.  
> - `Set`: مجموعة لا تقبل التكرار، والبحث فيها $O(1)$ بفضل الـ Hash Table.  
> - `Map`: أزواج مفاتيح وقيم Key-Value.  
> 
> لكن الأجمل في Dart هو أدوات الـ Modern Collections:  
> **Spread Operator (`...` و`...?`):**  
> بدل ما تقعد تعمل `addAll()`، بتفرط القائمة جوه القائمة التانية بكلمة واحدة. ولو القائمة ممكن تكون `null`، بنحط علامة الاستفهام `...?` عشان يفرطها لو موجودة ويتجاهلها بأمان لو null.  
> 
> وكمان **Collection if** و**Collection for**:  
> يعني تقدر تبني قايمتك بشكل ديناميكي وأنيق جوه الأقواس مباشرة:  
> ```dart
> final navBar = [
>   'Home',
>   'Profile',
>   if (isAdmin) 'Admin Dashboard',
>   for (var item in recentOrders) 'Order #${item.id}',
> ];
> ```
> ده بيخلي الكود مقروء وشبه لغات التصميم، وده بالمناسبة هو السر في سهولة كتابة شاشات Flutter!"

---

### [الدقيقة 00:35 - 01:00] المستوى الثاني: ثورة الـ Records في Dart 3
> **المحاضر يرسم على السبورة شكل Record:**  
> "بصوا للجمال ده:  
> ```dart
> (String, int) getUserInfo() {
>   return ('Ibrahim', 30);
> }
> ```
> إيه ده؟ ده مش Class! ده **Record**!  
> الـ Record عبارة عن كائن مجهول (Anonymous)، مجمع (Aggregate)، ومصمت غير قابل للتعديل (Immutable)!  
> ونقدر نعمل فيه Named fields كمان:  
> ```dart
> ({String name, double balance}) getAccount() => (name: 'Mona', balance: 5000.0);
> ```
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
