// ==============================================================================
// 02_intermediate_constructors_encapsulation.dart
// Week 02 - Lecture 04: Advanced Constructors & Object Lifecycle
// ==============================================================================
// الهدف: إتقان أنواع الـ Constructors في لغة Dart:
// 1. Generative Constructor مع Initializer List.
// 2. Named Constructors لأغراض محددة (مثل التحويل من Map).
// 3. Redirecting Constructor لتفادي تكرار المنطق.
// 4. Factory Constructor للتحكم في إنشاء أو إعادة استخدام الكائنات المخبأة (Caching).
// ==============================================================================

class UserSession {
  final String sessionId;
  final String userId;
  final DateTime createdAt;
  final bool isGuest;

  // ذاكرة تخزين مؤقت للكائنات لإثبات مفهوم الـ Factory Caching
  static final Map<String, UserSession> _cache = {};

  // 1. Generative Constructor مع Initializer List
  UserSession._internal({
    required this.sessionId,
    required this.userId,
    required this.createdAt,
    this.isGuest = false,
  }) : assert(sessionId.isNotEmpty, 'Session ID cannot be empty');

  // 2. Named Constructor: إنشاء جلسة ضيف سريعة
  UserSession.guest()
      : sessionId = 'guest-${DateTime.now().microsecondsSinceEpoch}',
        userId = 'anonymous',
        createdAt = DateTime.now(),
        isGuest = true;

  // 3. Redirecting Constructor: يمرر البيانات للـ Constructor الرئيسي
  UserSession.standard(String sessionId, String userId)
      : this._internal(
          sessionId: sessionId,
          userId: userId,
          createdAt: DateTime.now(),
          isGuest: false,
        );

  // 4. Factory Constructor: يبحث في الكاش قبل إنشاء كائن جديد
  factory UserSession.cached(String sessionId, String userId) {
    if (_cache.containsKey(sessionId)) {
      print('⚡ [Cache Hit] تم استرجاع الجلسة القديمة للمعرف: $sessionId');
      return _cache[sessionId]!;
    }

    print('🌱 [Cache Miss] إنشاء كائن جلسة جديد وتخزينه في الكاش: $sessionId');
    final newSession = UserSession._internal(
      sessionId: sessionId,
      userId: userId,
      createdAt: DateTime.now(),
      isGuest: false,
    );
    _cache[sessionId] = newSession;
    return newSession;
  }

  // 5. Named Constructor: استخراج البيانات من قاموس (Parsing Map)
  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession._internal(
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isGuest: json['isGuest'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
        'userId': userId,
        'createdAt': createdAt.toIso8601String(),
        'isGuest': isGuest,
      };

  @override
  String toString() {
    return 'UserSession(id: $sessionId, user: $userId, guest: $isGuest, time: ${createdAt.toIso8601String()})';
  }
}

void main() {
  print('=== 🟡 كود المحاضرة 4: أنواع الـ Constructors وإدارة دورة الكائنات ===\n');

  // أ. تجربة Named Constructor للضيف
  final guestSession = UserSession.guest();
  print('1. جلسة ضيف: $guestSession');

  // ب. تجربة Redirecting Constructor
  final standardSession = UserSession.standard('sess-001', 'user-john');
  print('2. جلسة قياسية: $standardSession');

  // ج. تجربة الـ Factory Constructor مع الـ Caching
  print('\n--- تجربة الـ Factory Constructor ---');
  final sessionA = UserSession.cached('token-999', 'user-sarah');
  final sessionB = UserSession.cached('token-999', 'user-sarah');

  // فحص هل الكائنان هما نفس الكائن في الذاكرة (Memory Identity)
  print('هل الكائنان متطابقان في الذاكرة؟ identical: ${identical(sessionA, sessionB)}');

  // د. تجربة التحويل من JSON
  print('\n--- تجربة Factory fromJson ---');
  final rawData = {
    'sessionId': 'json-sess-555',
    'userId': 'user-michael',
    'createdAt': DateTime.now().toIso8601String(),
    'isGuest': false,
  };

  final parsedSession = UserSession.fromJson(rawData);
  print('الكائن المفكك من JSON: $parsedSession');
  print('إعادة تصديره إلى JSON: ${parsedSession.toJson()}');
}
