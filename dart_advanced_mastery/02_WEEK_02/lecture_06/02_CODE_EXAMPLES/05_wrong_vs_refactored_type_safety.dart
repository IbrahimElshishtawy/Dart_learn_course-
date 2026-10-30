// ==============================================================================
// 05_wrong_vs_refactored_type_safety.dart
// Week 02 - Lecture 06: dynamic Anti-Pattern vs Compile-Time Type Safety
// ==============================================================================
// الهدف: مقارنة عملية بين استخدام dynamic (تأجيل كشف الأخطاء لوقت التشغيل)
// واستخدام Generics (كشف ومنع الأخطاء في وقت الترجمة Compile-time).
// ==============================================================================

// -----------------------------------------------------------------------------
// ❌ الكود الخاطئ (Anti-Pattern): استخدام dynamic أو Object بدون نوع معمم
// -----------------------------------------------------------------------------
class BadBag {
  final List<dynamic> _items = [];

  void add(dynamic item) => _items.add(item);
  dynamic get(int index) => _items[index];
}

// -----------------------------------------------------------------------------
// ✅ الكود الهندسي النظيف (Refactored): استخدام Generics <T> الصريحة
// -----------------------------------------------------------------------------
class GoodBag<T> {
  final List<T> _items = [];

  void add(T item) => _items.add(item);
  T get(int index) => _items[index];
  int get length => _items.length;
}

void main() {
  print('=== 🔴 كود المقارنة: مخاطر dynamic مقابل أمان الـ Generics ===\n');

  // تجربة الكود السيء
  print('--- 1. الكود الخاطئ مع dynamic ---');
  final badBag = BadBag();
  badBag.add('كتاب دارت');
  badBag.add(999); // تم قبول رقم في نفس الحقيبة دون أي اعتراض!

  print('العنصر 0: ${badBag.get(0)}');
  print('العنصر 1: ${badBag.get(1)}');

  // محاولة التعامل مع العناصر بنية أنها نصوص (كارثة وقت التشغيل):
  try {
    for (var i = 0; i < 2; i++) {
      final text = badBag.get(i) as String; // 💥 سيفشل عند الرقم 999
      print('طول النص: ${text.length}');
    }
  } catch (e) {
    print('💥 كارثة وقت التشغيل (Runtime Crash): $e');
  }

  // تجربة الكود النظيف مع Generics
  print('\n--- 2. الكود الآمن مع GoodBag<String> ---');
  final safeBag = GoodBag<String>();
  safeBag.add('كتاب فلاتر متقدم');
  // safeBag.add(500); // ❌ هذا السطر لن يمر من المترجم إطلاقاً (Compile Error)

  for (var i = 0; i < safeBag.length; i++) {
    // لا نحتاج إلى `as String` لأن المترجم يعرف نوع العنصر تلقائياً
    final text = safeBag.get(i);
    print('النص الآمن: $text | طوله: ${text.length}');
  }

  print('\n✅ النتيجة: وفرت الـ Generics حماية مطلقة بنسبة 100% ومنعت حدوث كراش في الإنتاج.');
}
