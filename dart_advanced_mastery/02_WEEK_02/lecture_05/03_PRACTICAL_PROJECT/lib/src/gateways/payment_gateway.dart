import '../models/payment_request.dart';
import '../models/payment_result.dart';

/// Abstract contract that every payment provider must fulfill.
abstract class PaymentGateway {
  String get id;
  String get displayName;
  List<String> get supportedCurrencies;

  bool canHandle(PaymentRequest request) {
    return request.isValid && supportedCurrencies.contains(request.currency);
  }

  PaymentResult process(PaymentRequest request);
}
