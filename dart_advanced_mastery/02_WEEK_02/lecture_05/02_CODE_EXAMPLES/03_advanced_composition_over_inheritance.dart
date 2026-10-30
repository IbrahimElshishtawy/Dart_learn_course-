// ==============================================================================
// 03_advanced_composition_over_inheritance.dart
// Week 02 - Lecture 05: Composition Over Inheritance (Strategy Pattern)
// ==============================================================================
// الهدف:
// 1. تطبيق المبدأ المعماري: "فضّل التركيب على الوراثة" (Favor Composition Over Inheritance).
// 2. تجنب مشاكل شجرة الوراثة الصلبة التي تنكسر عند تغير متطلبات العمل.
// 3. بناء كائن الطلب (Order) بتركيب استراتيجيات منفصلة (الخصم، الضرائب، التسجيل).
// ==============================================================================

// -----------------------------------------------------------------------------
// واجهات الاستراتيجيات المكونة (Composable Strategies)
// -----------------------------------------------------------------------------
abstract class DiscountStrategy {
  double applyDiscount(double originalAmount);
}

abstract class TaxStrategy {
  double calculateTax(double amount);
}

// -----------------------------------------------------------------------------
// تطبيقات استراتيجيات الخصم
// -----------------------------------------------------------------------------
class NoDiscount implements DiscountStrategy {
  const NoDiscount();
  @override
  double applyDiscount(double originalAmount) => originalAmount;
}

class PercentageDiscount implements DiscountStrategy {
  final double percentage; // e.g. 0.15 for 15%
  const PercentageDiscount(this.percentage)
      : assert(percentage >= 0 && percentage <= 1.0, 'نسبة الخصم يجب أن تكون بين 0 و 1');

  @override
  double applyDiscount(double originalAmount) =>
      originalAmount - (originalAmount * percentage);
}

// -----------------------------------------------------------------------------
// تطبيقات استراتيجيات الضرائب
// -----------------------------------------------------------------------------
class VatTaxStrategy implements TaxStrategy {
  final double vatRate; // e.g. 0.14 for 14% VAT in Egypt
  const VatTaxStrategy([this.vatRate = 0.14]);

  @override
  double calculateTax(double amount) => amount * vatRate;
}

class ZeroTaxStrategy implements TaxStrategy {
  const ZeroTaxStrategy();
  @override
  double calculateTax(double amount) => 0.0;
}

// -----------------------------------------------------------------------------
// كلاس الطلب المركب (Order composed of Strategies)
// علاقة Has-A بدلاً من Is-A
// -----------------------------------------------------------------------------
class Order {
  final String orderId;
  final double subtotal;
  final DiscountStrategy discountStrategy;
  final TaxStrategy taxStrategy;

  const Order({
    required this.orderId,
    required this.subtotal,
    this.discountStrategy = const NoDiscount(),
    this.taxStrategy = const VatTaxStrategy(),
  });

  /// حساب الإجمالي النهائي بتركيب الاستراتيجيات
  double get finalTotal {
    final discountedSubtotal = discountStrategy.applyDiscount(subtotal);
    final tax = taxStrategy.calculateTax(discountedSubtotal);
    return discountedSubtotal + tax;
  }

  void printReceipt() {
    final discounted = discountStrategy.applyDiscount(subtotal);
    final tax = taxStrategy.calculateTax(discounted);

    print('🧾 تفاصيل الفاتورة المركبة [$orderId]:');
    print('   - السعر الأساسي: \$$subtotal');
    print('   - بعد الخصم: \$$discounted');
    print('   - الضريبة المضافة: \$$tax');
    print('   💰 الإجمالي المستحق: \$${finalTotal.toStringAsFixed(2)}\n');
  }
}

void main() {
  print('=== 🔵 كود المحاضرة 5: مبدأ التركيب مقابل الوراثة (Composition) ===\n');

  // طلب عادي بدون خصم وضريبة قياسية
  final standardOrder = Order(
    orderId: 'ORD-101',
    subtotal: 1000.0,
  );
  standardOrder.printReceipt();

  // طلب مع خصم كبار العملاء 20% وإعفاء ضريبي (تركيب استراتيجيات جديدة بسهولة تامة)
  final vipOrder = Order(
    orderId: 'ORD-VIP-202',
    subtotal: 1000.0,
    discountStrategy: const PercentageDiscount(0.20),
    taxStrategy: const ZeroTaxStrategy(),
  );
  vipOrder.printReceipt();

  print('💡 لاحظ: أضفنا سلوكيات مختلفة تماماً بدون إنشاء 10 كلاسات بالوراثة مثل (VipTaxFreeOrder)!');
}
