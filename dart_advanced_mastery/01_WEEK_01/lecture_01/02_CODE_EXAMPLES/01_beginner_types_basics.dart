/// ==============================================================================
/// File: 01_beginner_types_basics.dart
/// Educational Objective: Master Dart's core primitive types, static type inference (`var`),
/// the fundamental distinction between `Object` and `dynamic`, and strict type compliance.
///
/// Execution:
///   dart run 01_beginner_types_basics.dart
/// ==============================================================================

void main() {
  print('=== STEP 1: Static Type Declarations vs Type Inference ===');

  // Explicit type declaration
  int accountId = 10042;
  double interestRate = 0.045;
  String accountHolder = 'Fatima Zahra';
  bool isActive = true;

  print('Explicit Types: id=$accountId, rate=$interestRate, holder=$accountHolder, active=$isActive');

  // Type inference using 'var': Dart compiler infers String at compile-time
  var transactionTag = 'TX_REFUND_99';
  // transactionTag = 42; // COMPILE ERROR: A value of type 'int' cannot be assigned to a variable of type 'String'.
  print('Inferred type for transactionTag is String: "$transactionTag"');

  print('\n=== STEP 2: The Core Difference: Object vs dynamic ===');

  // Object: The root of the Dart non-nullable class hierarchy.
  // The compiler enforces static type checking: only methods defined on Object (e.g., toString(), hashCode) are accessible.
  Object safeContainer = 'Enterprise Security Token';
  print('safeContainer as Object toString: ${safeContainer.toString()}');
  // safeContainer.toUpperCase(); // COMPILE ERROR: The method 'toUpperCase' isn't defined for the class 'Object'.

  // Type promotion via 'is' check
  if (safeContainer is String) {
    // Flow analysis automatically promotes safeContainer to String within this block
    print('Promoted safeContainer uppercase: ${safeContainer.toUpperCase()}');
  }

  // dynamic: Disables static type analysis entirely. Method resolution is deferred to runtime.
  dynamic untypedInput = 'Initial Raw String';
  print('dynamic length: ${untypedInput.length}');

  // Changing the type at runtime is permissible for dynamic variables:
  untypedInput = 123456;
  print('untypedInput re-assigned to int: $untypedInput');

  // Warning: Calling non-existent methods compiles cleanly but crashes at runtime!
  try {
    // This will throw NoSuchMethodError at runtime
    untypedInput.toLowerCase();
  } on NoSuchMethodError catch (e) {
    print('CAUGHT RUNTIME DISASTER (NoSuchMethodError): $e');
  }

  print('\n=== STEP 3: Numbers Hierarchy: num, int, and double ===');
  // 'num' is an abstract superclass of both 'int' and 'double'
  num flexibleAmount = 50; // Holds an int
  print('flexibleAmount as int: $flexibleAmount (runtimeType: ${flexibleAmount.runtimeType})');
  flexibleAmount = 79.99; // Can safely hold a double
  print('flexibleAmount as double: $flexibleAmount (runtimeType: ${flexibleAmount.runtimeType})');

  print('\nExecution completed safely with zero unhandled errors.');
}

/*
================================================================================
TECHNICAL BREAKDOWN & PEDAGOGICAL NOTES
================================================================================
1. Syntax Explained:
   - `var`: Tells the Dart Common Front End (CFE) to deduce the variable's type from its initializer. Once inferred, the type is fixed forever.
   - `Object`: The non-nullable top type. Guarantees safe polymorphic behavior.
   - `dynamic`: An escape hatch from the type system. Useful only during low-level serialization or interop with JavaScript/Objective-C.

2. Expected Output:
   === STEP 1: Static Type Declarations vs Type Inference ===
   Explicit Types: id=10042, rate=0.045, holder=Fatima Zahra, active=true
   Inferred type for transactionTag is String: "TX_REFUND_99"

   === STEP 2: The Core Difference: Object vs dynamic ===
   safeContainer as Object toString: Enterprise Security Token
   Promoted safeContainer uppercase: ENTERPRISE SECURITY TOKEN
   dynamic length: 18
   untypedInput re-assigned to int: 123456
   CAUGHT RUNTIME DISASTER (NoSuchMethodError): ...

   === STEP 3: Numbers Hierarchy: num, int, and double ===
   flexibleAmount as int: 50 (runtimeType: int)
   flexibleAmount as double: 79.99 (runtimeType: double)

   Execution completed safely with zero unhandled errors.

3. Common Pitfalls:
   - Assuming `var` means dynamic typing like JavaScript. In Dart, `var x = 1` is strictly an `int`.
   - Overusing `dynamic` to avoid compiler warnings; this converts compile-time safety into production crashes.

4. Complexity Analysis:
   - Primitive variable access: O(1) Time, O(1) Memory Space.
   - Type checks (`is` operator): O(1) Time check on the object's class pointer in memory.

5. Alternative Implementation:
   - Instead of `dynamic`, use generic types `T` or sealed class hierarchies when handling diverse payloads.
================================================================================
*/
