/// ==============================================================================
/// اسم الملف: 01_beginner_types_basics.dart
/// الهدف التعليمي: فهم الأنواع الأساسية في Dart، واستنتاج الأنواع الساكنة (`var`)،
/// والفرق الجوهري بين `Object` و `dynamic`، ونظام الأنواع الصارم.
///
/// طريقة التشغيل:
///   dart run 01_beginner_types_basics.dart
/// ==============================================================================

void main() {
  print('=== الخطوة 1: تحديد النوع صراحةً مقابل استنتاج النوع (Type Inference) ===');

  // تحديد النوع بشكل صريح وواضح (Explicit type declaration)
  int accountId = 10042;
  double interestRate = 0.045;
  String accountHolder = 'Fatima Zahra';
  bool isActive = true;

  print('الأنواع الصريحة: id=$accountId, rate=$interestRate, holder=$accountHolder, active=$isActive');

  // استنتاج النوع باستخدام 'var': مترجم Dart بيعرف لوحده إن النوع String وقت الـ Compile-time
  var transactionTag = 'TX_REFUND_99';
  // transactionTag = 42; // خطأ في الترجمة (Compile Error): مينفعش تحط رقم int في متغير نوعه String اتحدد خلاص!
  print('النوع المستنتج لـ transactionTag هو String: "$transactionTag"');

  print('\n=== الخطوة 2: الفرق الجوهري والأساسي بين Object و dynamic ===');

  // Object: هو رأس شجرة الوراثة لكل الأنواع غير القابلة للـ null (non-nullable) في Dart.
  // المترجم هنا بيحرسك ويطبق الفحص الصارم: مش هيسمح لك تنادي غير الدوال المعرفة في Object (زي toString و hashCode).
  Object safeContainer = 'Enterprise Security Token';
  print('safeContainer كـ Object مع دالة toString: ${safeContainer.toString()}');
  // safeContainer.toUpperCase(); // خطأ في الترجمة (Compile Error): دالة toUpperCase مش موجودة في كلاس Object!

  // ترقية النوع (Type promotion) عن طريق فحص الشرط 'is'
  if (safeContainer is String) {
    // محلل التدفق (Flow Analysis) في Dart بيرقي safeContainer تلقائياً لـ String جوة البلوك ده
    print('بعد الترقية safeContainer بقى String بالحروف الكبيرة: ${safeContainer.toUpperCase()}');
  }

  // dynamic: بيلغي فحص المترجم تماماً، وبيأجل التأكد من الدوال لوقت التشغيل (Runtime).
  dynamic untypedInput = 'Initial Raw String';
  print('طول النص في dynamic: ${untypedInput.length}');

  // عادي جداً تغير نوع القيمة وقت التشغيل مع المتغيرات اللي نوعها dynamic:
  untypedInput = 123456;
  print('تم تغيير قيمة untypedInput إلى رقم int: $untypedInput');

  // تحذير: لو ناديت دالة مش موجودة، الكود هيعدي من الـ Compile بس هينفجر ويعمل Crash وقت التشغيل!
  try {
    // السطر ده هيضرب خطأ NoSuchMethodError وقت التشغيل لأن الرقم ملوش toLowerCase
    untypedInput.toLowerCase();
  } on NoSuchMethodError catch (e) {
    print('مسكنا الكارثة في وقت التشغيل (NoSuchMethodError): $e');
  }

  print('\n=== الخطوة 3: تسلسل الأرقام: num و int و double ===');
  // 'num' هو الكلاس الأب المجرد للاثنين: 'int' و 'double'
  num flexibleAmount = 50; // هنا شايل رقم صحيح int
  print('flexibleAmount كـ int: $flexibleAmount (نوعه وقت التشغيل: ${flexibleAmount.runtimeType})');
  flexibleAmount = 79.99; // وممكن عادي يشيل رقم عشري double بأمان
  print('flexibleAmount كـ double: $flexibleAmount (نوعه وقت التشغيل: ${flexibleAmount.runtimeType})');

  print('\nتم التنفيذ بأمان ومن غير أي أخطاء غير معالجة.');
}

/*
================================================================================
الشرح الفني وملاحظات تعليمية (بالبلدي كده)
================================================================================
1. شرح الـ Syntax:
   - `var`: بتقول لمترجم Dart: "خمّن إنت النوع من أول قيمة هتاخدها". وأول ما يحدد النوع، بيفضل ثابت طول عمره ومينفعش يتغير.
   - `Object`: هو النوع الأب الأعلى (Top Type) لكل الكائنات غير القابلة للـ null، وبيضمنلك الأمان بنسبة 100%.
   - `dynamic`: باب خلفي للهروب من فحص المترجم. مفيد بس في حالات معينة زي تحويل البيانات (Serialization) أو التعامل مع كود جافاسكريبت خارجي.

2. المخرجات المتوقعة (Expected Output):
   === الخطوة 1: تحديد النوع صراحةً مقابل استنتاج النوع (Type Inference) ===
   الأنواع الصريحة: id=10042, rate=0.045, holder=Fatima Zahra, active=true
   النوع المستنتج لـ transactionTag هو String: "TX_REFUND_99"

   === الخطوة 2: الفرق الجوهري والأساسي بين Object و dynamic ===
   safeContainer كـ Object مع دالة toString: Enterprise Security Token
   بعد الترقية safeContainer بقى String بالحروف الكبيرة: ENTERPRISE SECURITY TOKEN
   طول النص في dynamic: 18
   تم تغيير قيمة untypedInput إلى رقم int: 123456
   مسكنا الكارثة في وقت التشغيل (NoSuchMethodError): ...

   === الخطوة 3: تسلسل الأرقام: num و int و double ===
   flexibleAmount كـ int: 50 (نوعه وقت التشغيل: int)
   flexibleAmount كـ double: 79.99 (نوعه وقت التشغيل: double)

   تم التنفيذ بأمان ومن غير أي أخطاء غير معالجة.

3. أشهر الغلطات اللي بيقع فيها المطورين:
   - إنك تفتكر `var` زي الـ `var` في JavaScript وبتقبل أي نوع في أي وقت! في Dart، لما تقول `var x = 1` خلاص بقى `int` صارم للأبد.
   - كثرة استخدام `dynamic` عشان تكسل وتتخلص من تحذيرات المترجم؛ الحركة دي بتحول أخطاء وقت الترجمة لكوارث وCrash في وش المستخدم في الإنتاج.

4. تحليل الأداء والتعقيد (Complexity):
   - الوصول للمتغيرات الأساسية: O(1) في الوقت، O(1) في الذاكرة.
   - فحص النوع (باستخدام `is`): O(1) فحص سريع جداً لمؤشر الكلاس في الذاكرة.

5. بديل هندسي أفضل:
   - بدل ما تستخدم `dynamic`، اعتمد على الـ Generics (`<T>`) أو كلاسات الـ Sealed لما تتعامل مع بيانات بأنواع مختلفة.
================================================================================
*/
