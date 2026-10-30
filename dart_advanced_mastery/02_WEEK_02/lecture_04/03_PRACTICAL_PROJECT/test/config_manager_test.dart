import 'package:test/test.dart';
import 'package:robust_config_manager/robust_config_manager.dart';

void main() {
  group('DatabaseConfig Tests', () {
    test('Default values and validation', () {
      const db = DatabaseConfig.local();
      expect(db.host, equals('localhost'));
      expect(db.port, equals(5432));
      expect(db.connectionPoolSize, equals(5));
    });

    test('copyWith produces modified copy without mutating original', () {
      const original = DatabaseConfig.local();
      final updated = original.copyWith(host: 'remote-host', port: 3306);

      expect(updated.host, equals('remote-host'));
      expect(updated.port, equals(3306));
      expect(updated.databaseName, equals(original.databaseName));
      expect(original.host, equals('localhost')); // Immutable original
    });

    test('Structural equality and hashCode', () {
      const db1 = DatabaseConfig(host: 'localhost', port: 5432, databaseName: 'app');
      const db2 = DatabaseConfig(host: 'localhost', port: 5432, databaseName: 'app');
      final db3 = db1.copyWith(port: 5433);

      expect(db1, equals(db2));
      expect(db1.hashCode, equals(db2.hashCode));
      expect(db1, isNot(equals(db3)));
    });

    test('Throws on invalid port in fromJson', () {
      expect(
        () => DatabaseConfig.fromJson({'port': 99999}),
        throwsArgumentError,
      );
    });
  });

  group('AppConfig Tests', () {
    test('Development factory produces expected defaults', () {
      final config = AppConfig.development();
      expect(config.environment, equals(Environment.development));
      expect(config.environment.isDevelopment, isTrue);
      expect(config.environment.isProduction, isFalse);
    });

    test('Full JSON serialization round-trip', () {
      final original = AppConfig.development().copyWith(
        appName: 'TestApp',
        version: '2.0.0',
        environment: Environment.production,
      );

      final json = original.toJson();
      final restored = AppConfig.fromJson(json);

      expect(restored.appName, equals(original.appName));
      expect(restored.version, equals(original.version));
      expect(restored.environment, equals(original.environment));
      expect(restored.server, equals(original.server));
      expect(restored.database, equals(original.database));
      expect(restored, equals(original));
    });
  });
}
