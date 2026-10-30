// ==============================================================================
// 02_intermediate_interfaces_polymorphism.dart
// Week 02 - Lecture 05: Implicit Interfaces & Runtime Polymorphism
// ==============================================================================
// الهدف:
// 1. فهم أن كل كلاس في لغة Dart هو واجهة ضمنية (Implicit Interface).
// 2. استخدام implements لإلزام الكلاس بتطبيق الواجهة دون وراثة أي كود.
// 3. تطبيق التعددية الشكلية (Polymorphism): معالجة أنواع مختلفة من خلال واجهة موحدة.
// ==============================================================================

/// واجهة أولى: قابل للدفع
abstract class Payable {
  double get amount;
  bool processPayment();
}

/// واجهة ثانية: قابل للطباعة والإيصال
abstract class ReceiptGeneratable {
  String generateReceipt();
}

/// تطبيق الفئتين معاً (Multiple Interfaces via implements)
class CreditCardInvoice implements Payable, ReceiptGeneratable {
  final String cardLastFour;
  final String cardHolder;
  @override
  final double amount;

  CreditCardInvoice({
    required this.cardLastFour,
    required this.cardHolder,
    required this.amount,
  });

  @override
  bool processPayment() {
    print('💳 خصم مبلغ \$$amount من البطاقة المنتهية بـ ****$cardLastFour للعميل $cardHolder');
    return true;
  }

  @override
  String generateReceipt() {
    return '🧾 إيصال بطاقة ائتمان: تم سداد \$$amount بنجاح للعميل $cardHolder';
  }
}

/// تطبيق آخر للواجهة: محفظة هاتف محمول
class MobileWalletInvoice implements Payable, ReceiptGeneratable {
  final String mobileNumber;
  @override
  final double amount;

  MobileWalletInvoice({
    required this.mobileNumber,
    required this.amount,
  });

  @override
  bool processPayment() {
    print('📱 تحويل مبلغ \$$amount من المحفظة الذكية للهاتف $mobileNumber');
    return true;
  }

  @override
  String generateReceipt() {
    return '🧾 إيصال محفظة ذكية: تم تحويل \$$amount من الرقم $mobileNumber';
  }
}

// -----------------------------------------------------------------------------
// دالة هندسية متعددة الأشكال (Polymorphic Engine)
// تتعامل مع الواجهة العامة Payable دون أن تعرف تفاصيل البطاقة أو المحفظة
// -----------------------------------------------------------------------------
void executeBatchPayments(List<Payable> paymentQueue) {
  print('--- 🚀 بدء معالجة حزمة المدفوعات (Polymorphic Batch) ---');
  var totalProcessed = 0.0;

  for (final payment in paymentQueue) {
    // استدعاء دالة العقد الموحدة
    final success = payment.processPayment();
    if (success) {
      totalProcessed += payment.amount;

      // فحص نوع اختياري ذكي (Smart Type Promotion)
      if (payment is ReceiptGeneratable) {
        print('   ${payment.generateReceipt()}');
      }
    }
  }

  print('----------------------------------------------------');
  print('💰 إجمالي المدفوعات الناجحة: \$$totalProcessed\n');
}

void main() {
  print('=== 🟡 كود المحاضرة 5: الواجهات والتعددية الشكلية (Polymorphism) ===\n');

  // إنشاء قائمة غير متجانسة تحتوي على فئات مختلفة تلتزم بنفس العقد
  final List<Payable> queue = [
    CreditCardInvoice(cardLastFour: '4242', cardHolder: 'Ahmed Nabil', amount: 150.0),
    MobileWalletInvoice(mobileNumber: '01099887766', amount: 45.0),
    CreditCardInvoice(cardLastFour: '8821', cardHolder: 'Sara Samir', amount: 320.0),
  ];

  // تشغيل المحرك متعدد الأشكال
  executeBatchPayments(queue);
}
