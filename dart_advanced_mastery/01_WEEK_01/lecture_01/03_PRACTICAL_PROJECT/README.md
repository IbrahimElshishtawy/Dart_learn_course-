# Practical Project 01: Financial Transaction Validator Core

## 1. Project Description & Business Scenario
In real-world FinTech systems (e.g., payment gateways, mobile banking applications, payment service providers), processing financial payloads requires uncompromising type soundness and zero-tolerance for unexpected null pointers. A single unhandled runtime error can halt transaction settlement, cause financial discrepancies, or expose the institution to regulatory fines.

This project implements an industrial-grade **Financial Transaction Validator Core** in pure Dart (SDK 3.8.1+), demonstrating:
- Strict **Sound Null Safety** and eradication of the bang operator (`!`).
- **Definite Assignment & Flow Analysis** for type promotion.
- Domain-driven monetary representation using integer minor units (piasters/cents) to prevent floating-point inaccuracies.
- Safe modeling of audit states via structured outcome objects.

---

## 2. Requirements Specification

### Functional Requirements
1. **Transaction Ingestion & Normalization:**
   - Ingest raw transaction payloads (ID, amount, currency, source IBAN, destination IBAN, timestamp, client IP, reference note).
   - Normalize string fields (trim whitespaces, convert IBANs to uppercase without spaces).
2. **Monetary Integrity Validation:**
   - Enforce strictly positive transaction amounts.
   - Guard against floating-point precision loss through the `Money` value object.
   - Enforce regulatory single-transaction transfer ceilings (2,000,000.00 EGP).
3. **Anti-Fraud & Security Auditing:**
   - Reject self-loop transactions where `sourceIban == destinationIban`.
   - Validate IBAN length compliant with ISO-13616 (15–34 alphanumeric characters).
   - Flag high-value transactions (>= 500,000.00 EGP) with `requiresManualReview` for AML (Anti-Money Laundering) checks.
   - Reject stale transactions older than 24 hours or with future clock drift (> 5 minutes).

### Non-Functional Requirements
- **Performance:** Sub-millisecond validation time per transaction.
- **Reliability:** 100% deterministic execution without unhandled exceptions.
- **Maintainability:** Modular separation between models (`lib/models/`) and business rules (`lib/services/`).
- **Testability:** Complete unit test coverage with zero external network or database dependencies.

---

## 3. Architecture & Folder Structure

```text
03_PRACTICAL_PROJECT/
├── README.md                          # Comprehensive project documentation & architecture guide
├── pubspec.yaml                       # Dart package configuration & dependencies
├── bin/
│   └── main.dart                      # Simulation runner executing diverse transaction scenarios
├── lib/
│   ├── models/
│   │   ├── transaction.dart           # Immutable Money value object & Transaction entity
│   │   └── validation_result.dart     # Audit status enum & structured outcome container
│   └── services/
│       └── transaction_validator.dart # Multi-stage security rule pipeline
└── test/
    └── transaction_validator_test.dart# Automated unit test suite using package:test
```

---

## 4. Execution & Testing Instructions

### Run the Simulation Runner:
```bash
dart run bin/main.dart
```

### Execute the Automated Unit Test Suite:
```bash
dart test
```

---

## 5. Evaluation Rubric & Criteria
- **Type Safety & Soundness (30%):** Zero warnings under strict static analysis (`strict-casts`, `strict-inference`, `strict-raw-types`).
- **Domain Modeling (25%):** Correct use of `Money` class, immutability, and const constructors.
- **Security & Edge Case Coverage (25%):** Proper detection of null payloads, self-loop fraud, and boundary amounts.
- **Code Quality & Testing (20%):** Clean readable code, descriptive assertions, and passing unit tests.
