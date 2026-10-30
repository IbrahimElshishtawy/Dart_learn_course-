import '../models/payment_request.dart';
import '../models/payment_result.dart';
import 'payment_gateway.dart';

class PaypalGateway implements PaymentGateway {
  @override
  final String id = 'paypal';

  @override
  final String displayName = 'PayPal Express';

  @override
  final List<String> supportedCurrencies = const ['USD', 'EUR', 'CAD', 'AUD'];

  @override
  bool canHandle(PaymentRequest request) {
    return request.isValid && supportedCurrencies.contains(request.currency);
  }

  @override
  PaymentResult process(PaymentRequest request) {
    return PaymentResult.success(
      orderId: request.orderId,
      gatewayProvider: displayName,
      transactionReference: 'PAYPAL-CAPTURED-${DateTime.now().microsecondsSinceEpoch}',
    );
  }
}
