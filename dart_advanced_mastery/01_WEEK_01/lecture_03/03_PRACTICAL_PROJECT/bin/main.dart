import '../lib/engine/order_classifier.dart';
import '../lib/engine/pricing_engine.dart';
import '../lib/models/order_types.dart';

void main() {
  print('================================================================');
  print('  E-COMMERCE PATTERN-BASED ORDER ENGINE — SIMULATION');
  print('================================================================\n');

  final orders = <Order>[
    Order(
      orderId: 'ORD_EG_1001',
      customerTier: CustomerTier.enterprise,
      items: [
        (sku: 'SERVER_BLADE_R740', name: 'Dell Enterprise Blade', quantity: 2, unitPrice: 3200.0),
        (sku: 'SFP_PLUS_OPTIC', name: '10GbE Optical Transceiver', quantity: 8, unitPrice: 85.0),
      ],
      deliveryChannel: StandardPostal(), // Should get free shipping due to Enterprise
      createdAt: DateTime.now(),
    ),
    Order(
      orderId: 'ORD_EG_1002',
      customerTier: CustomerTier.gold,
      items: [
        (sku: 'VACCINE_VIAL_COVID', name: 'mRNA Vaccine 10-pack', quantity: 5, unitPrice: 150.0),
      ],
      deliveryChannel: PriorityCourier(requiresRefrigeration: true),
      promoCode: 'SALE10',
      createdAt: DateTime.now(),
    ),
    Order(
      orderId: 'ORD_EG_1003',
      customerTier: CustomerTier.standard,
      items: [
        (sku: 'BOOK_DART_INTERNALS', name: 'Dart VM Deep Dive', quantity: 1, unitPrice: 65.0),
      ],
      deliveryChannel: InternationalAirFreight(
        destinationCountry: 'EGYPT',
        customsTariffRate: 0.05, // 5% customs
      ),
      promoCode: 'VIP_BLACK', // VIP Override discount!
      createdAt: DateTime.now(),
    ),
  ];

  for (final order in orders) {
    print('----------------------------------------------------------------');
    print('Processing Order #${order.orderId} | Tier: ${order.customerTier.name.toUpperCase()}');

    final invoice = PricingEngine.generateInvoice(order);
    final priority = OrderClassifier.classifyPriority(order);

    print('  Items Count       : ${order.items.length}');
    print('  Subtotal          : \$${invoice.subtotal.toStringAsFixed(2)}');
    print('  Discount Amount   : -\$${invoice.discountAmount.toStringAsFixed(2)}');
    print('  Shipping Cost     : \$${invoice.shippingCost.toStringAsFixed(2)}');
    print('  Total Due         : \$${invoice.totalDue.toStringAsFixed(2)}');
    print('  Fulfillment Route : ${priority.name.toUpperCase()}\n');
  }

  print('=== TESTING WEBHOOK EVENT ROUTING VIA MAP PATTERNS ===');
  final webhook1 = {
    'action': 'ORDER_PAID',
    'order': {'id': 'ORD_EG_1001', 'amount': 7080.00},
  };
  final webhook2 = {
    'action': 'ORDER_CANCELLED',
    'order': {'id': 'ORD_EG_1002'},
    'reason': 'Customer requested refund before cold-chain dispatch',
  };

  print(OrderClassifier.routeWebhook(webhook1));
  print(OrderClassifier.routeWebhook(webhook2));
}
