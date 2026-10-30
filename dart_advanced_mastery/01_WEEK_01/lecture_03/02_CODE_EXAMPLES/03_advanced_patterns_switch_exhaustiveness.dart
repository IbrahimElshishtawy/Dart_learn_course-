/// ==============================================================================
/// File: 03_advanced_patterns_switch_exhaustiveness.dart
/// Educational Objective: Master Dart 3 Pattern Matching, Switch Expressions,
/// Relational Patterns, Guard Clauses (`when`), and Sealed Class Exhaustiveness.
///
/// Execution:
///   dart run 03_advanced_patterns_switch_exhaustiveness.dart
/// ==============================================================================

// Sealed class hierarchy representing payment state machine
sealed class PaymentState {}

class PaymentPending extends PaymentState {
  final double amount;
  PaymentPending(this.amount);
}

class PaymentProcessing extends PaymentState {
  final String gatewayReference;
  PaymentProcessing(this.gatewayReference);
}

class PaymentSuccess extends PaymentState {
  final String transactionId;
  final double settledAmount;
  PaymentSuccess(this.transactionId, this.settledAmount);
}

class PaymentFailed extends PaymentState {
  final String errorCode;
  final String message;
  PaymentFailed(this.errorCode, this.message);
}

void main() {
  print('=== STEP 1: Relational & Logical Patterns with Guard Clauses ===');

  String classifyRisk(int score, {required bool isVipCustomer}) {
    // Switch Expression with pattern matching and 'when' guards
    return switch (score) {
      < 0 || > 100 => 'INVALID_RANGE',
      >= 80 when isVipCustomer => 'VIP_EXPEDITED_CLEARANCE',
      >= 80 => 'LOW_RISK_APPROVED',
      >= 50 && < 80 => 'MEDIUM_RISK_REVIEW',
      _ => 'HIGH_RISK_REJECTED',
    };
  }

  print('Score 95 (VIP) : ${classifyRisk(95, isVipCustomer: true)}');
  print('Score 95 (User): ${classifyRisk(95, isVipCustomer: false)}');
  print('Score 65       : ${classifyRisk(65, isVipCustomer: false)}');
  print('Score 30       : ${classifyRisk(30, isVipCustomer: false)}');

  print('\n=== STEP 2: List Pattern Destructuring and Rest Elements ===');
  void analyzeLogMessage(List<String> tokens) {
    // Matching list structure: head, middle, tail
    switch (tokens) {
      case ['ERROR', final code, ...final details]:
        print('LOG ERROR detected! Code: $code, Extra Details: $details');
      case ['WARN', final message]:
        print('LOG WARNING: $message');
      case ['INFO', ...]:
        print('Standard informational telemetry.');
      case []:
        print('Empty log buffer.');
      default:
        print('Unrecognized log format: $tokens');
    }
  }

  analyzeLogMessage(['ERROR', '503_SERVICE_UNAVAILABLE', 'Gateway timed out', 'Retry in 5s']);
  analyzeLogMessage(['WARN', 'Memory threshold exceeded 80%']);
  analyzeLogMessage(['INFO', 'User 102 logged in']);

  print('\n=== STEP 3: Exhaustive Matching on Sealed Classes ===');
  // The Dart compiler mathematically PROVES every subtype of PaymentState is covered.
  // If you omit PaymentFailed, the code WILL NOT COMPILE!
  String evaluateState(PaymentState state) {
    return switch (state) {
      PaymentPending(:final amount) => 'Pending settlement for \$$amount',
      PaymentProcessing(:final gatewayReference) => 'Processing with Gateway: $gatewayReference',
      PaymentSuccess(:final transactionId, :final settledAmount) =>
        'Payment SUCCESS! Tx: $transactionId, Amount: \$$settledAmount',
      PaymentFailed(:final errorCode, :final message) =>
        'Payment REJECTED [$errorCode]: $message',
    };
  }

  print(evaluateState(PaymentPending(1250.0)));
  print(evaluateState(PaymentSuccess('TX_77610', 1250.0)));
  print(evaluateState(PaymentFailed('INSUFFICIENT_FUNDS', 'Card balance is negative')));
}
