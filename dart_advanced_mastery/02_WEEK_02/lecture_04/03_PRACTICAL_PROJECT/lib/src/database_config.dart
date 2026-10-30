/// Immutable database configuration.
class DatabaseConfig {
  final String host;
  final int port;
  final String databaseName;
  final int connectionPoolSize;

  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.databaseName,
    this.connectionPoolSize = 10,
  });

  const DatabaseConfig.local()
      : host = 'localhost',
        port = 5432,
        databaseName = 'app_local_db',
        connectionPoolSize = 5;

  factory DatabaseConfig.fromJson(Map<String, dynamic> json) {
    final host = json['host'] as String? ?? 'localhost';
    final port = json['port'] as int? ?? 5432;
    final dbName = json['databaseName'] as String? ?? 'app_db';
    final poolSize = json['connectionPoolSize'] as int? ?? 10;

    if (port <= 0 || port > 65535) {
      throw ArgumentError('Invalid database port: $port');
    }

    return DatabaseConfig(
      host: host,
      port: port,
      databaseName: dbName,
      connectionPoolSize: poolSize,
    );
  }

  DatabaseConfig copyWith({
    String? host,
    int? port,
    String? databaseName,
    int? connectionPoolSize,
  }) {
    return DatabaseConfig(
      host: host ?? this.host,
      port: port ?? this.port,
      databaseName: databaseName ?? this.databaseName,
      connectionPoolSize: connectionPoolSize ?? this.connectionPoolSize,
    );
  }

  Map<String, dynamic> toJson() => {
        'host': host,
        'port': port,
        'databaseName': databaseName,
        'connectionPoolSize': connectionPoolSize,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DatabaseConfig &&
        other.host == host &&
        other.port == port &&
        other.databaseName == databaseName &&
        other.connectionPoolSize == connectionPoolSize;
  }

  @override
  int get hashCode =>
      Object.hash(host, port, databaseName, connectionPoolSize);

  @override
  String toString() =>
      'DatabaseConfig(host: $host:$port, db: $databaseName, pool: $connectionPoolSize)';
}
