import '../lib/models/transaction.dart';
import '../lib/services/transaction_validator.dart';

void main() {
  print('================================================================');
  print('  FINANCIAL TRANSACTION VALIDATOR CORE — SIMULATION SUITE');
  print('================================================================\n');

  final testCases = <Map<String, dynamic>>[
    {
      'title': 'Test Case 1: Standard Valid Peer-to-Peer Transfer',
      'tx': Transaction.create(
        id: 'TX_2026_EG_001',
        majorAmount: 3500.50,
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.transfer,
        clientIpAddress: '197.38.112.5',
        referenceNote: 'Freelance Software Engineering Milestone',
      ),
    },
    {
      'title': 'Test Case 2: High-Value Transfer Triggering AML Tier-2 Review',
      'tx': Transaction.create(
        id: 'TX_2026_EG_002',
        majorAmount: 750000.00, // 750,000 EGP >= 500,000 Threshold
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.payment,
        clientIpAddress: '156.204.88.19',
        referenceNote: 'Enterprise Cloud Infrastructure Annual Payment',
      ),
    },
    {
      'title': 'Test Case 3: Self-Loop Fraud Rejection',
      'tx': Transaction.create(
        id: 'TX_2026_EG_003',
        majorAmount: 1200.00,
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG120002000100000012345678901', // Identical!
        type: TransactionType.transfer,
        clientIpAddress: '10.0.0.1',
      ),
    },
    {
      'title': 'Test Case 4: Negative Amount & Malformed ID Rejection',
      'tx': Transaction.create(
        id: 'TX', // Less than 5 characters
        majorAmount: -250.00, // Negative amount
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.refund,
      ),
    },
    {
      'title': 'Test Case 5: Stale Transaction (> 24 Hours)',
      'tx': Transaction.create(
        id: 'TX_2026_EG_005',
        majorAmount: 500.00,
        currency: 'EGP',
        sourceIban: 'EG120002000100000012345678901',
        destinationIban: 'EG990002000100000098765432109',
        type: TransactionType.payment,
        timestamp: DateTime.now().subtract(const Duration(hours: 48)),
      ),
    },
  ];

  for (final testCase in testCases) {
    print('----------------------------------------------------------------');
    print('Executing: ${testCase['title']}');
    final tx = testCase['tx'] as Transaction;
    print('Payload: ID=${tx.id}, Amount=${tx.amount}, Source=${tx.sourceIban}');

    final result = TransactionValidator.validate(tx);
    print('Result: $result\n');
  }

  print('================================================================');
  print('  SIMULATION SUITE COMPLETED SUCCESSFULLY.');
  print('================================================================');
}
