/// Immutable payment transaction payload.
class PaymentRequest {
  final String orderId;
  final String customerEmail;
  final double amount;
  final String currency;
  final Map<String, String> metadata;

  const PaymentRequest({
    required this.orderId,
    required this.customerEmail,
    required this.amount,
    this.currency = 'USD',
    this.metadata = const {},
  });

  bool get isValid =>
      orderId.trim().isNotEmpty &&
      customerEmail.contains('@') &&
      amount > 0.0;
}
