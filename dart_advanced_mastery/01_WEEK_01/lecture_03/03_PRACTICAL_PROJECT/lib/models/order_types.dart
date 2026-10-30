/// Order line item modeled as a concise, immutable Record
typedef OrderLineItem = ({String sku, String name, int quantity, double unitPrice});

/// Customer fidelity tiers
enum CustomerTier { standard, silver, gold, enterprise }

/// Sealed Delivery Channel hierarchy
sealed class DeliveryChannel {
  const DeliveryChannel();
}

class StandardPostal extends DeliveryChannel {
  const StandardPostal();
}

class PriorityCourier extends DeliveryChannel {
  final bool requiresRefrigeration;
  const PriorityCourier({this.requiresRefrigeration = false});
}

class InternationalAirFreight extends DeliveryChannel {
  final String destinationCountry;
  final double customsTariffRate;
  const InternationalAirFreight({
    required this.destinationCountry,
    required this.customsTariffRate,
  });
}

/// Core Order Entity utilizing Records and Sealed Classes
class Order {
  final String orderId;
  final CustomerTier customerTier;
  final List<OrderLineItem> items;
  final DeliveryChannel deliveryChannel;
  final String? promoCode;
  final DateTime createdAt;

  const Order({
    required this.orderId,
    required this.customerTier,
    required this.items,
    required this.deliveryChannel,
    this.promoCode,
    required this.createdAt,
  });

  /// Pre-discount subtotal calculated from items
  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + (item.quantity * item.unitPrice));
}
