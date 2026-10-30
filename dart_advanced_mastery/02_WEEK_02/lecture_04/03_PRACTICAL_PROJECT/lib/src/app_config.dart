import 'environment.dart';
import 'database_config.dart';
import 'server_config.dart';

/// Top-level immutable application configuration aggregator.
class AppConfig {
  final String appName;
  final String version;
  final Environment environment;
  final ServerConfig server;
  final DatabaseConfig database;
  final Map<String, String> featureFlags;

  const AppConfig({
    required this.appName,
    required this.version,
    required this.environment,
    required this.server,
    required this.database,
    this.featureFlags = const {},
  });

  /// Factory constructor providing ready-to-use development defaults.
  factory AppConfig.development() {
    return const AppConfig(
      appName: 'DartMastery-Core',
      version: '1.0.0-dev',
      environment: Environment.development,
      server: ServerConfig.development(),
      database: DatabaseConfig.local(),
      featureFlags: {
        'enable_beta_dashboard': 'true',
        'enable_detailed_metrics': 'true',
      },
    );
  }

  /// Factory constructor for parsing configuration from nested JSON maps.
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['appName'] as String? ?? 'App',
      version: json['version'] as String? ?? '1.0.0',
      environment: Environment.fromString(json['environment'] as String? ?? 'dev'),
      server: ServerConfig.fromJson(
        Map<String, dynamic>.from(json['server'] as Map? ?? {}),
      ),
      database: DatabaseConfig.fromJson(
        Map<String, dynamic>.from(json['database'] as Map? ?? {}),
      ),
      featureFlags: Map<String, String>.from(json['featureFlags'] as Map? ?? {}),
    );
  }

  /// Pure copyWith implementation for immutable state progression.
  AppConfig copyWith({
    String? appName,
    String? version,
    Environment? environment,
    ServerConfig? server,
    DatabaseConfig? database,
    Map<String, String>? featureFlags,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      version: version ?? this.version,
      environment: environment ?? this.environment,
      server: server ?? this.server,
      database: database ?? this.database,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }

  Map<String, dynamic> toJson() => {
        'appName': appName,
        'version': version,
        'environment': environment.name,
        'server': server.toJson(),
        'database': database.toJson(),
        'featureFlags': featureFlags,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppConfig &&
        other.appName == appName &&
        other.version == version &&
        other.environment == environment &&
        other.server == server &&
        other.database == database;
  }

  @override
  int get hashCode => Object.hash(appName, version, environment, server, database);

  @override
  String toString() =>
      'AppConfig(name: $appName, env: ${environment.name}, server: $server, db: $database)';
}
