import '../models/order_types.dart';

enum FulfillmentPriority { low, normal, express, criticalColdChain }

/// Order Classification & Routing Service
class OrderClassifier {
  /// Determines fulfillment routing using Object Pattern Matching
  static FulfillmentPriority classifyPriority(Order order) {
    return switch (order.deliveryChannel) {
      PriorityCourier(requiresRefrigeration: true) => FulfillmentPriority.criticalColdChain,
      PriorityCourier() => FulfillmentPriority.express,
      StandardPostal() when order.customerTier == CustomerTier.enterprise =>
        FulfillmentPriority.express,
      StandardPostal() => FulfillmentPriority.normal,
      InternationalAirFreight() => FulfillmentPriority.express,
    };
  }

  /// Parses and routes incoming webhook payload map using Map Pattern Matching
  static String routeWebhook(Map<String, dynamic> rawPayload) {
    return switch (rawPayload) {
      {
        'action': 'ORDER_PAID',
        'order': {
          'id': String id,
          'amount': num total,
        }
      } => 'ROUTE_TO_WAREHOUSE: Order #$id initialized for shipment (Total: \$$total)',

      {
        'action': 'ORDER_CANCELLED',
        'order': {'id': String id},
        'reason': String note,
      } => 'RELEASE_INVENTORY: Order #$id aborted. Reason: $note',

      _ => 'DISCARD_EVENT: Unmatched payload format',
    };
  }
}
