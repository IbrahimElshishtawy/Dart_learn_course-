/// Immutable server host configuration.
class ServerConfig {
  final String host;
  final int port;
  final bool enableTls;

  const ServerConfig({
    required this.host,
    required this.port,
    this.enableTls = false,
  });

  const ServerConfig.development()
      : host = '127.0.0.1',
        port = 8080,
        enableTls = false;

  factory ServerConfig.fromJson(Map<String, dynamic> json) {
    return ServerConfig(
      host: json['host'] as String? ?? '0.0.0.0',
      port: json['port'] as int? ?? 8080,
      enableTls: json['enableTls'] as bool? ?? false,
    );
  }

  ServerConfig copyWith({
    String? host,
    int? port,
    bool? enableTls,
  }) {
    return ServerConfig(
      host: host ?? this.host,
      port: port ?? this.port,
      enableTls: enableTls ?? this.enableTls,
    );
  }

  Map<String, dynamic> toJson() => {
        'host': host,
        'port': port,
        'enableTls': enableTls,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServerConfig &&
        other.host == host &&
        other.port == port &&
        other.enableTls == enableTls;
  }

  @override
  int get hashCode => Object.hash(host, port, enableTls);

  @override
  String toString() =>
      'ServerConfig(host: $host, port: $port, tls: $enableTls)';
}
