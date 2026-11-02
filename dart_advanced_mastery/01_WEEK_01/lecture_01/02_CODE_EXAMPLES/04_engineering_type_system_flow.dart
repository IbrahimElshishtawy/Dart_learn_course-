/// ==============================================================================
/// اسم الملف: 04_engineering_type_system_flow.dart
/// الهدف التعليمي: فهم نوع القاع `Never` في Dart، والتحليل المتقدم لتدفق الكود
/// مع الإسناد الحتمي (Definite Assignment)، وبناء نموذج تدقيق مالي قوي واحترافي.
///
/// طريقة التشغيل:
///   dart run 04_engineering_type_system_flow.dart
/// ==============================================================================

/// استثناء مخصص لانتهاكات الأمان (Custom Exception)
class SecurityViolationException implements Exception {
  final String message;
  final DateTime timestamp;

  SecurityViolationException(this.message) : timestamp = DateTime.now();

  @override
  String toString() => '[$timestamp] SecurityViolationException: $message';
}

/// الدالة اللي نوع إرجاعها `Never` مستحيل ترجع أي قيمة تحت أي ظرف!
/// يا إما بترمي Exception يوقف التنفيذ، يا إما بتدخل في Infinite Loop.
/// مترجم Dart بيستخدم ده عشان يعرف إن الكود اللي بعدها ميت (Dead Code) ولترقية الأنواع تلقائياً.
Never abortWithSecurityBreach(String breachDetails) {
  throw SecurityViolationException(breachDetails);
}

/// كلاس بيمثل المعاملة المالية
class FinancialTransaction {
  final String transactionId;
  final double amount;
  final String sourceIban;
  final String targetIban;
  final String? ipAddress;

  const FinancialTransaction({
    required this.transactionId,
    required this.amount,
    required this.sourceIban,
    required this.targetIban,
    this.ipAddress,
  });
}

/// مدقق مالي بمستوى هندسي عالي معتمداً على ترقية الأنواع وتحليل التدفق
class TransactionAuditor {
  /// تدقيق وتنقية بيانات المعاملة المالية
  static void auditTransaction(FinancialTransaction? tx) {
    print('جاري فحص وتدقيق المعاملة رقم: ${tx?.transactionId} ...');

    // 1. حماية ضد المعاملات الفارغة (null)
    if (tx == null) {
      abortWithSecurityBreach('بيانات المعاملة جاية فاضية خالص (null)!');
    }

    // خد بالك وركز: لأن دالة abortWithSecurityBreach نوعها 'Never'،
    // فالمترجم الذكي أثبت إن السطور اللي جاية مستحيل يكون فيها 'tx' بـ null نهائي!
    // عشان كده 'tx' اترقت تلقائياً من FinancialTransaction? إلى FinancialTransaction صريحة.

    if (tx.amount <= 0.0) {
      abortWithSecurityBreach('مبلغ المعاملة لازم يكون موجب وأكبر من الصفر: ${tx.amount}');
    }

    if (tx.sourceIban == tx.targetIban) {
      abortWithSecurityBreach('مينفعش الآيبان المحول منه يكون هو نفسه المحول إليه: ${tx.sourceIban}');
    }

    // التحقق من عنوان الآي بي (IP) مع ترقية النوع محلياً
    final String verifiedIp;
    if (tx.ipAddress != null && tx.ipAddress!.trim().isNotEmpty) {
      verifiedIp = tx.ipAddress!;
    } else {
      verifiedIp = '0.0.0.0 (نظام داخلي)';
    }

    print('>> تمت الموافقة والتدقيق: المعاملة ${tx.transactionId} بقيمة \$${tx.amount.toStringAsFixed(2)} من الآي بي: $verifiedIp');
  }
}

void main() {
  print('=== الخطوة 1: اختبار معاملة مالية سليمة ومكتملة ===');
  const validTx = FinancialTransaction(
    transactionId: 'TX_EG_9812401',
    amount: 15450.75,
    sourceIban: 'EG120002000100000012345678901',
    targetIban: 'EG990002000100000098765432109',
    ipAddress: '197.34.120.15',
  );

  TransactionAuditor.auditTransaction(validTx);

  print('\n=== الخطوة 2: اختبار معاملة بمبلغ صفر أو بالسالب ===');
  const invalidAmountTx = FinancialTransaction(
    transactionId: 'TX_EG_ZERO_AMT',
    amount: -50.0,
    sourceIban: 'EG120002000100000012345678901',
    targetIban: 'EG990002000100000098765432109',
  );

  try {
    TransactionAuditor.auditTransaction(invalidAmountTx);
  } on SecurityViolationException catch (e) {
    print('مسكنا الرفض الأمني المتوقع: $e');
  }

  print('\n=== الخطوة 3: اختبار محاولة احتيال بالتحويل لنفس الحساب ===');
  const fraudTx = FinancialTransaction(
    transactionId: 'TX_EG_SELF_LOOP',
    amount: 1000.0,
    sourceIban: 'EG120002000100000012345678901',
    targetIban: 'EG120002000100000012345678901', // نفس الحساب بالضبط!
  );

  try {
    TransactionAuditor.auditTransaction(fraudTx);
  } on SecurityViolationException catch (e) {
    print('مسكنا الرفض الأمني المتوقع: $e');
  }

  print('\n=== الخطوة 4: توضيح معرفة المترجم بالكود الميت (Dead Code) بفضل Never ===');
  demonstrateCompilerDeadCode();
}

void demonstrateCompilerDeadCode() {
  bool simulateCriticalAlert = true;

  if (simulateCriticalAlert) {
    print('توضيح Never: بننادي دالة الإيقاف الأمني...');
    try {
      abortWithSecurityBreach('تم تفعيل إنذار أمني طارئ في النظام!');
      // لو كتبت أي سطر هنا المترجم هيحط تحته خط أحمر ويقولك unreachable code!
    } on SecurityViolationException catch (e) {
      print('مسكنا الاستثناء: $e');
    }
  }
}

/*
================================================================================
الأساس الهندسي وأفضل الممارسات (بالبلدي كده)
================================================================================
1. نوع القاع `Never` (The Bottom Type):
   - في علم لغات البرمجة، `Never` نوع ملوش أي قيم خالص، ومفيش متغير يقدر يشيل قيمة منه.
   - لما دالة ترجع `Never`، المترجم بيفهم فوراً إن مسار التنفيذ بينتهي تماماً هنا ومبيكملش.
   - ده بيخلي المترجم ذكي كفاية إنه يرقي الأنواع بعد السطر ده من غير ما تحتاج تكتب `else` أو بلوكات ملهاش لزمة.

2. الإسناد الحتمي والمضمون (Definite Assignment):
   - Dart بتتأكد إن أي متغير محلي غير قابل للـ null أخد قيمة في كل مسارات الكود قبل ما تحاول تقراه.
   - لاحظ إزاي `verifiedIp` في دالة التدقيق اتعرفت من غير قيمة ابتدائية (`final String verifiedIp;`)
     وتم إسنادها في الـ `if` والـ `else`، فالمترجم ضمن 100% إنها مش هتتقرأ وهي فاضية أبداً.
================================================================================
*/
