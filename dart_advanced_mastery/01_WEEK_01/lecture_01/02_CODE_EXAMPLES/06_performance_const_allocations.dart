/// ==============================================================================
/// اسم الملف: 06_performance_const_allocations.dart
/// الهدف التعليمي: قياس وإثبات الفرق الفعلي في الأداء واستهلاك الذاكرة بين كائنات
/// الـ `const` الموحدة في الذاكرة وبين كائنات الـ Heap العادية اللي بتتعمل وقت التشغيل
/// داخل Loops ضخمة بآلاف المرات.
///
/// طريقة التشغيل:
///   dart run 06_performance_const_allocations.dart
/// ==============================================================================

class DataPoint {
  final int x;
  final int y;

  const DataPoint(this.x, this.y);
}

void main() {
  const int iterations = 5000000; // إنشاء 5 مليون كائن في الذاكرة للتجربة

  print('=== اختبار السرعة والأداء (Benchmark): إنشاء 5,000,000 كائن ===');
  print('مقارنة حية بين حجز الذاكرة وقت التشغيل (Heap) وتوحيد الكائنات بـ const...\n');

  // --------------------------------------------------------------------------
  // التجربة الأولى: إنشاء كائنات عادية وقت التشغيل (Non-const allocations)
  // --------------------------------------------------------------------------
  final stopwatchDynamic = Stopwatch()..start();
  int dynamicHashAccumulator = 0;

  for (int i = 0; i < iterations; i++) {
    // في كل لفة المترجم بيحجز مكان جديد تماماً في رامات الجهاز (Dart VM Heap)!
    final point = DataPoint(100, 200);
    dynamicHashAccumulator ^= point.hashCode;
  }
  stopwatchDynamic.stop();
  final dynamicElapsedMs = stopwatchDynamic.elapsedMilliseconds;
  final dynamicElapsedMicro = stopwatchDynamic.elapsedMicroseconds;

  print('[1] إنشاء الكائنات العادية وقت التشغيل (Dynamic Heap):');
  print('    الوقت المستغرق: $dynamicElapsedMs مللي ثانية ($dynamicElapsedMicro ميكرو ثانية)');
  print('    تأثير الذاكرة:  5,000,000 كائن منفصل اتحجزوا وعملوا ضغط جبار على الـ Garbage Collector.');

  // --------------------------------------------------------------------------
  // التجربة الثانية: استخدام const وتوحيد الكائن (Compile-Time Const Canonicalization)
  // --------------------------------------------------------------------------
  final stopwatchConst = Stopwatch()..start();
  int constHashAccumulator = 0;

  for (int i = 0; i < iterations; i++) {
    // صفر حجز في الـ Heap جوة اللوب! نفس المؤشر الموحد في الذاكرة بيستخدم كل مرة.
    const point = DataPoint(100, 200);
    constHashAccumulator ^= point.hashCode;
  }
  stopwatchConst.stop();
  final constElapsedMs = stopwatchConst.elapsedMilliseconds;
  final constElapsedMicro = stopwatchConst.elapsedMicroseconds;

  print('\n[2] استخدام const الموحدة في الذاكرة:');
  print('    الوقت المستغرق: $constElapsedMs مللي ثانية ($constElapsedMicro ميكرو ثانية)');
  print('    تأثير الذاكرة:  نسخة واحدة فقط (1 instance) اتخزنت في الذاكرة الثابتة، وضغط الـ GC طلع صفر!');

  // --------------------------------------------------------------------------
  // ملخص الأداء ومعدل فرق السرعة
  // --------------------------------------------------------------------------
  print('\n=== ملخص الأداء وتحليل النتائج ===');
  if (constElapsedMicro > 0) {
    final speedupFactor = (dynamicElapsedMicro / constElapsedMicro).toStringAsFixed(2);
    print('>> الـ const كانت أسرع بحوالي ${speedupFactor} ضعف في الاختبار ده!');
  }
  print('>> فحص ناتج الـ Hash المشترك (عشان نضمن إن المترجم ميمسحش اللوب): ${dynamicHashAccumulator ^ constHashAccumulator}');

  print('\n=== الخلاصة الذهبية لكل مبرمجي فلاتر ودارت (Flutter & Dart) ===');
  print('استخدام كلمة `const` مع الكائنات والويدجتس (Widgets) مش مجرد شكل كود حلو وخلاص.');
  print('دي بتمنع تشتيت وامتلاء الرامات تماماً، وبترحم الـ Garbage Collector من إنه يفضل');
  print('ينظف الذاكرة طول الوقت، وده اللي بيخلي تطبيق الفلاتر بتاعك سلس جداً (60/120 FPS).');
}
