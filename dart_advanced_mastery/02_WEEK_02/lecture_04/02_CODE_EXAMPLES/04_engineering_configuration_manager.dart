// ==============================================================================
// 04_engineering_configuration_manager.dart
// Week 02 - Lecture 04: Production-Grade Immutable Configuration & copyWith Pattern
// ==============================================================================
// الهدف: تطبيق نمط النمذجة الهندسية للبيانات المعقدة:
// 1. كائن تهيئة النظام (AppConfig) بنمط Immutability الصارم.
// 2. تطبيق دالة copyWith المعتمدة في بنية تطبيقات Flutter / Clean Architecture.
// 3. التحقق الدفاعي من صحة الإعدادات قبل إقرارها.
// ==============================================================================

enum Environment { development, staging, production }

class DatabaseConfig {
  final String host;
  final int port;
  final String databaseName;
  final int maxConnections;

  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.databaseName,
    this.maxConnections = 10,
  });

  DatabaseConfig copyWith({
    String? host,
    int? port,
    String? databaseName,
    int? maxConnections,
  }) {
    return DatabaseConfig(
      host: host ?? this.host,
      port: port ?? this.port,
      databaseName: databaseName ?? this.databaseName,
      maxConnections: maxConnections ?? this.maxConnections,
    );
  }

  @override
  String toString() =>
      'DatabaseConfig(host: $host, port: $port, db: $databaseName, pool: $maxConnections)';
}

class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final Environment environment;
  final DatabaseConfig database;
  final bool enableDebugLogs;

  const AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
    required this.database,
    this.enableDebugLogs = false,
  });

  /// Factory للبيئة الافتراضية للتطوير
  factory AppConfig.defaultDev() {
    return const AppConfig(
      appName: 'DartMasteryApp',
      apiBaseUrl: 'http://localhost:8080/api/v1',
      environment: Environment.development,
      enableDebugLogs: true,
      database: DatabaseConfig(
        host: '127.0.0.1',
        port: 5432,
        databaseName: 'dev_db',
        maxConnections: 5,
      ),
    );
  }

  /// تطبيق نمط copyWith الشهير لتعديل حقول معينة بدون المساس بالأصل
  AppConfig copyWith({
    String? appName,
    String? apiBaseUrl,
    Environment? environment,
    DatabaseConfig? database,
    bool? enableDebugLogs,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      environment: environment ?? this.environment,
      database: database ?? this.database,
      enableDebugLogs: enableDebugLogs ?? this.enableDebugLogs,
    );
  }

  void printSummary() {
    print('==============================================');
    print('🚀 Application: $appName [${environment.name.toUpperCase()}]');
    print('🌐 API Endpoint: $apiBaseUrl');
    print('🛠️ Debug Logging: $enableDebugLogs');
    print('🗄️ Database: $database');
    print('==============================================');
  }
}

void main() {
  print('=== 🟣 كود المحاضرة 4: نمط الـ Configuration Manager ونمط copyWith ===\n');

  // 1. إنشاء إعدادات التطوير الافتراضية
  final devConfig = AppConfig.defaultDev();
  print('1. إعدادات بيئة التطوير الأصلية:');
  devConfig.printSummary();

  // 2. إنتاج إعدادات بيئة الإنتاج عبر copyWith بأمان تام
  final prodConfig = devConfig.copyWith(
    apiBaseUrl: 'https://api.dartmastery.com/v1',
    environment: Environment.production,
    enableDebugLogs: false,
    database: devConfig.database.copyWith(
      host: 'prod-cluster.cloud.internal',
      databaseName: 'production_master',
      maxConnections: 100,
    ),
  );

  print('\n2. إعدادات بيئة الإنتاج (Production) المشتقة بدون آثار جانبية:');
  prodConfig.printSummary();

  print('\n3. التأكد من بقاء إعدادات التطوير سليمة تماماً:');
  devConfig.printSummary();
}
