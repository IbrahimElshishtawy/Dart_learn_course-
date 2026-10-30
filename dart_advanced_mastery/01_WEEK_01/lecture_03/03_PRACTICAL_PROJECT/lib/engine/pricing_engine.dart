import '../models/order_types.dart';

/// Financial Breakdown Result Record
typedef InvoiceRecord = ({
  double subtotal,
  double discountAmount,
  double shippingCost,
  double totalDue,
});

/// Pattern-Based Pricing Engine
class PricingEngine {
  /// Evaluates discount multiplier using Record Pattern Matching and Guard Clauses
  static double evaluateDiscountMultiplier(Order order) {
    return switch ((order.customerTier, order.promoCode)) {
      (_, 'VIP_BLACK') => 0.35, // 35% Global VIP Override
      (CustomerTier.enterprise, _) => 0.25,
      (CustomerTier.gold, 'SALE10') => 0.20,
      (CustomerTier.gold, _) => 0.15,
      (CustomerTier.silver, _) => 0.08,
      (CustomerTier.standard, 'WELCOME5') => 0.05,
      _ => 0.0,
    };
  }

  /// Calculates shipping fee using Exhaustive Pattern Matching on DeliveryChannel
  static double calculateShipping(Order order) {
    final subtotal = order.subtotal;

    return switch ((order.deliveryChannel, order.customerTier, subtotal)) {
      // Free shipping for Enterprise tier or subtotal >= $3000
      (_, CustomerTier.enterprise, _) || (_, _, >= 3000.0) => 0.0,

      // Standard Postal Delivery
      (StandardPostal(), CustomerTier.gold, _) => 15.0,
      (StandardPostal(), _, _) => 30.0,

      // Priority Courier Delivery
      (PriorityCourier(requiresRefrigeration: true), _, _) => 150.0,
      (PriorityCourier(requiresRefrigeration: false), CustomerTier.gold, _) => 45.0,
      (PriorityCourier(requiresRefrigeration: false), _, _) => 75.0,

      // International Air Freight
      (InternationalAirFreight(:final destinationCountry, :final customsTariffRate), _, _)
          when destinationCountry == 'EGYPT' || destinationCountry == 'SAUDI_ARABIA' =>
        200.0 + (subtotal * customsTariffRate),

      (InternationalAirFreight(:final customsTariffRate), _, _) =>
        350.0 + (subtotal * customsTariffRate),
    };
  }

  /// Compiles comprehensive invoice
  static InvoiceRecord generateInvoice(Order order) {
    final sub = order.subtotal;
    final discountMultiplier = evaluateDiscountMultiplier(order);
    final discount = sub * discountMultiplier;
    final shipping = calculateShipping(order);
    final total = (sub - discount) + shipping;

    return (
      subtotal: sub,
      discountAmount: discount,
      shippingCost: shipping,
      totalDue: total,
    );
  }
}
