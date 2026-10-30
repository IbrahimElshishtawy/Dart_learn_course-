// ==============================================================================
// 06_benchmark_generic_specialization.dart
// Week 02 - Lecture 06: Micro-Benchmark: Lazy Iterable Chaining vs Eager List Allocation
// ==============================================================================
// الهدف: قياس الفارق في استهلاك الذاكرة والوقت بين:
// 1. المعالجة الفورية المكدسة (Eager Evaluation مع إنشاء قوائم وسيطة متعددة).
// 2. المعالجة الكسولة عبر سلاسل الـ Iterable (Lazy Chaining).
// ==============================================================================

void main() {
  print('=== ⚡ كود المحاضرة 6: مقارنة الأداء بين Lazy Iterable والقوائم المكدسة ===\n');

  const count = 1000000; // مليون عنصر
  print('حجم البيانات: $count عنصر رقمي\n');

  // 1. المعالجة الفورية المكدسة (Eager Allocation)
  // تقوم بإنشاء List جديدة كاملة في الذاكرة بعد كل عملية map و where
  final swEager = Stopwatch()..start();
  final sourceList = List<int>.generate(count, (i) => i);
  final eagerResult = sourceList
      .map((x) => x * 2)
      .toList() // حجز قائمة جديدة كاملة للمليون عنصر!
      .where((x) => x % 5 == 0)
      .toList() // حجز قائمة جديدة أخرى!
      .take(10)
      .toList();
  swEager.stop();
  final eagerMs = swEager.elapsedMilliseconds;
  print('⏱️ زمن المعالجة الفورية المكدسة (Eager toList): ${eagerMs}ms');
  print('   أول عناصر النتيجة: $eagerResult');

  // 2. المعالجة الكسولة الذكية (Lazy Iterable Pipeline)
  // لا تنشئ أي قوائم وسيطة في الرام وتعالج فقط أول 10 عناصر تحتاجها عبر take(10)
  final swLazy = Stopwatch()..start();
  final lazyResult = Iterable<int>.generate(count, (i) => i)
      .map((x) => x * 2)
      .where((x) => x % 5 == 0)
      .take(10)
      .toList(); // حجز قائمة نهائية لـ 10 عناصر فقط!
  swLazy.stop();
  final lazyMs = swLazy.elapsedMilliseconds;
  print('\n⚡ زمن المعالجة الكسولة الذكية (Lazy Pipeline): ${lazyMs}ms');
  print('   أول عناصر النتيجة: $lazyResult');

  // التحليل الهندسي
  print('\n----------------- التحليل الهندسي للأداء -----------------');
  if (lazyMs > 0) {
    final ratio = (eagerMs / lazyMs).toStringAsFixed(1);
    print('🚀 المعالجة الكسولة كانت أسرع بحوالي $ratio مرة ووفرت ملايين البايتات في الرام!');
  } else {
    print('🚀 المعالجة الكسولة استغرقت 0ms تقريباً لأنها توقفت فور الحصول على الـ 10 عناصر المطلوبة دون مسح باقي المليون!');
  }
  print('💡 الاستنتاج الهندسي: في معالجة البيانات الكبيرة وقوائم Flutter الطويلة، تجنب استدعاء .toList() في كل خطوة واعتمد على قوة الـ Iterable الكسولة.');
  print('---------------------------------------------------------');
}
