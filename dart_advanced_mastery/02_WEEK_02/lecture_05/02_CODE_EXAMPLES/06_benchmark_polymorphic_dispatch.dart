// ==============================================================================
// 06_benchmark_polymorphic_dispatch.dart
// Week 02 - Lecture 05: Benchmark: Polymorphic Dispatch vs Direct Monomorphic Call
// ==============================================================================
// الهدف: قياس سرعة استدعاء الدوال المتعددة الأشكال (Polymorphic vtable lookup)
// مقارنة بالاستدعاء المباشر لنفس الكلاس، وتوضيح كيف يقوم الـ Dart JIT/AOT
// بعمل Inline Caching لتحقيق سرعة فائقة.
// ==============================================================================

abstract class CalculationTask {
  int execute(int a, int b);
}

class AddTask implements CalculationTask {
  @override
  int execute(int a, int b) => a + b;
}

class MultiplyTask implements CalculationTask {
  @override
  int execute(int a, int b) => a * b;
}

void main() {
  print('=== ⚡ كود المحاضرة 5: قياس أداء استدعاء الدوال المتعددة الأشكال ===\n');

  const iterations = 10000000; // 10 ملايين عملية
  print('عدد التكرارات: $iterations عملية استدعاء دالة\n');

  // 1. الاستدعاء المباشر الأحادي (Monomorphic Direct Dispatch)
  final directTask = AddTask();
  final swDirect = Stopwatch()..start();
  var sum1 = 0;
  for (var i = 0; i < iterations; i++) {
    sum1 += directTask.execute(i, 2);
  }
  swDirect.stop();
  final directMs = swDirect.elapsedMilliseconds;
  print('⏱️ زمن الاستدعاء المباشر الأحادي: ${directMs}ms (المجموع: $sum1)');

  // 2. الاستدعاء المتعدد الأشكال (Polymorphic Dispatch)
  final tasks = <CalculationTask>[AddTask(), MultiplyTask()];
  final swPoly = Stopwatch()..start();
  var sum2 = 0;
  for (var i = 0; i < iterations; i++) {
    // تبديل النوع في كل لفة لتحدي محرك الـ Dart VM
    final task = tasks[i & 1];
    sum2 += task.execute(i, 2);
  }
  swPoly.stop();
  final polyMs = swPoly.elapsedMilliseconds;
  print('⚡ زمن الاستدعاء المتعدد الأشكال عبر الواجهة: ${polyMs}ms (المجموع: $sum2)');

  print('\n----------------- التحليل الهندسي لمحرك Dart VM -----------------');
  print('💡 محرك Dart AOT/JIT يستخدم تقنية متطورة تسمى (Polymorphic Inline Caching).');
  print('   الفرق الزمني بين الاستدعاء المباشر والمتعدد الأشكال ضئيل جداً بالنانوثانية،');
  print('   مما يعني أن استخدام الواجهات والتجريد في Dart لا يمثل أي عائق في أداء التطبيقات،');
  print('   بينما يمنح الكود مرونة معمارية هائلة وقابلية للتوسع والاختبار (Clean Architecture).');
  print('-----------------------------------------------------------------');
}
