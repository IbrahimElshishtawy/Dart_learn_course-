/// ==============================================================================
/// File: 05_wrong_vs_refactored_null_safety.dart
/// Educational Objective: Contrast an insecure, bug-prone implementation that abuses
/// the `!` bang operator and `dynamic` with an industrial-grade, refactored implementation
/// utilizing strict Sound Null Safety, immutability, and pattern guards.
///
/// Execution:
///   dart run 05_wrong_vs_refactored_null_safety.dart
/// ==============================================================================

// ==============================================================================
// 1. THE WRONG IMPLEMENTATION (Fragile, Error-Prone Anti-Patterns)
// ==============================================================================
class FragileUserOrder {
  dynamic orderId; // ANTI-PATTERN: dynamic disables static type safety
  String? customerName;
  double? totalAmount;
  late String receiptCode; // ANTI-PATTERN: uninitialized late variable vulnerable to crash

  FragileUserOrder(this.orderId, this.customerName, this.totalAmount);

  void printReceipt() {
    // ANTI-PATTERN: Bang operator (!) blindly applied without validation
    // If customerName or totalAmount is null, application crashes with TypeError
    print('Order #${orderId.toString()} for ${customerName!.toUpperCase()}');
    print('Total Amount: \$${totalAmount!.toStringAsFixed(2)}');
    // Accessing uninitialized receiptCode throws LateInitializationError
    print('Receipt: $receiptCode');
  }
}

// ==============================================================================
// 2. THE REFACTORED IMPLEMENTATION (Robust, Type-Safe, Production-Ready)
// ==============================================================================
class RobustUserOrder {
  final String orderId;
  final String customerName;
  final double totalAmount;
  final String? receiptCode; // Explicitly nullable with safe fallback

  const RobustUserOrder({
    required this.orderId,
    required this.customerName,
    required this.totalAmount,
    this.receiptCode,
  }) : assert(totalAmount >= 0.0, 'Total amount cannot be negative');

  /// Safe factory constructor that validates and sanitizes external untrusted data
  factory RobustUserOrder.fromUntrustedData({
    required dynamic rawId,
    required String? rawName,
    required double? rawAmount,
    String? receiptCode,
  }) {
    // 1. Validate ID
    if (rawId == null || rawId.toString().trim().isEmpty) {
      throw ArgumentError('Order ID cannot be empty or null');
    }

    // 2. Validate & Sanitize Customer Name with safe fallback
    final sanitizedName = (rawName != null && rawName.trim().isNotEmpty)
        ? rawName.trim()
        : 'GUEST_CUSTOMER';

    // 3. Validate Amount
    final sanitizedAmount = (rawAmount != null && rawAmount >= 0.0)
        ? rawAmount
        : 0.0;

    return RobustUserOrder(
      orderId: rawId.toString(),
      customerName: sanitizedName,
      totalAmount: sanitizedAmount,
      receiptCode: receiptCode,
    );
  }

  void printReceipt() {
    // Completely safe: guaranteed non-null fields
    print('Order #$orderId for ${customerName.toUpperCase()}');
    print('Total Amount: \$${totalAmount.toStringAsFixed(2)}');

    // Safe handling of optional nullable field using null-coalescing
    final receipt = receiptCode ?? 'PENDING_DIGITAL_GENERATION';
    print('Receipt: $receipt');
  }
}

void main() {
  print('=== SCENARIO 1: Running the Fragile Implementation (Crashing) ===');
  final buggyOrder = FragileUserOrder(1099, null, 450.0);

  try {
    buggyOrder.printReceipt();
  } catch (e) {
    print('>> CRASH CAUGHT in Fragile Implementation:');
    print('   Error: $e');
  }

  print('\n=== SCENARIO 2: Running the Refactored Implementation (Safe) ===');
  // Passing nulls into the safe factory
  final safeOrder1 = RobustUserOrder.fromUntrustedData(
    rawId: 1099,
    rawName: null, // Gracefully defaulted to GUEST_CUSTOMER
    rawAmount: 450.0,
    receiptCode: null, // Gracefully handled as PENDING_DIGITAL_GENERATION
  );

  safeOrder1.printReceipt();

  print('\n=== SCENARIO 3: Running Refactored with Complete Data ===');
  final safeOrder2 = RobustUserOrder.fromUntrustedData(
    rawId: 'ORD_2026_EG_88',
    rawName: 'Engineer Mahmoud',
    rawAmount: 1899.99,
    receiptCode: 'RCPT_VERIFIED_9918',
  );

  safeOrder2.printReceipt();
}

/*
================================================================================
ENGINEERING COMPARISON & CODE REVIEW CHECKLIST
================================================================================
Checklist Item          | Fragile Version                 | Refactored Version
------------------------|---------------------------------|---------------------------------
Type Safety             | Weak (`dynamic orderId`)        | Strict (`String orderId`)
Null Handling           | Blind force unwrap (`!`)        | Guaranteed types & fallback (`??`)
Initialization Risk     | Unsafe `late` variable crash    | Explicit constructor initialization
Data Validation         | None                            | Guarded factory with validation
Immutability            | Mutable fields (reassignable)   | Immutable (`final` fields)
================================================================================
*/
