/// ==============================================================================
/// اسم الملف: 02_intermediate_sound_null_safety.dart
/// الهدف التعليمي: إتقان نظام الأمان الصارم للـ Null (Sound Null Safety)،
/// وتحليل تدفق الكود (Flow Analysis)، وترقية الأنواع (Type Promotion)،
/// ومعاملات الحماية (`?.`، `??`، `??=`).
///
/// طريقة التشغيل:
///   dart run 02_intermediate_sound_null_safety.dart
/// ==============================================================================

class CustomerProfile {
  final String id;
  final String fullName;
  final String? secondaryEmail; // بيقبل null صراحة: ممكن يكون موجود وممكن لأ
  final int? loyaltyPoints;

  const CustomerProfile({
    required this.id,
    required this.fullName,
    this.secondaryEmail,
    this.loyaltyPoints,
  });
}

void main() {
  print('=== الخطوة 1: كل حاجة ممنوع تكون Null بشكل افتراضي ===');
  // في Dart، أي متغير مستحيل يشيل null إلا لو حطيت له علامة '?' صراحة
  String primaryEmail = 'eng.ibrahim@example.com';
  // primaryEmail = null; // خطأ وقت الترجمة: مينفعش تحط قيمة 'null' في متغير نوعه 'String'!
  print('إيميل أساسي مضمون إنه مش null أبداً: $primaryEmail');

  print('\n=== الخطوة 2: إنشاء بروفايلات بتقبل الـ Null ===');
  final customerWithNulls = CustomerProfile(
    id: 'cust_001',
    fullName: 'Youssef Mansour',
    secondaryEmail: null,
    loyaltyPoints: null,
  );

  final customerComplete = CustomerProfile(
    id: 'cust_002',
    fullName: 'Mariam Adel',
    secondaryEmail: 'mariam.dev@example.org',
    loyaltyPoints: 350,
  );

  print('البروفايل الأول: ${customerWithNulls.fullName}، الإيميل الثانوي: ${customerWithNulls.secondaryEmail}');
  print('البروفايل الثاني: ${customerComplete.fullName}، الإيميل الثانوي: ${customerComplete.secondaryEmail}');

  print('\n=== الخطوة 3: معاملات الأمان للـ Null على أرض الواقع ===');

  // 1. معامل الوصول الآمن (?. Safe Navigation Operator):
  // لو القيمة null، بينزل null بهدوء ومبيعملش Crash ولا NullPointerException
  int? emailLength1 = customerWithNulls.secondaryEmail?.length;
  int? emailLength2 = customerComplete.secondaryEmail?.length;
  print('طول الإيميل بالأمان الأول: $emailLength1'); // null
  print('طول الإيميل بالأمان الثاني: $emailLength2'); // 22

  // 2. معامل الدمج وتوفير قيمة بديلة (?? Null-Coalescing Operator):
  // بيضمن قيمة افتراضية في حال كانت القيمة الأساسية null
  String displayEmail1 = customerWithNulls.secondaryEmail ?? 'no-secondary-email@system.internal';
  String displayEmail2 = customerComplete.secondaryEmail ?? 'no-secondary-email@system.internal';
  print('الإيميل البديل للأول: $displayEmail1');
  print('الإيميل البديل للثاني: $displayEmail2');

  // 3. معامل الإسناد عند الفراغ فقط (??= Null-Coalescing Assignment Operator)
  int? assignIfNull(int? current, int fallback) {
    var temp = current;
    temp ??= fallback; // مش هيحط fallback غير لو temp بـ null فعلاً
    return temp;
  }

  int? initialScore;
  final firstAssignment = assignIfNull(initialScore, 100);
  final secondAssignment = assignIfNull(firstAssignment, 500);
  print('أول إسناد للنقاط (كانت فاضية فأخدت 100): $firstAssignment');
  print('ثاني إسناد (كانت خلاص مليانة ففضلت زي ما هي 100): $secondAssignment');

  print('\n=== الخطوة 4: تحليل تدفق الكود وترقية النوع تلقائياً (Flow Analysis & Type Promotion) ===');
  processCustomerEmail(customerWithNulls.secondaryEmail);
  processCustomerEmail(customerComplete.secondaryEmail);

  print('\n=== الخطوة 5: الحركة الخطيرة: الفك الإجباري باستخدام علامة التعجب (!) ===');
  demonstrateForceUnwrapSafety(customerComplete.secondaryEmail);
  demonstrateForceUnwrapDanger(customerWithNulls.secondaryEmail);
}

/// بتوضح إزاي الـ Flow Analysis بيرقي المتغير من يقبل null إلى غير قابل للـ null
void processCustomerEmail(String? rawEmail) {
  if (rawEmail == null) {
    print('تحليل التدفق: الإيميل طلع فاضي (null). هنتخطى الإشعار.');
    return;
  }

  // في اللحظة دي، المترجم الذكي أثبت 100% إن rawEmail مستحيل يكون null عشان عدينا الـ if!
  // خد بالك: بننادي .toUpperCase() مباشرة من غير '?.' ولا '!'
  String guaranteedString = rawEmail.toUpperCase();
  print('ترقية النوع بنجاح: الإيميل بعد التنظيف بقى "$guaranteedString"');
}

void demonstrateForceUnwrapSafety(String? knownNonNull) {
  // استخدام '!' معناه إنك بتقسم للمترجم: "على ضمانتي، المتغير ده مش null دلوقتي"
  String value = knownNonNull!;
  print('الفك الإجباري نجح لأن القيمة فعلاً مش فاضية: $value');
}

void demonstrateForceUnwrapDanger(String? knownNull) {
  try {
    // حركة خطيرة جداً! هتعمل Crash وترمي خطأ Null check operator used on a null value
    String value = knownNull!;
    print('السطر ده عمره ما هيتطبع: $value');
  } catch (e) {
    print('مسكنا الخطأ الكارثي للـ Null Check: $e');
  }
}

/*
================================================================================
الشرح الفني وملاحظات تعليمية (بالبلدي كده)
================================================================================
1. ليه بنقول عليه نظام أمان "Sound"؟
   - زمان قبل الـ Sound Null Safety، كان أي متغير ممكن فجأة يجيله null وقت التشغيل،
     وكانت التطبيقات بتضرب في وش المستخدم بأخطاء NoSuchMethodError المشهورة.
   - مع نظام Dart الصارم، لو المتغير مفيش بعده علامة '?'، فالـ Dart VM بتضمن لك في الـ Compile
     وفي الـ Runtime إنه مستحيل يدخل جواه null أبداً.

2. تحليل التدفق وترقية النوع (Flow Analysis & Promotion):
   - Dart بتمشي مع تفرعات الكود سطر بسطر (if, return, throw).
   - لو شافت سطر `if (variable == null) return;`، أي سطر بعده جوة نفس النطاق بيترقى
     أوتوماتيك من `Type?` إلى `Type` صريح ونظيف.
   - خد بالك: الـ Fields العامة في الكلاسات مش بتترقى بسهولة كده لو مش `final`، لأن ممكن كود
     خارجي يغير قيمتها في النص.

3. نصائح احترافية:
   - قلل جداً من استخدام علامة التعجب `!`؛ كل علامة `!` هي قنبلة موقوتة ومشروع Crash لتطبيقك.
   - اعتمد دايماً على القيم الافتراضية البديلة `??` أو اعمل فحص مبكر واخرج بـ `return`.
================================================================================
*/
