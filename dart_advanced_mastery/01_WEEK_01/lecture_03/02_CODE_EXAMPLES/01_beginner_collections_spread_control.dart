/// ==============================================================================
/// File: 01_beginner_collections_spread_control.dart
/// Educational Objective: Master modern Dart collection syntax: Lists, Sets, Maps,
/// Spread operators (`...`, `...?`), and control flow elements (Collection if and for).
///
/// Execution:
///   dart run 01_beginner_collections_spread_control.dart
/// ==============================================================================

void main() {
  print('=== STEP 1: Modern Spread Operators in Collections ===');

  final standardPermissions = ['READ_DOCUMENTS', 'DOWNLOAD_PDF'];
  final List<String>? nullableVipPermissions = null;
  final adminPermissions = ['MANAGE_USERS', 'RESET_PASSWORDS'];

  // Combining lists with spread (...) and null-aware spread (...?)
  final userRolePermissions = [
    ...standardPermissions,
    ...?nullableVipPermissions, // Gracefully skipped because it is null
    'SUBMIT_FEEDBACK',
  ];
  print('Standard User Permissions: $userRolePermissions');

  print('\n=== STEP 2: Collection-if for Declarative Assembly ===');
  bool isSuperAdmin = true;
  bool isMaintenanceWindow = false;

  final dynamicMenu = [
    'Dashboard',
    'Profile Settings',
    if (isSuperAdmin) 'Audit Logs System',
    if (isSuperAdmin && !isMaintenanceWindow) 'Run Data Migration',
  ];
  print('Dynamic Navigation Menu: $dynamicMenu');

  print('\n=== STEP 3: Collection-for for Declarative Transformations ===');
  final rawCurrencies = ['egp', 'usd', 'eur', 'sar'];

  // Transforms elements directly inside the collection literal
  final normalizedCurrencies = [
    'DEFAULT_EGP',
    for (final curr in rawCurrencies) curr.toUpperCase(),
  ];
  print('Normalized Currencies: $normalizedCurrencies');

  print('\n=== STEP 4: Sets & Maps with Modern Control Flow ===');
  final activeUserIds = {101, 102, 103};
  final Set<int>? pendingUserIds = {104, 105};

  final allUserIds = {
    ...activeUserIds,
    ...?pendingUserIds,
  };
  print('Aggregated Unique User ID Set: $allUserIds');

  // Map assembly with conditional entries
  bool includeDebugConfig = true;
  final appConfig = <String, dynamic>{
    'appName': 'DartMasteryApp',
    'version': '3.8.1',
    if (includeDebugConfig) ...{
      'debugPort': 8080,
      'logLevel': 'VERBOSE',
    },
  };
  print('App Configuration Map: $appConfig');
}
