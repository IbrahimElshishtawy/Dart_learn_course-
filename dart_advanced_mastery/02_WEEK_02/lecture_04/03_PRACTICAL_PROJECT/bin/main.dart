import 'package:robust_config_manager/robust_config_manager.dart';

void main() {
  print('===========================================================');
  print('🛠️ Lecture 04 Practical Project: Robust Config Manager');
  print('===========================================================\n');

  // 1. إنشاء الإعدادات الافتراضية
  final devConfig = AppConfig.development();
  print('🟢 إعدادات بيئة التطوير (Development):');
  print('  App Name : ${devConfig.appName} (${devConfig.version})');
  print('  Server   : ${devConfig.server}');
  print('  Database : ${devConfig.database}');
  print('  Flags    : ${devConfig.featureFlags}');

  // 2. ترقية الإعدادات لبيئة الإنتاج باستخدام copyWith
  print('\n🔵 ترقية الإعدادات لبيئة الإنتاج (Production) بنمط غير قابل للتعديل:');
  final prodConfig = devConfig.copyWith(
    environment: Environment.production,
    version: '1.0.0-release',
    server: devConfig.server.copyWith(
      host: 'api.production.internal',
      port: 443,
      enableTls: true,
    ),
    database: devConfig.database.copyWith(
      host: 'db-cluster.aws.internal',
      connectionPoolSize: 50,
    ),
    featureFlags: {
      'enable_beta_dashboard': 'false',
      'enable_detailed_metrics': 'true',
    },
  );

  print('  App Name : ${prodConfig.appName} (${prodConfig.version})');
  print('  Server   : ${prodConfig.server}');
  print('  Database : ${prodConfig.database}');
  print('  Flags    : ${prodConfig.featureFlags}');

  // 3. التحقق من المساواة الهيكلية
  print('\n⚖️ اختبار المساواة الهيكلية:');
  final devConfig2 = AppConfig.development();
  print('  هل devConfig == devConfig2؟ ${devConfig == devConfig2} (Expected: true)');
  print('  هل devConfig == prodConfig؟ ${devConfig == prodConfig} (Expected: false)');

  // 4. تصدير واستيراد JSON
  print('\n📦 تصدير إعدادات الإنتاج إلى JSON:');
  final jsonPayload = prodConfig.toJson();
  print('  JSON Result: $jsonPayload');

  final reconstructed = AppConfig.fromJson(jsonPayload);
  print('  إعادة البناء من JSON: ${reconstructed == prodConfig ? "✅ متطابق 100%" : "❌ غير متطابق"}');
  print('\n===========================================================');
}
