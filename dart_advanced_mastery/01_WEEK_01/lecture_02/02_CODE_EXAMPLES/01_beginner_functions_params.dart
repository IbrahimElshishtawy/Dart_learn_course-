/// ==============================================================================
/// File: 01_beginner_functions_params.dart
/// Educational Objective: Master all forms of function parameters in Dart:
/// required positional, optional positional `[]`, named parameters `{}`,
/// default values, and strict compile-time null safety interactions.
///
/// Execution:
///   dart run 01_beginner_functions_params.dart
/// ==============================================================================

// 1. Mandatory Positional Parameters
double calculateSimpleInterest(double principal, double rate, int years) {
  return principal * rate * years;
}

// 2. Optional Positional Parameters enclosed in square brackets []
String formatUserProfile(String username, [String? country, int age = 18]) {
  final resolvedCountry = country ?? 'GLOBAL';
  return 'User: $username | Country: $resolvedCountry | Age: $age';
}

// 3. Named Parameters enclosed in curly braces {}
// In Dart, named parameters are optional by default unless marked with 'required'.
void dispatchNotification({
  required String recipient,
  required String message,
  String channel = 'EMAIL', // Default fallback
  int priority = 1,
  DateTime? scheduledAt, // Nullable optional
}) {
  print('[$channel - Priority $priority] Sending to $recipient: "$message" (Scheduled: ${scheduledAt ?? "IMMEDIATE"})');
}

void main() {
  print('=== STEP 1: Mandatory Positional Parameters ===');
  final interest = calculateSimpleInterest(10000.0, 0.05, 3);
  print('Calculated Interest: \$$interest');

  print('\n=== STEP 2: Optional Positional Parameters ===');
  // Omitting all optional parameters
  print(formatUserProfile('m_fathy'));
  // Providing the first optional parameter
  print(formatUserProfile('s_hamdy', 'EGYPT'));
  // Providing all optional parameters
  print(formatUserProfile('k_nour', 'UAE', 32));

  print('\n=== STEP 3: Named Parameters with Self-Documenting Call Sites ===');
  dispatchNotification(
    recipient: 'architect@enterprise.io',
    message: 'System upgrade completed without downtime.',
    channel: 'SLACK',
    priority: 5,
  );

  dispatchNotification(
    recipient: 'client@domain.com',
    message: 'Monthly bank statement ready for download.',
    // channel and priority take their defaults
    scheduledAt: DateTime.now().add(const Duration(hours: 2)),
  );
}

/*
================================================================================
TECHNICAL BREAKDOWN & PEDAGOGICAL NOTES
================================================================================
1. Positional vs Named:
   - Positional parameters cannot be skipped: you cannot supply the 3rd parameter without the 2nd.
   - Named parameters offer complete invocation flexibility and enhance readability at call sites.

2. Null Safety Rules for Named Parameters:
   - Must be either:
     a) Marked with `required` (e.g., `required String recipient`).
     b) Declared nullable with `?` (e.g., `DateTime? scheduledAt`).
     c) Provided with a compile-time constant default value (e.g., `String channel = 'EMAIL'`).
================================================================================
*/
