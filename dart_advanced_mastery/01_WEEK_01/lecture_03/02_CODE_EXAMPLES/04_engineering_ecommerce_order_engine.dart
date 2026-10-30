/// ==============================================================================
/// File: 04_engineering_ecommerce_order_engine.dart
/// Educational Objective: Build a production-grade E-Commerce Order Processing Engine
/// combining Records, Pattern Matching, Destructuring, and Sealed State Types.
///
/// Execution:
///   dart run 04_engineering_ecommerce_order_engine.dart
/// ==============================================================================

// Order Item Record
typedef OrderItem = ({String sku, int quantity, double unitPrice});

// Customer Tier Enum
enum CustomerTier { standard, silver, gold, enterprise }

// Sealed Delivery Policy
sealed class DeliveryMethod {}
class StandardDelivery extends DeliveryMethod {}
class ExpressDelivery extends DeliveryMethod { final bool requiresColdChain; ExpressDelivery({this.requiresColdChain = false}); }
class InternationalDelivery extends DeliveryMethod { final String destinationCountry; InternationalDelivery(this.destinationCountry); }

/// Enterprise Order Model using Records
class Order {
  final String orderId;
  final CustomerTier customerTier;
  final List<OrderItem> items;
  final DeliveryMethod deliveryMethod;
  final String? promoCode;

  const Order({
    required this.orderId,
    required this.customerTier,
    required this.items,
    required this.deliveryMethod,
    this.promoCode,
  });

  /// Total pre-discount subtotal
  double get subtotal =>
      items.fold(0.0, (acc, item) => acc + (item.quantity * item.unitPrice));
}

/// Pattern-Based Pricing Engine
class PricingEngine {
  /// Calculates shipping fee using Pattern Matching on sealed DeliveryMethod
  static double calculateShipping(Order order) {
    final subtotal = order.subtotal;

    return switch ((order.deliveryMethod, order.customerTier, subtotal)) {
      // Rule 1: Free shipping for Enterprise or orders above $5000
      (_, CustomerTier.enterprise, _) || (_, _, >= 5000.0) => 0.0,

      // Rule 2: Standard Delivery
      (StandardDelivery(), CustomerTier.gold, _) => 10.0,
      (StandardDelivery(), _, _) => 25.0,

      // Rule 3: Express Delivery with Cold Chain
      (ExpressDelivery(requiresColdChain: true), _, _) => 120.0,
      (ExpressDelivery(requiresColdChain: false), CustomerTier.gold, _) => 40.0,
      (ExpressDelivery(requiresColdChain: false), _, _) => 65.0,

      // Rule 4: International Delivery
      (InternationalDelivery(:final destinationCountry), _, _)
          when destinationCountry == 'EGYPT' || destinationCountry == 'UAE' => 150.0,
      (InternationalDelivery(), _, _) => 300.0,
    };
  }

  /// Calculates discount percentage using Record Pattern Matching
  static double calculateDiscountPercent(Order order) {
    return switch ((order.customerTier, order.promoCode)) {
      (_, 'VIP99') => 0.30, // 30% Promo override
      (CustomerTier.enterprise, _) => 0.25,
      (CustomerTier.gold, _) => 0.15,
      (CustomerTier.silver, _) => 0.05,
      (CustomerTier.standard, 'WELCOME10') => 0.10,
      _ => 0.0,
    };
  }

  /// Computes final financial summary tuple
  static ({double subtotal, double discountAmount, double shippingFee, double grandTotal})
      computeInvoice(Order order) {
    final sub = order.subtotal;
    final discountPercent = calculateDiscountPercent(order);
    final discountAmount = sub * discountPercent;
    final shippingFee = calculateShipping(order);
    final grandTotal = (sub - discountAmount) + shippingFee;

    return (
      subtotal: sub,
      discountAmount: discountAmount,
      shippingFee: shippingFee,
      grandTotal: grandTotal,
    );
  }
}

void main() {
  print('=== E-COMMERCE PATTERN-BASED ORDER ENGINE ===\n');

  final order1 = Order(
    orderId: 'ORD_2026_01',
    customerTier: CustomerTier.gold,
    items: [
      (sku: 'MACBOOK_M4', quantity: 1, unitPrice: 2200.0),
      (sku: 'USB_C_HUB', quantity: 2, unitPrice: 50.0),
    ],
    deliveryMethod: ExpressDelivery(requiresColdChain: false),
    promoCode: null,
  );

  final invoice1 = PricingEngine.computeInvoice(order1);
  print('Invoice for Order #${order1.orderId}:');
  print('  Subtotal       : \$${invoice1.subtotal.toStringAsFixed(2)}');
  print('  Discount       : -\$${invoice1.discountAmount.toStringAsFixed(2)}');
  print('  Shipping Fee   : \$${invoice1.shippingFee.toStringAsFixed(2)}');
  print('  Grand Total    : \$${invoice1.grandTotal.toStringAsFixed(2)}\n');

  final order2 = Order(
    orderId: 'ORD_2026_02',
    customerTier: CustomerTier.standard,
    items: [
      (sku: 'INSULIN_MED', quantity: 3, unitPrice: 120.0),
    ],
    deliveryMethod: ExpressDelivery(requiresColdChain: true), // Cold chain
    promoCode: 'VIP99', // Promo override
  );

  final invoice2 = PricingEngine.computeInvoice(order2);
  print('Invoice for Order #${order2.orderId}:');
  print('  Subtotal       : \$${invoice2.subtotal.toStringAsFixed(2)}');
  print('  Discount       : -\$${invoice2.discountAmount.toStringAsFixed(2)}');
  print('  Shipping Fee   : \$${invoice2.shippingFee.toStringAsFixed(2)}');
  print('  Grand Total    : \$${invoice2.grandTotal.toStringAsFixed(2)}');
}
