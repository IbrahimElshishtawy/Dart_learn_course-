/// ==============================================================================
/// File: 02_intermediate_closures_lexical_scope.dart
/// Educational Objective: Master Lexical Scoping, understand how Closures capture
/// surrounding environment variables into the Heap, and implement state encapsulation
/// using factory functions without classes.
///
/// Execution:
///   dart run 02_intermediate_closures_lexical_scope.dart
/// ==============================================================================

// Global variable in top-level lexical scope
const String systemRegion = 'EMEA_NORTH';

/// Function generator demonstrating Lexical Closures
/// The returned function captures 'initialBalance' and 'accountHolder'
double Function(double depositAmount) createBankAccount(String accountHolder, double initialBalance) {
  // 'balance' is a local variable inside createBankAccount.
  // When this function finishes execution, its stack frame would normally be popped.
  // HOWEVER, because the returned inner anonymous closure captures 'balance',
  // the Dart VM moves 'balance' onto the Heap memory!
  double balance = initialBalance;

  return (double depositAmount) {
    if (depositAmount <= 0) {
      throw ArgumentError('Deposit amount must be positive');
    }
    balance += depositAmount;
    print('[$systemRegion] Account "$accountHolder" updated. New Balance: \$${balance.toStringAsFixed(2)}');
    return balance;
  };
}

void main() {
  print('=== STEP 1: Lexical Scope Resolution ===');
  String localScope = 'MAIN_LOCAL';

  void testInnerScope() {
    String innerScope = 'INNER_LOCAL';
    // Can access: innerScope (local), localScope (enclosing), systemRegion (global)
    print('Inside innerScope: $innerScope -> $localScope -> $systemRegion');
  }

  testInnerScope();

  print('\n=== STEP 2: Closures as Private State Containers ===');
  // Creating two completely independent closure environments
  final accountAli = createBankAccount('Ali Hassan', 1000.0);
  final accountMona = createBankAccount('Mona Zaki', 2500.0);

  // Each closure maintains its own private, isolated 'balance' reference on the Heap
  accountAli(250.0);  // Balance: 1250.00
  accountAli(500.0);  // Balance: 1750.00

  accountMona(100.0); // Balance: 2600.00
  accountAli(50.0);   // Balance: 1800.00 (Mona's updates did NOT interfere with Ali)

  print('\n=== STEP 3: Loop Variable Capture Semantics ===');
  // Proving Dart's modern per-iteration scope binding in for loops
  final actionList = <void Function()>[];

  for (int i = 0; i < 3; i++) {
    // In Dart, each loop iteration creates a fresh binding for variable 'i'
    actionList.add(() => print('Captured iteration value: $i'));
  }

  // Executing captured callbacks
  for (final action in actionList) {
    action(); // Prints 0, then 1, then 2 (Safe & Deterministic)
  }
}
