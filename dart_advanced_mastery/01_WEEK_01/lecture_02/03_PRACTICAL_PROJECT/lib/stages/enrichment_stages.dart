/// Value object encapsulating enriched transaction output
class EnrichedTransaction {
  final int rawAmount;
  final double vatAmount;
  final double grandTotal;
  final String checksumHash;

  const EnrichedTransaction({
    required this.rawAmount,
    required this.vatAmount,
    required this.grandTotal,
    required this.checksumHash,
  });

  @override
  String toString() =>
      'EnrichedTransaction(raw: $rawAmount, vat: $vatAmount, total: $grandTotal, hash: $checksumHash)';
}

/// Pure enrichment stages
class EnrichmentStages {
  /// Closure factory: Generates a VAT calculation stage with enclosed tax percentage
  static double Function(int amount) createVatCalculator(double taxPercent) {
    return (int amount) => (amount * (taxPercent / 100.0));
  }

  /// Packages raw amount and computed VAT into a structured business entity
  static EnrichedTransaction packageTransaction({
    required int amount,
    required double vat,
  }) {
    final grandTotal = amount + vat;
    final hash = (amount ^ vat.toInt()).toRadixString(16);
    return EnrichedTransaction(
      rawAmount: amount,
      vatAmount: vat,
      grandTotal: grandTotal,
      checksumHash: '0x$hash',
    );
  }
}
