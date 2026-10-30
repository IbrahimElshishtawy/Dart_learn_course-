/// Enum representing runtime execution environments.
enum Environment {
  development,
  staging,
  production;

  bool get isProduction => this == Environment.production;
  bool get isDevelopment => this == Environment.development;

  static Environment fromString(String value) {
    switch (value.trim().toLowerCase()) {
      case 'prod':
      case 'production':
        return Environment.production;
      case 'stage':
      case 'staging':
        return Environment.staging;
      case 'dev':
      case 'development':
      default:
        return Environment.development;
    }
  }
}
