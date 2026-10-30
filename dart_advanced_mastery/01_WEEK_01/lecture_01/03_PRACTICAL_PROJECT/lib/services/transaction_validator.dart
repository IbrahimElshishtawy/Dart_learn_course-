import '../models/transaction.dart';
import '../models/validation_result.dart';

/// Enterprise Core Financial Transaction Validator
/// Implements strict flow analysis, guaranteed null safety, and security heuristics.
class TransactionValidator {
  // Upper threshold for instant automated approval (e.g. 500,000 EGP)
  static const int maxAutomatedApprovalMinorUnits = 50000000; // 500,000.00
  static const int maximumPermissibleSingleTransaction = 200000000; // 2,000,000.00

  /// Validates a transaction through sequential security stages
  static ValidationResult validate(Transaction? transaction) {
    // Stage 1: Null check using flow analysis
    if (transaction == null) {
      return ValidationResult.rejected(
        ['Critical Security Rejection: Transaction object is null.'],
        riskScore: 'CRITICAL',
      );
    }

    final errors = <String>[];
    final warnings = <String>[];

    // Stage 2: Transaction ID format
    if (transaction.id.isEmpty || transaction.id.length < 5) {
      errors.add('Malformed or missing transaction ID: "${transaction.id}".');
    }

    // Stage 3: Amount Validation
    if (!transaction.amount.isPositive) {
      errors.add('Transaction amount must be strictly positive: ${transaction.amount}.');
    }

    if (transaction.amount.minorUnits > maximumPermissibleSingleTransaction) {
      errors.add(
        'Transaction amount (${transaction.amount}) exceeds regulatory single-transfer ceiling (${maximumPermissibleSingleTransaction / 100}).',
      );
    }

    // Stage 4: IBAN Rules
    _validateIbans(
      sourceIban: transaction.sourceIban,
      destinationIban: transaction.destinationIban,
      errors: errors,
    );

    // Stage 5: Timestamp Freshness (prevent replay attacks older than 24 hours or in the future)
    final now = DateTime.now();
    final difference = now.difference(transaction.timestamp);
    if (difference.inHours > 24) {
      errors.add('Transaction timestamp is stale (older than 24 hours).');
    } else if (transaction.timestamp.isAfter(now.add(const Duration(minutes: 5)))) {
      errors.add('Transaction timestamp is in the future (clock drift violation).');
    }

    // Stage 6: AML & Suspicious Pattern Warnings (Anti-Money Laundering)
    if (transaction.amount.minorUnits >= maxAutomatedApprovalMinorUnits) {
      warnings.add(
        'High-value transfer (${transaction.amount}) requires Tier-2 manual authorization.',
      );
    }

    if (transaction.clientIpAddress == null || transaction.clientIpAddress!.isEmpty) {
      warnings.add('Client IP address missing from metadata audit trail.');
    }

    // Stage 7: Outcome Evaluation
    if (errors.isNotEmpty) {
      return ValidationResult.rejected(errors, riskScore: 'HIGH_RISK');
    }

    if (warnings.isNotEmpty) {
      return ValidationResult.requiresManualReview(warnings);
    }

    return ValidationResult.approved();
  }

  /// Internal helper validating IBAN structure and sanity
  static void _validateIbans({
    required String sourceIban,
    required String destinationIban,
    required List<String> errors,
  }) {
    if (sourceIban.isEmpty) {
      errors.add('Source IBAN cannot be empty.');
    } else if (sourceIban.length < 15 || sourceIban.length > 34) {
      errors.add('Source IBAN length (${sourceIban.length}) violates ISO-13616 standards.');
    }

    if (destinationIban.isEmpty) {
      errors.add('Destination IBAN cannot be empty.');
    } else if (destinationIban.length < 15 || destinationIban.length > 34) {
      errors.add('Destination IBAN length (${destinationIban.length}) violates ISO-13616 standards.');
    }

    if (sourceIban.isNotEmpty && sourceIban == destinationIban) {
      errors.add('Self-loop transaction detected: Source and Destination IBANs are identical.');
    }
  }
}
