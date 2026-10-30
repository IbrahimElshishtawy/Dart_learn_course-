# Practical Project 05: Modular Payment Gateway Router

## 🎯 Project Overview
A production-grade, modular payment router built using pure Dart OOP principles:
- **Abstract Contracts**: Standardized `PaymentGateway` interface.
- **Polymorphic Routing**: Automatic detection of suitable providers based on transaction requirements (`StripeGateway`, `PaypalGateway`, `FawryGateway`).
- **Composition Over Inheritance**: Flexible `PaymentRouter` holding registered provider instances without hardcoded inheritance hierarchies.
- **Defensive Error Handling**: `PaymentResult` discriminated union pattern (`success` and `failure` constructors).

## 📂 Architecture
```
lib/
├── modular_payment_gateway.dart   # Main library export
└── src/
    ├── engine/
    │   └── payment_router.dart    # Router coordinator
    ├── gateways/
    │   ├── fawry_gateway.dart     # Fawry Egypt implementation
    │   ├── payment_gateway.dart   # Abstract contract
    │   ├── paypal_gateway.dart    # PayPal Express implementation
    │   └── stripe_gateway.dart    # Stripe Credit Cards implementation
    └── models/
        ├── payment_request.dart   # Input DTO
        └── payment_result.dart    # Response result model
bin/
└── main.dart                      # Runnable demo application
test/
└── payment_gateway_test.dart      # Unit test suite
```

## 🚀 Running the Project

```bash
# Run Demonstration
dart run bin/main.dart

# Run Automated Test Suite
dart test
```
