import 'package:test/test.dart';
import '../lib/models/transaction.dart';
import '../lib/models/validation_result.dart';
import '../lib/services/transaction_validator.dart';

void main() {
  group('TransactionValidator Comprehensive Test Suite', () {
    test('Null transaction rejection', () {
      final result = TransactionValidator.validate(null);
      expect(result.status, equals(ValidationStatus.rejected));
      expect(result.rejectionReasons.first, contains('is null'));
    });

    test('Valid standard transaction passes audit', () {
      final tx = Transaction.create(
        id: 'TX_1001',
        majorAmount: 150.00,
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.transfer,
        clientIpAddress: '192.168.1.1',
      );

      final result = TransactionValidator.validate(tx);
      expect(result.isApproved, isTrue);
      expect(result.status, equals(ValidationStatus.approved));
      expect(result.rejectionReasons, isEmpty);
    });

    test('Rejects self-loop transfer (source equals destination)', () {
      final tx = Transaction.create(
        id: 'TX_1002',
        majorAmount: 50.00,
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG120002000100000012345678901',
        type: TransactionType.transfer,
      );

      final result = TransactionValidator.validate(tx);
      expect(result.isApproved, isFalse);
      expect(result.status, equals(ValidationStatus.rejected));
      expect(result.rejectionReasons.any((r) => r.contains('Self-loop')), isTrue);
    });

    test('Rejects zero and negative amounts', () {
      final zeroTx = Transaction.create(
        id: 'TX_1003',
        majorAmount: 0.0,
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.payment,
      );

      final result = TransactionValidator.validate(zeroTx);
      expect(result.isApproved, isFalse);
      expect(result.rejectionReasons.any((r) => r.contains('strictly positive')), isTrue);
    });

    test('Flags high-value transfers for manual review', () {
      final highValueTx = Transaction.create(
        id: 'TX_1004',
        majorAmount: 600000.0, // > 500,000 threshold
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.transfer,
        clientIpAddress: '197.33.2.1',
      );

      final result = TransactionValidator.validate(highValueTx);
      expect(result.status, equals(ValidationStatus.requiresManualReview));
      expect(result.rejectionReasons.any((r) => r.contains('Tier-2')), isTrue);
    });
  });
}
