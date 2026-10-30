/// Modular Payment Gateway Library
/// Demonstrates abstract contracts, polymorphism, and pluggable payment routing.
library modular_payment_gateway;

export 'src/models/payment_request.dart';
export 'src/models/payment_result.dart';
export 'src/gateways/payment_gateway.dart';
export 'src/gateways/stripe_gateway.dart';
export 'src/gateways/paypal_gateway.dart';
export 'src/gateways/fawry_gateway.dart';
export 'src/engine/payment_router.dart';
