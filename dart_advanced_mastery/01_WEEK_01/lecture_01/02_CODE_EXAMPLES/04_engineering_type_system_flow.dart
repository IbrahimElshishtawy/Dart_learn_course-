/// ==============================================================================
/// File: 04_engineering_type_system_flow.dart
/// Educational Objective: Master Dart's `Never` bottom-type semantics, advanced
/// flow analysis with definite assignments, and architect a robust industrial-grade
/// Financial Transaction Validation model.
///
/// Execution:
///   dart run 04_engineering_type_system_flow.dart
/// ==============================================================================

/// Custom Domain Exception
class SecurityViolationException implements Exception {
  final String message;
  final DateTime timestamp;

  SecurityViolationException(this.message) : timestamp = DateTime.now();

  @override
  String toString() => '[$timestamp] SecurityViolationException: $message';
}

/// A function returning `Never` CANNOT return a value under any circumstances.
/// It either throws an exception or enters an infinite loop.
/// The Dart compiler uses this for Dead Code Detection and definite assignment.
Never abortWithSecurityBreach(String breachDetails) {
  throw SecurityViolationException(breachDetails);
}

/// Financial Transaction Entity
class FinancialTransaction {
  final String transactionId;
  final double amount;
  final String sourceIban;
  final String targetIban;
  final String? ipAddress;

  const FinancialTransaction({
    required this.transactionId,
    required this.amount,
    required this.sourceIban,
    required this.targetIban,
    this.ipAddress,
  });
}

/// Industrial-Grade Validator using Flow Analysis and Type Promotion
class TransactionAuditor {
  /// Validates and sanitizes a raw transaction payload
  static void auditTransaction(FinancialTransaction? tx) {
    print('Auditing transaction: ${tx?.transactionId} ...');

    // 1. Guard against null transaction
    if (tx == null) {
      abortWithSecurityBreach('Transaction payload is completely null');
    }

    // Notice: Due to abortWithSecurityBreach returning 'Never',
    // the Dart flow analyzer PROVES that 'tx' can never be null past this line!
    // 'tx' is promoted from FinancialTransaction? to FinancialTransaction.

    if (tx.amount <= 0.0) {
      abortWithSecurityBreach('Transaction amount must be strictly positive: ${tx.amount}');
    }

    if (tx.sourceIban == tx.targetIban) {
      abortWithSecurityBreach('Source and destination IBANs cannot be identical: ${tx.sourceIban}');
    }

    // IP Address validation with localized type promotion
    final String verifiedIp;
    if (tx.ipAddress != null && tx.ipAddress!.trim().isNotEmpty) {
      verifiedIp = tx.ipAddress!;
    } else {
      verifiedIp = '0.0.0.0 (SYSTEM_INTERNAL)';
    }

    print('>> AUDIT PASSED: Transaction ${tx.transactionId} for \$${tx.amount.toStringAsFixed(2)} verified from IP: $verifiedIp');
  }
}

void main() {
  print('=== STEP 1: Testing Successful Valid Transaction ===');
  const validTx = FinancialTransaction(
    transactionId: 'TX_EG_9812401',
    amount: 15450.75,
    sourceIban: 'EG120002000100000012345678901',
    targetIban: 'EG990002000100000098765432109',
    ipAddress: '197.34.120.15',
  );

  TransactionAuditor.auditTransaction(validTx);

  print('\n=== STEP 2: Testing Zero/Negative Amount Violation ===');
  const invalidAmountTx = FinancialTransaction(
    transactionId: 'TX_EG_ZERO_AMT',
    amount: -50.0,
    sourceIban: 'EG120002000100000012345678901',
    targetIban: 'EG990002000100000098765432109',
  );

  try {
    TransactionAuditor.auditTransaction(invalidAmountTx);
  } on SecurityViolationException catch (e) {
    print('CAUGHT EXPECTED AUDIT REJECTION: $e');
  }

  print('\n=== STEP 3: Testing Same-Account Fraud Attempt ===');
  const fraudTx = FinancialTransaction(
    transactionId: 'TX_EG_SELF_LOOP',
    amount: 1000.0,
    sourceIban: 'EG120002000100000012345678901',
    targetIban: 'EG120002000100000012345678901', // Identical!
  );

  try {
    TransactionAuditor.auditTransaction(fraudTx);
  } on SecurityViolationException catch (e) {
    print('CAUGHT EXPECTED AUDIT REJECTION: $e');
  }

  print('\n=== STEP 4: Demonstrating Compiler Dead-Code Knowledge with Never ===');
  demonstrateCompilerDeadCode();
}

void demonstrateCompilerDeadCode() {
  bool simulateCriticalAlert = true;

  if (simulateCriticalAlert) {
    print('Demonstrating Never: Calling abort function...');
    try {
      abortWithSecurityBreach('Critical infrastructure alert triggered');
      // Any code here would be flagged by the compiler as unreachable!
    } on SecurityViolationException catch (e) {
      print('Caught: $e');
    }
  }
}

/*
================================================================================
ENGINEERING RATIONALE & BEST PRACTICES
================================================================================
1. The Bottom Type `Never`:
   - In type theory, `Never` has no values. No variable can ever hold an instance of `Never`.
   - When a function's return type is `Never`, it tells the compiler's control-flow graph
     that execution halts right there.
   - This empowers the compiler to promote types in the enclosing function without requiring
     an explicit `else` or `return` block.

2. Definite Assignment:
   - Dart verifies that non-nullable local variables are assigned along all execution paths
     before they are read.
   - Notice how `verifiedIp` in `auditTransaction` is declared without an initializer (`final String verifiedIp;`)
     and assigned on both `if` and `else` branches. The compiler guarantees it is initialized exactly once.
================================================================================
*/
