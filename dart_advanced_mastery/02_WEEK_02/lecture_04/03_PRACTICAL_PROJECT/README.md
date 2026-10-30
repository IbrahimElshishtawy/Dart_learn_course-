# Practical Project 04: Robust Immutable Configuration Manager

## 🎯 Project Overview
A production-grade immutable configuration manager built in pure Dart. It showcases modern Dart 3 Object-Oriented principles, including:
- Immutable Data Modeling with `const` constructors and `final` properties.
- Value Object Semantics with `operator ==` and `hashCode`.
- The `copyWith` pattern for functional, safe state evolution.
- Serialization and Deserialization (`toJson` and `fromJson`).
- Defensive validation of network and system ports.

## 📂 Architecture
```
lib/
├── robust_config_manager.dart     # Library entrypoint
└── src/
    ├── app_config.dart            # Root aggregator configuration model
    ├── database_config.dart       # Database connection parameters
    ├── environment.dart           # Runtime environment enum
    └── server_config.dart         # HTTP/TLS host settings
bin/
└── main.dart                      # Runnable demonstration script
test/
└── config_manager_test.dart       # Comprehensive unit tests
```

## 🚀 Running the Project

### Execute Main Application:
```bash
dart run bin/main.dart
```

### Run Unit Tests:
```bash
dart test
```
