/// ==============================================================================
/// File: 02_intermediate_sound_null_safety.dart
/// Educational Objective: Master Dart's Sound Null Safety, Flow Analysis,
/// Type Promotion, and Null-Aware operators (`?.`, `??`, `??=`).
///
/// Execution:
///   dart run 02_intermediate_sound_null_safety.dart
/// ==============================================================================

class CustomerProfile {
  final String id;
  final String fullName;
  final String? secondaryEmail; // Explicitly nullable: may or may not exist
  final int? loyaltyPoints;

  const CustomerProfile({
    required this.id,
    required this.fullName,
    this.secondaryEmail,
    this.loyaltyPoints,
  });
}

void main() {
  print('=== STEP 1: Non-Nullable by Default ===');
  // In Dart, variables cannot be null unless explicitly annotated with '?'
  String primaryEmail = 'eng.ibrahim@example.com';
  // primaryEmail = null; // COMPILE ERROR: The value 'null' cannot be assigned to a variable of type 'String'.
  print('Guaranteed non-null primary email: $primaryEmail');

  print('\n=== STEP 2: Instantiating Nullable Profiles ===');
  final customerWithNulls = CustomerProfile(
    id: 'cust_001',
    fullName: 'Youssef Mansour',
    secondaryEmail: null,
    loyaltyPoints: null,
  );

  final customerComplete = CustomerProfile(
    id: 'cust_002',
    fullName: 'Mariam Adel',
    secondaryEmail: 'mariam.dev@example.org',
    loyaltyPoints: 350,
  );

  print('Profile 1: ${customerWithNulls.fullName}, Sec Email: ${customerWithNulls.secondaryEmail}');
  print('Profile 2: ${customerComplete.fullName}, Sec Email: ${customerComplete.secondaryEmail}');

  print('\n=== STEP 3: Null-Aware Operators in Action ===');

  // 1. Safe Navigation Operator (?.): Evaluates to null if receiver is null, without throwing NullPointerException
  int? emailLength1 = customerWithNulls.secondaryEmail?.length;
  int? emailLength2 = customerComplete.secondaryEmail?.length;
  print('Safe navigation length 1: $emailLength1'); // null
  print('Safe navigation length 2: $emailLength2'); // 22

  // 2. Null-Coalescing Operator (??): Provides a guaranteed default fallback value
  String displayEmail1 = customerWithNulls.secondaryEmail ?? 'no-secondary-email@system.internal';
  String displayEmail2 = customerComplete.secondaryEmail ?? 'no-secondary-email@system.internal';
  print('Fallback email 1: $displayEmail1');
  print('Fallback email 2: $displayEmail2');

  // 3. Null-Coalescing Assignment Operator (??=)
  int? sessionScore;
  print('Initial sessionScore: $sessionScore');
  sessionScore ??= 100; // Assigns 100 because sessionScore is null
  print('After ??= 100: $sessionScore');
  sessionScore ??= 500; // Does not assign because sessionScore is already 100
  print('After second ??= 500: $sessionScore');

  print('\n=== STEP 4: Dart Flow Analysis & Automatic Type Promotion ===');
  processCustomerEmail(customerWithNulls.secondaryEmail);
  processCustomerEmail(customerComplete.secondaryEmail);

  print('\n=== STEP 5: Dangerous Pattern: Force Unwrap (!) ===');
  demonstrateForceUnwrapSafety(customerComplete.secondaryEmail);
  demonstrateForceUnwrapDanger(customerWithNulls.secondaryEmail);
}

/// Demonstrates flow analysis promoting a nullable parameter to non-nullable
void processCustomerEmail(String? rawEmail) {
  if (rawEmail == null) {
    print('Flow Analysis: rawEmail is null. Skipping notification.');
    return;
  }

  // At this point, the Dart compiler's Flow Analysis PROVES rawEmail CANNOT be null!
  // Notice: We call .toUpperCase() directly without '?.' or '!'
  String guaranteedString = rawEmail.toUpperCase();
  print('Flow Analysis Promotion: Cleaned email is "$guaranteedString"');
}

void demonstrateForceUnwrapSafety(String? knownNonNull) {
  // Using '!' asserts to the compiler: "I guarantee this is not null."
  String value = knownNonNull!;
  print('Force unwrap succeeded on non-null: $value');
}

void demonstrateForceUnwrapDanger(String? knownNull) {
  try {
    // Dangerous! Throws TypeError / Null check operator used on a null value
    String value = knownNull!;
    print('This will never print: $value');
  } catch (e) {
    print('CAUGHT NULL CHECK EXCEPTION: $e');
  }
}

/*
================================================================================
TECHNICAL BREAKDOWN & PEDAGOGICAL NOTES
================================================================================
1. Why "Sound" Null Safety?
   - Before Sound Null Safety, any reference variable could contain null at runtime,
     leading to unpredictable NoSuchMethodError or NullPointerExceptions in production.
   - With Dart's sound type system, if a type does not have a '?', the Dart VM guarantees
     at both compile time and runtime that null will NEVER be stored in that memory slot.

2. Flow Analysis & Promotion:
   - Dart inspects control flow branches (if, return, throw).
   - If a code branch checks `if (variable == null) return;`, all subsequent statements
     in that scope automatically promote the variable from `Type?` to `Type`.
   - Note: Class fields cannot be promoted across function boundaries if they are public
     and non-final, because a getter could return null on a subsequent call.

3. Best Practices:
   - Minimize the use of the `!` (bang/force unwrap) operator. Every `!` is a potential crash.
   - Use default fallbacks (`??`) or explicit guard clauses with early returns.
================================================================================
*/
