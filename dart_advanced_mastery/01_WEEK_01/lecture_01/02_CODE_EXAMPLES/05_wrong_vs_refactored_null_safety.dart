/// ==============================================================================
/// اسم الملف: 05_wrong_vs_refactored_null_safety.dart
/// الهدف التعليمي: مقارنة عملية بين كود مليان مشاكل وثغرات وبيعتمد بغباء على
/// علامة التعجب `!` و `dynamic`، وبين كود مهندم ومتعدل بمعايير إنتاج احترافية
/// مبنية على الـ Sound Null Safety وتأمين البيانات والقيم الثابتة (Immutability).
///
/// طريقة التشغيل:
///   dart run 05_wrong_vs_refactored_null_safety.dart
/// ==============================================================================

// ==============================================================================
// 1. التطبيق الغلط والهش (كود مليان Anti-Patterns ومشاكل)
// ==============================================================================
class FragileUserOrder {
  dynamic orderId; // غلطة قاتلة: dynamic بتلغي أمان وفحص الأنواع تماماً
  String? customerName;
  double? totalAmount;
  late String receiptCode; // غلطة: متغير late مش متهيء وممكن يفرقع في أي لحظة لو اتقرأ

  FragileUserOrder(this.orderId, this.customerName, this.totalAmount);

  void printReceipt() {
    // غلطة شائعة: الفك الإجباري بعلامة التعجب (!) على عماها من غير أي فحص مسبق
    // لو customerName أو totalAmount طلعوا بـ null، التطبيق هيفرقع بـ TypeError في وش العميل
    print('الطلب رقم #${orderId.toString()} للعميل ${customerName!.toUpperCase()}');
    print('المبلغ الإجمالي: \$${totalAmount!.toStringAsFixed(2)}');
    // محاولة قراءة receiptCode وهو فاضي هترمي خطأ LateInitializationError فوراً
    print('كود الإيصال: $receiptCode');
  }
}

// ==============================================================================
// 2. التطبيق المتعدل والمحترف (كود متين وآمن وجاهز للإنتاج)
// ==============================================================================
class RobustUserOrder {
  final String orderId;
  final String customerName;
  final double totalAmount;
  final String? receiptCode; // بيقبل null صراحة ومتحاوط بقيم بديلة آمنة

  const RobustUserOrder({
    required this.orderId,
    required this.customerName,
    required this.totalAmount,
    this.receiptCode,
  }) : assert(totalAmount >= 0.0, 'المبلغ الإجمالي مستحيل يكون بالسالب');

  /// Factory Constructor آمن بيفحص وينظف البيانات اللي جاية من برة ومش موثوق فيها
  factory RobustUserOrder.fromUntrustedData({
    required dynamic rawId,
    required String? rawName,
    required double? rawAmount,
    String? receiptCode,
  }) {
    // 1. فحص رقم الطلب
    if (rawId == null || rawId.toString().trim().isEmpty) {
      throw ArgumentError('رقم الطلب مينفعش يجي فاضي أو null');
    }

    // 2. فحص وتنظيف اسم العميل وإعطاؤه قيمة بديلة لو فاضي
    final sanitizedName = (rawName != null && rawName.trim().isNotEmpty)
        ? rawName.trim()
        : 'عميل_زائر';

    // 3. فحص وتأمين المبلغ
    final sanitizedAmount = (rawAmount != null && rawAmount >= 0.0)
        ? rawAmount
        : 0.0;

    return RobustUserOrder(
      orderId: rawId.toString(),
      customerName: sanitizedName,
      totalAmount: sanitizedAmount,
      receiptCode: receiptCode,
    );
  }

  void printReceipt() {
    // كود آمن 100%: كل الحقول مضمونة ومش ممكن تكون null
    print('الطلب رقم #$orderId للعميل ${customerName.toUpperCase()}');
    print('المبلغ الإجمالي: \$${totalAmount.toStringAsFixed(2)}');

    // التعامل الذكي مع الحقل الاختياري باستخدام ?? لإعطاء نص بديل
    final receipt = receiptCode ?? 'جاري_إصدار_الإيصال_إلكترونياً';
    print('الإيصال: $receipt');
  }
}

void main() {
  print('=== السيناريو 1: تشغيل الكود الهش والمليان مشاكل (هيعمل Crash) ===');
  final buggyOrder = FragileUserOrder(1099, null, 450.0);

  try {
    buggyOrder.printReceipt();
  } catch (e) {
    print('>> تم مسك الكارثة والـ Crash في الكود الضعيف:');
    print('   رسالة الخطأ: $e');
  }

  print('\n=== السيناريو 2: تشغيل الكود المتعدل والآمن (Safe 100%) ===');
  // بنبعت قيم فيها null للمصنع الآمن وهو هيتصرف بحكمة
  final safeOrder1 = RobustUserOrder.fromUntrustedData(
    rawId: 1099,
    rawName: null, // هيتحول بسلاسة لـ "عميل_زائر"
    rawAmount: 450.0,
    receiptCode: null, // هيتعامل معاه بأمان كإيصال تحت الإصدار
  );

  safeOrder1.printReceipt();

  print('\n=== السيناريو 3: تشغيل الكود المتعدل ببيانات كاملة وسليمة ===');
  final safeOrder2 = RobustUserOrder.fromUntrustedData(
    rawId: 'ORD_2026_EG_88',
    rawName: 'المهندس محمود',
    rawAmount: 1899.99,
    receiptCode: 'RCPT_VERIFIED_9918',
  );

  safeOrder2.printReceipt();
}

/*
================================================================================
مقارنة هندسية وقائمة مراجعة الكود (Code Review) - بالبلدي كده
================================================================================
عنصر المقارنة           | الكود الهش الضعيف               | الكود المتعدل المحترف
------------------------|---------------------------------|---------------------------------
أمان الأنواع            | ضعيف (`dynamic orderId`)        | صارم ومحمي (`String orderId`)
التعامل مع الـ Null     | فك إجباري أعمى بـ (`!`)         | أنواع مضمونة وقيم بديلة بـ (`??`)
مخاطر التهيئة المبدئية  | متغيرات `late` بتفرقع في الرام  | تهيئة صريحة ومحمية في الـ Constructor
فحص وتنقية البيانات     | منعدم تماماً                    | Factory آمن بفلتر المدخلات
ثبات البيانات (Immut.)  | متغيرات قابلة للتعديل واللعب    | بيانات غير قابلة للتعديل (`final`)
================================================================================
*/
