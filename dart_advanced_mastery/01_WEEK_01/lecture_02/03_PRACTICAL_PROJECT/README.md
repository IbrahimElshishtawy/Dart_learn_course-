# Practical Project 02: Flexible Data Transformation Pipeline

## 1. Project Description & Business Scenario
In modern backend systems, microservices, and reactive applications, incoming raw payloads (e.g., webhook notifications, CSV records, HTTP request bodies) must undergo a deterministic sequence of cleaning, validation, parsing, and business enrichment steps. Writing rigid monolithic procedures tightly couples steps together, making unit testing and stage reordering cumbersome.

This project implements a composable, generic **Flexible Data Transformation Pipeline** in pure Dart, demonstrating:
- **First-Class Functions & Function Types** (`typedef Stage<In, Out>`).
- **Higher-Order Functions & Middleware Interceptors** for cross-cutting telemetry and logging.
- **Closures** capturing configuration parameters dynamically (e.g., dynamic tax rates).
- **Tear-offs** for zero-cost stage wiring.
- Immutable context propagation (`PipelineContext<T>`).

---

## 2. Requirements Specification

### Functional Requirements
1. **Pipeline Composition:**
   - Support a fluent builder API: `Pipeline.start<T>().pipe(stageName, fn)`.
   - Maintain a chronological `stageHistory` audit trail for every processed context.
2. **Middleware Extensibility:**
   - Enable stage interception with pre- and post-execution hooks (e.g., latency measurement, error boundaries).
   - Support telemetry logging duration in microseconds per stage in context metadata.
3. **Data Sanitization & Enrichment:**
   - Provide standard reusable stages: string trimming, case normalization, separator conversion, and numeric parsing.
   - Support dynamic enrichment factories via closures (e.g., configurable VAT calculation).

### Non-Functional Requirements
- **Referential Transparency:** Each stage is a pure function operating on immutable context.
- **Type Safety:** Full compile-time static type inference across sequential stages ($T_1 \rightarrow T_2 \rightarrow T_3$).
- **Testability:** 100% testable without database or mocking libraries.

---

## 3. Architecture & Folder Structure

```text
03_PRACTICAL_PROJECT/
├── README.md                      # Comprehensive project documentation
├── pubspec.yaml                   # Dart package manifest
├── bin/
│   └── main.dart                  # Batch processing simulation runner
├── lib/
│   ├── core/
│   │   ├── pipeline.dart          # Composable pipeline engine & middleware generator
│   │   └── pipeline_context.dart  # Immutable context carrier & history tracker
│   └── stages/
│       ├── sanitization_stages.dart# Pure static sanitization functions (Tear-off friendly)
│       └── enrichment_stages.dart  # Dynamic closure factories & domain value objects
└── test/
    └── pipeline_test.dart         # Automated unit test suite
```

---

## 4. Execution & Testing Instructions

### Run the Simulation Runner:
```bash
dart run bin/main.dart
```

### Run the Automated Unit Tests:
```bash
dart test
```
