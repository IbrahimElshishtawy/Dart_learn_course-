// ==============================================================================
// 06_performance_const_vs_new_instances.dart
// Week 02 - Lecture 04: Micro-Benchmark: const Canonical vs Runtime Allocation
// ==============================================================================
// الهدف: قياس الفارق الزمني وضغط الذاكرة (Memory Allocation) بين إنشاء
// كائنات const معادة الاستخدام (Canonical) وإنشاء كائنات جديدة في كل تكرار.
// ==============================================================================

class ImmutableThemeColor {
  final int red;
  final int green;
  final int blue;

  const ImmutableThemeColor(this.red, this.green, this.blue);
}

class MutableThemeColor {
  int red;
  int green;
  int blue;

  MutableThemeColor(this.red, this.green, this.blue);
}

void main() {
  print('=== ⚡ كود المحاضرة 4: مقارنة الأداء بين const والكائنات العادية ===\n');

  const iterations = 5000000; // 5 ملايين تكرار
  print('عدد التكرارات في الاختبار: $iterations عملية إنشاء كائن\n');

  // 1. اختبار الكائنات غير الـ const (تخصيص مستمر في الـ Heap)
  final stopwatchMutable = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    // كائن جديد يتم حجز مكان جديد له في كل لفة
    final _ = MutableThemeColor(33, 150, 243);
  }
  stopwatchMutable.stop();
  final mutableTime = stopwatchMutable.elapsedMilliseconds;
  print('⏱️ زمن إنشاء 5 ملايين كائن عادي في الـ Heap: ${mutableTime}ms');

  // 2. اختبار كائنات const (مرجع وحيد معاد استخدامه Canonical)
  final stopwatchConst = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    // نفس الكائن المترجم مسبقاً يعاد استخدامه دون تخصيص ذاكرة إضافية
    const _ = ImmutableThemeColor(33, 150, 243);
  }
  stopwatchConst.stop();
  final constTime = stopwatchConst.elapsedMilliseconds;
  print('⚡ زمن إعادة استخدام كائن const لـ 5 ملايين مرة: ${constTime}ms');

  // التحليل الهندسي
  print('\n----------------- التحليل الهندسي للأداء -----------------');
  if (constTime > 0) {
    final speedup = (mutableTime / constTime).toStringAsFixed(1);
    print('🚀 كائنات const كانت أسرع بحوالي $speedup مرة من الحجز العادي!');
  } else {
    print('🚀 كائنات const استغرقت 0ms تقريباً لأنها لا تستهلك أي وقت تخصيص في الـ Heap!');
  }
  print('💡 الاستنتاج في بيئة Flutter و Dart: استخدام const constructors في الواجهات والبيانات الثابتة يقلل الضغط على Garbage Collector ويمنع تسقيط الفريمات (Jank).');
  print('---------------------------------------------------------');
}
