/// Represents an immutable monetary value stored in minor currency units (cents/piasters)
/// to eliminate IEEE-754 floating-point drift and rounding errors.
class Money {
  final int minorUnits;
  final String currency;

  const Money._(this.minorUnits, this.currency);

  factory Money.fromMajor(double amount, {String currency = 'EGP'}) {
    if (amount.isNaN || amount.isInfinite) {
      throw ArgumentError.value(amount, 'amount', 'Monetary amount must be a finite number');
    }
    final units = (amount * 100).round();
    return Money._(units, currency.toUpperCase());
  }

  const Money.zero({String currency = 'EGP'}) : minorUnits = 0, currency = currency;

  double toMajor() => minorUnits / 100.0;

  bool get isPositive => minorUnits > 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money &&
          runtimeType == other.runtimeType &&
          minorUnits == other.minorUnits &&
          currency == other.currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);

  @override
  String toString() => '${toMajor().toStringAsFixed(2)} $currency';
}

/// Transaction type classification
enum TransactionType { transfer, payment, refund, deposit }

/// Core Immutable Financial Transaction Entity
class Transaction {
  final String id;
  final Money amount;
  final String sourceIban;
  final String destinationIban;
  final TransactionType type;
  final DateTime timestamp;
  final String? clientIpAddress;
  final String? referenceNote;

  const Transaction({
    required this.id,
    required this.amount,
    required this.sourceIban,
    required this.destinationIban,
    required this.type,
    required this.timestamp,
    this.clientIpAddress,
    this.referenceNote,
  });

  /// Factory constructor to safely construct and normalize raw input data
  factory Transaction.create({
    required String id,
    required double majorAmount,
    required String currency,
    required String sourceIban,
    required String destinationIban,
    required TransactionType type,
    DateTime? timestamp,
    String? clientIpAddress,
    String? referenceNote,
  }) {
    return Transaction(
      id: id.trim(),
      amount: Money.fromMajor(majorAmount, currency: currency),
      sourceIban: sourceIban.replaceAll(' ', '').toUpperCase(),
      destinationIban: destinationIban.replaceAll(' ', '').toUpperCase(),
      type: type,
      timestamp: timestamp ?? DateTime.now(),
      clientIpAddress: clientIpAddress?.trim(),
      referenceNote: referenceNote?.trim(),
    );
  }

  @override
  String toString() => 'Transaction(id: $id, amount: $amount, type: $type)';
}
