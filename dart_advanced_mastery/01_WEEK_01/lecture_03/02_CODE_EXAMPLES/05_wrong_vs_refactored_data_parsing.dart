/// ==============================================================================
/// File: 05_wrong_vs_refactored_data_parsing.dart
/// Educational Objective: Contrast fragile, deeply nested `if-else` dictionary parsing
/// with elegant, declarative Dart 3 Pattern Matching and Destructuring.
///
/// Execution:
///   dart run 05_wrong_vs_refactored_data_parsing.dart
/// ==============================================================================

// ==============================================================================
// 1. THE WRONG IMPLEMENTATION (Deeply Nested, Fragile if-else Tree)
// ==============================================================================
String parseWebhookPayloadBad(dynamic json) {
  // ANTI-PATTERN: Multiple brittle type-checks, manually navigating maps with unsafe casting
  if (json != null && json is Map) {
    if (json.containsKey('event')) {
      var event = json['event'];
      if (event == 'PAYMENT_RECEIVED') {
        if (json.containsKey('data') && json['data'] is Map) {
          var data = json['data'];
          if (data.containsKey('amount') && data['amount'] is num) {
            var amount = data['amount'];
            if (data.containsKey('currency') && data['currency'] is String) {
              return 'Payment received of $amount ${data['currency']}';
            }
          }
        }
      } else if (event == 'USER_LOGOUT') {
        return 'User logged out.';
      }
    }
  }
  return 'UNRECOGNIZED_PAYLOAD';
}

// ==============================================================================
// 2. THE REFACTORED IMPLEMENTATION (Declarative Dart 3 Map Pattern Destructuring)
// ==============================================================================
String parseWebhookPayloadRefactored(Object? json) {
  // Single-expression pattern matching directly inspecting shape, keys, and types!
  return switch (json) {
    {
      'event': 'PAYMENT_RECEIVED',
      'data': {
        'amount': num amount,
        'currency': String currency,
      }
    } => 'Payment received of $amount $currency',

    {'event': 'USER_LOGOUT'} => 'User logged out.',

    {'event': 'REFUND_ISSUED', 'data': {'ticketId': String ticket}} =>
      'Refund processed for Ticket: $ticket',

    _ => 'UNRECOGNIZED_PAYLOAD',
  };
}

void main() {
  print('=== SCENARIO 1: Valid Payment Webhook ===');
  final validPaymentPayload = {
    'event': 'PAYMENT_RECEIVED',
    'data': {
      'amount': 450.75,
      'currency': 'EGP',
      'gateway': 'FAWRY_DIRECT',
    },
    'timestamp': 1712390192,
  };

  print('Bad Parser       : ${parseWebhookPayloadBad(validPaymentPayload)}');
  print('Refactored Parser: ${parseWebhookPayloadRefactored(validPaymentPayload)}');

  print('\n=== SCENARIO 2: Malformed Payload (Missing required inner key) ===');
  final malformedPayload = {
    'event': 'PAYMENT_RECEIVED',
    'data': {
      'amount': 'four-hundred', // Invalid type: String instead of num!
      'currency': 'EGP',
    }
  };

  print('Bad Parser       : ${parseWebhookPayloadBad(malformedPayload)}');
  print('Refactored Parser: ${parseWebhookPayloadRefactored(malformedPayload)}');

  print('\n=== SCENARIO 3: Distinct Event Pattern ===');
  final refundPayload = {
    'event': 'REFUND_ISSUED',
    'data': {'ticketId': 'TICK_99812'},
  };

  print('Refactored Parser: ${parseWebhookPayloadRefactored(refundPayload)}');
}
