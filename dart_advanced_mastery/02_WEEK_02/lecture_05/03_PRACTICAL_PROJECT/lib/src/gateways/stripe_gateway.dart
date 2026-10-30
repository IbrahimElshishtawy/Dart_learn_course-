import '../models/payment_request.dart';
import '../models/payment_result.dart';
import 'payment_gateway.dart';

class StripeGateway implements PaymentGateway {
  @override
  final String id = 'stripe';

  @override
  final String displayName = 'Stripe Credit Cards';

  @override
  final List<String> supportedCurrencies = const ['USD', 'EUR', 'GBP'];

  @override
  bool canHandle(PaymentRequest request) {
    return request.isValid && supportedCurrencies.contains(request.currency);
  }

  @override
  PaymentResult process(PaymentRequest request) {
    if (request.amount < 0.50) {
      return PaymentResult.failure(
        orderId: request.orderId,
        gatewayProvider: displayName,
        errorMessage: 'Amount below Stripe minimum transaction limit (\$0.50)',
      );
    }

    return PaymentResult.success(
      orderId: request.orderId,
      gatewayProvider: displayName,
      transactionReference: 'pi_stripe_${request.orderId}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
