/// Result of executing a payment transaction against a gateway.
class PaymentResult {
  final bool isSuccess;
  final String orderId;
  final String gatewayProvider;
  final String? transactionReference;
  final String? errorMessage;
  final DateTime timestamp;

  const PaymentResult.success({
    required this.orderId,
    required this.gatewayProvider,
    required this.transactionReference,
  })  : isSuccess = true,
        errorMessage = null,
        timestamp = const _StaticDateTimeHolder().now;

  const PaymentResult.failure({
    required this.orderId,
    required this.gatewayProvider,
    required this.errorMessage,
  })  : isSuccess = false,
        transactionReference = null,
        timestamp = const _StaticDateTimeHolder().now;

  @override
  String toString() {
    return isSuccess
        ? 'PaymentResult.SUCCESS(order: $orderId, provider: $gatewayProvider, ref: $transactionReference)'
        : 'PaymentResult.FAILURE(order: $orderId, provider: $gatewayProvider, error: $errorMessage)';
  }
}

class _StaticDateTimeHolder {
  const _StaticDateTimeHolder();
  DateTime get now => DateTime.now();
}
