import 'package:test/test.dart';
import '../lib/engine/order_classifier.dart';
import '../lib/engine/pricing_engine.dart';
import '../lib/models/order_types.dart';

void main() {
  group('E-Commerce Pattern-Based Order Engine Tests', () {
    test('Calculates correct subtotal from order items', () {
      final order = Order(
        orderId: 'TEST_01',
        customerTier: CustomerTier.standard,
        items: [
          (sku: 'SKU_1', name: 'Item 1', quantity: 2, unitPrice: 100.0),
          (sku: 'SKU_2', name: 'Item 2', quantity: 3, unitPrice: 50.0),
        ],
        deliveryChannel: const StandardPostal(),
        createdAt: DateTime.now(),
      );

      expect(order.subtotal, equals(350.0));
    });

    test('Enterprise tier receives 25% discount and free shipping', () {
      final order = Order(
        orderId: 'TEST_02',
        customerTier: CustomerTier.enterprise,
        items: [
          (sku: 'SKU_3', name: 'Server', quantity: 1, unitPrice: 1000.0),
        ],
        deliveryChannel: const StandardPostal(),
        createdAt: DateTime.now(),
      );

      final invoice = PricingEngine.generateInvoice(order);
      expect(invoice.subtotal, equals(1000.0));
      expect(invoice.discountAmount, equals(250.0));
      expect(invoice.shippingCost, equals(0.0));
      expect(invoice.totalDue, equals(750.0));
    });

    test('Priority courier with refrigeration classifies as critical cold-chain', () {
      final order = Order(
        orderId: 'TEST_03',
        customerTier: CustomerTier.gold,
        items: [
          (sku: 'SKU_MED', name: 'Insulin', quantity: 1, unitPrice: 200.0),
        ],
        deliveryChannel: const PriorityCourier(requiresRefrigeration: true),
        createdAt: DateTime.now(),
      );

      final priority = OrderClassifier.classifyPriority(order);
      expect(priority, equals(FulfillmentPriority.criticalColdChain));
    });

    test('VIP_BLACK promo code overrides tier discount to 35%', () {
      final order = Order(
        orderId: 'TEST_04',
        customerTier: CustomerTier.standard, // Standard has 0% normal discount
        items: [
          (sku: 'SKU_VIP', name: 'Gadget', quantity: 1, unitPrice: 100.0),
        ],
        deliveryChannel: const StandardPostal(),
        promoCode: 'VIP_BLACK',
        createdAt: DateTime.now(),
      );

      final discountPercent = PricingEngine.evaluateDiscountMultiplier(order);
      expect(discountPercent, equals(0.35));
    });

    test('Webhook pattern matching successfully parses valid and unrecognized payloads', () {
      final valid = {
        'action': 'ORDER_PAID',
        'order': {'id': 'ORD_99', 'amount': 250.0},
      };
      final invalid = {'event': 'UNKNOWN'};

      expect(OrderClassifier.routeWebhook(valid), contains('ROUTE_TO_WAREHOUSE'));
      expect(OrderClassifier.routeWebhook(invalid), contains('DISCARD_EVENT'));
    });
  });
}
