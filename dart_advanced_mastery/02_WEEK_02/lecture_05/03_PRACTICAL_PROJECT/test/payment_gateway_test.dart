import 'package:test/test.dart';
import 'package:modular_payment_gateway/modular_payment_gateway.dart';

void main() {
  group('PaymentRequest Validation Tests', () {
    test('Valid request passes checks', () {
      const req = PaymentRequest(
        orderId: 'ORD-1',
        customerEmail: 'user@test.com',
        amount: 25.0,
      );
      expect(req.isValid, isTrue);
    });

    test('Invalid email fails check', () {
      const req = PaymentRequest(
        orderId: 'ORD-2',
        customerEmail: 'not-an-email',
        amount: 25.0,
      );
      expect(req.isValid, isFalse);
    });

    test('Negative or zero amount fails check', () {
      const req = PaymentRequest(
        orderId: 'ORD-3',
        customerEmail: 'user@test.com',
        amount: 0.0,
      );
      expect(req.isValid, isFalse);
    });
  });

  group('PaymentRouter Routing Tests', () {
    late PaymentRouter router;

    setUp(() {
      router = PaymentRouter([
        StripeGateway(),
        PaypalGateway(),
        FawryGateway(),
      ]);
    });

    test('Routes EGP to Fawry', () {
      const req = PaymentRequest(
        orderId: 'ORD-EGP-1',
        customerEmail: 'user@cairo.com',
        amount: 500.0,
        currency: 'EGP',
      );
      final result = router.routeAndProcess(req);
      expect(result.isSuccess, isTrue);
      expect(result.gatewayProvider, contains('Fawry'));
    });

    test('Routes USD to Stripe automatically', () {
      const req = PaymentRequest(
        orderId: 'ORD-USD-1',
        customerEmail: 'user@ny.com',
        amount: 45.0,
        currency: 'USD',
      );
      final result = router.routeAndProcess(req);
      expect(result.isSuccess, isTrue);
      expect(result.gatewayProvider, contains('Stripe'));
    });

    test('Honors preferredGatewayId for PayPal', () {
      const req = PaymentRequest(
        orderId: 'ORD-USD-2',
        customerEmail: 'user@paypal.com',
        amount: 99.0,
        currency: 'USD',
      );
      final result = router.routeAndProcess(req, preferredGatewayId: 'paypal');
      expect(result.isSuccess, isTrue);
      expect(result.gatewayProvider, contains('PayPal'));
    });

    test('Gracefully fails for unsupported currency', () {
      const req = PaymentRequest(
        orderId: 'ORD-JPY-1',
        customerEmail: 'user@tokyo.jp',
        amount: 5000.0,
        currency: 'JPY',
      );
      final result = router.routeAndProcess(req);
      expect(result.isSuccess, isFalse);
      expect(result.errorMessage, contains('No registered gateway can handle currency "JPY"'));
    });
  });
}
