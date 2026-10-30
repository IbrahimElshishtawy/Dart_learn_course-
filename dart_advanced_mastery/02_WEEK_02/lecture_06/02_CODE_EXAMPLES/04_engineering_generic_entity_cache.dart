// ==============================================================================
// 04_engineering_generic_entity_cache.dart
// Week 02 - Lecture 06: Industrial-Grade Generic Entity Cache with TTL & LRU
// ==============================================================================
// الهدف: تطبيق معماري عملي لبناء مخزن كاش ذكي للكيانات:
// 1. تقييد النوع عبر واجهة BaseEntity.
// 2. إدارة السعة القصوى مع حذف الأقدم استخداماً (LRU Eviction).
// 3. وقت انتهاء الصلاحية للبيانات (Time-To-Live TTL).
// 4. إحصائيات الأداء (Hit Rate / Miss Rate).
// ==============================================================================

abstract class BaseEntity {
  String get id;
}

class CacheRecord<T extends BaseEntity> {
  final T entity;
  final DateTime cachedAt;
  DateTime lastAccessedAt;

  CacheRecord(this.entity)
      : cachedAt = DateTime.now(),
        lastAccessedAt = DateTime.now();

  bool isExpired(Duration ttl) =>
      DateTime.now().difference(cachedAt) > ttl;
}

class GenericEntityCache<T extends BaseEntity> {
  final int maxCapacity;
  final Duration ttl;
  final Map<String, CacheRecord<T>> _storage = {};

  int _hits = 0;
  int _misses = 0;

  GenericEntityCache({
    this.maxCapacity = 100,
    this.ttl = const Duration(minutes: 10),
  }) : assert(maxCapacity > 0, 'Capacity must be positive');

  int get currentSize => _storage.length;
  int get hits => _hits;
  int get misses => _misses;
  double get hitRate =>
      (_hits + _misses) == 0 ? 0.0 : _hits / (_hits + _misses);

  void put(T entity) {
    // 1. فحص السعة وتفريغ الأقدم استخداماً (Eviction) إذا امتلأ الكاش
    if (_storage.length >= maxCapacity && !_storage.containsKey(entity.id)) {
      _evictLeastRecentlyUsed();
    }

    _storage[entity.id] = CacheRecord<T>(entity);
  }

  T? get(String id) {
    final record = _storage[id];

    if (record == null) {
      _misses++;
      return null;
    }

    // 2. التحقق من انتهاء الصلاحية (TTL)
    if (record.isExpired(ttl)) {
      _storage.remove(id);
      _misses++;
      return null;
    }

    record.lastAccessedAt = DateTime.now();
    _hits++;
    return record.entity;
  }

  void _evictLeastRecentlyUsed() {
    if (_storage.isEmpty) return;

    String? oldestKey;
    DateTime? oldestTime;

    for (final entry in _storage.entries) {
      if (oldestTime == null ||
          entry.value.lastAccessedAt.isBefore(oldestTime)) {
        oldestTime = entry.value.lastAccessedAt;
        oldestKey = entry.key;
      }
    }

    if (oldestKey != null) {
      print('🗑️ [Cache Eviction] حذف العنصر الأقدم: $oldestKey');
      _storage.remove(oldestKey);
    }
  }

  void printStats() {
    print('📊 [Cache Metrics] الحجم: $currentSize/$maxCapacity | Hits: $_hits | Misses: $_misses | Hit Rate: ${(hitRate * 100).toStringAsFixed(1)}%');
  }
}

// -----------------------------------------------------------------------------
// نموذج بيانات تطبيقي: ملف المستخدم
// -----------------------------------------------------------------------------
class UserProfile implements BaseEntity {
  @override
  final String id;
  final String username;
  final String email;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  String toString() => 'UserProfile($username, $email)';
}

void main() {
  print('=== 🟣 كود المحاضرة 6: مخبأ الكيانات المعمم الذكي (LRU Entity Cache) ===\n');

  // إنشاء كاش بسعة صغيرة جداً (عنصرين فقط) لإثبات آلية الـ Eviction
  final cache = GenericEntityCache<UserProfile>(
    maxCapacity: 2,
    ttl: const Duration(seconds: 5),
  );

  print('1. إضافة مستخدمين اثنين إلى الكاش:');
  cache.put(const UserProfile(id: 'u1', username: 'Karim', email: 'karim@test.com'));
  cache.put(const UserProfile(id: 'u2', username: 'Sarah', email: 'sarah@test.com'));
  cache.printStats();

  print('\n2. الوصول إلى u1 (سيصبح u2 هو الأقدم الآن):');
  print('   استرجاع u1: ${cache.get('u1')}');
  cache.printStats();

  print('\n3. إضافة مستخدم ثالث u3 (يجب أن يتم طرد u2 تلقائياً):');
  cache.put(const UserProfile(id: 'u3', username: 'Mahmoud', email: 'm@test.com'));
  cache.printStats();

  print('\n4. فحص مصير المستخدم u2:');
  final checkU2 = cache.get('u2');
  print('   نتيجة البحث عن u2: ${checkU2 ?? "غير موجود (تم حذفه بنجاح بالـ LRU)"}');

  print('\n5. الإحصائيات الختامية للكاش:');
  cache.printStats();
}
