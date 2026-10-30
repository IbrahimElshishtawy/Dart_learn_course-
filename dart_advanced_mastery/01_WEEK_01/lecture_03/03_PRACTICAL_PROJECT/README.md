# Practical Project 03: E-Commerce Pattern-Based Order Engine

## 1. Project Description & Business Scenario
Modern e-commerce platforms must evaluate complex, multi-variable business rules (customer fidelity tiers, promotional voucher codes, cold-chain refrigeration requirements, customs duties on cross-border shipments) in real-time. Traditional approaches rely on convoluted nested `if-else` trees and error-prone dictionary lookups.

This project implements an industrial-grade **E-Commerce Pattern-Based Order Engine** in pure Dart (SDK 3.8.1+), demonstrating:
- **Records** for lightweight line-item representation (`OrderLineItem`) and financial outcome tuples (`InvoiceRecord`).
- **Sealed Class Hierarchies** (`DeliveryChannel`) guaranteeing compile-time exhaustiveness checking.
- **Relational and Logical Pattern Matching** (`>= 3000.0`, `||`, `&&`).
- **Guard Clauses (`when`)** for contextual domain rules.
- **Map Pattern Destructuring** for safely parsing webhook event payloads.

---

## 2. Requirements Specification

### Functional Requirements
1. **Financial Invoice Computation:**
   - Compute subtotal across dynamic items.
   - Apply customer tier discounts (Enterprise: 25%, Gold: 15%, Silver: 8%) with promotional voucher overrides (`VIP_BLACK` -> 35%).
   - Calculate shipping logistics fees based on delivery method, destination country, and subtotal threshold (free above $3,000 or for Enterprise).
2. **Order Routing & Fulfillment Classification:**
   - Route shipments to appropriate warehouse queues (Standard, Express, Critical Cold Chain).
3. **Webhook Ingestion:**
   - Ingest and validate external notification payloads via Map pattern matching.

### Non-Functional Requirements
- **Exhaustiveness:** Zero unhandled sealed subtypes.
- **Immutability:** Value-equality semantics on Records and compile-time constants.
- **Performance:** Sub-microsecond calculation time.

---

## 3. Architecture & Folder Structure

```text
03_PRACTICAL_PROJECT/
├── README.md                      # Comprehensive project documentation
├── pubspec.yaml                   # Dart package manifest
├── bin/
│   └── main.dart                  # Order simulation and webhook runner
├── lib/
│   ├── engine/
│   │   ├── order_classifier.dart  # Pattern-based routing & webhook parser
│   │   └── pricing_engine.dart    # Pattern-based discount & shipping calculator
│   └── models/
│       └── order_types.dart       # Sealed DeliveryChannel, Enums, and Records
└── test/
    └── order_engine_test.dart     # Automated unit test suite
```

---

## 4. Execution & Testing Instructions

### Run the Order Simulator:
```bash
dart run bin/main.dart
```

### Run the Unit Tests:
```bash
dart test
```
