import '../models/payment_request.dart';
import '../models/payment_result.dart';
import 'payment_gateway.dart';

class FawryGateway implements PaymentGateway {
  @override
  final String id = 'fawry';

  @override
  final String displayName = 'Fawry Pay Egypt';

  @override
  final List<String> supportedCurrencies = const ['EGP'];

  @override
  bool canHandle(PaymentRequest request) {
    return request.isValid && supportedCurrencies.contains(request.currency);
  }

  @override
  PaymentResult process(PaymentRequest request) {
    if (request.currency != 'EGP') {
      return PaymentResult.failure(
        orderId: request.orderId,
        gatewayProvider: displayName,
        errorMessage: 'فوري تقبل فقط المعاملات بالجنيه المصري (EGP)',
      );
    }

    return PaymentResult.success(
      orderId: request.orderId,
      gatewayProvider: displayName,
      transactionReference: 'FAWRY-REF-${request.orderId}-${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
