// ==============================================================================
// 03_advanced_custom_iterables_collections.dart
// Week 02 - Lecture 06: Custom Iterables & Lazy Evaluation
// ==============================================================================
// الهدف:
// 1. فهم كيف تعمل الـ Collections من الداخل عبر واجهتي Iterable و Iterator.
// 2. إثبات مفهوم الـ Lazy Evaluation: العمليات لا تنفذ إلا عند الحاجة إليها.
// 3. بناء مولد متسلسلات حسابية لا نهائي باستخدام sync* و yield.
// ==============================================================================

/// مولد أرقام فيبوناتشي متتابع وكسول (Lazy Infinite Fibonacci Sequence)
Iterable<int> fibonacciSequence() sync* {
  var a = 0;
  var b = 1;
  while (true) {
    yield a;
    final next = a + b;
    a = b;
    b = next;
  }
}

/// مجموعة مخصصة تمثل نطاق أرقام دون حجز مساحة لكل رقم في الذاكرة (Memory Efficient Range)
class NumberRange extends Iterable<int> {
  final int start;
  final int end;
  final int step;

  NumberRange(this.start, this.end, [this.step = 1])
      : assert(step > 0, 'Step must be positive');

  @override
  Iterator<int> get iterator => _NumberRangeIterator(start, end, step);
}

class _NumberRangeIterator implements Iterator<int> {
  final int _end;
  final int _step;
  int _current;
  bool _hasStarted = false;

  _NumberRangeIterator(int start, this._end, this._step) : _current = start;

  @override
  int get current => _current;

  @override
  bool moveNext() {
    if (!_hasStarted) {
      _hasStarted = true;
      return _current <= _end;
    }

    if (_current + _step <= _end) {
      _current += _step;
      return true;
    }
    return false;
  }
}

void main() {
  print('=== 🔵 كود المحاضرة 6: المجموعات المخصصة والتنفيذ الكسول (Lazy Iterables) ===\n');

  // 1. استخدام النطاق المخصص
  print('1. تكرار عبر NumberRange(1, 10, 2):');
  final range = NumberRange(1, 10, 2);
  for (final num in range) {
    print('   -> الرقم: $num');
  }

  // 2. إثبات الـ Lazy Evaluation: معالجة متتالية بدون حجز قوائم وسيطة في الرام
  print('\n2. استخدام دالات التحويل الكسولة (map, where, take):');
  final pipeline = range
      .map((n) {
        print('      [Lazy Map] معالجة الرقم: $n');
        return n * 10;
      })
      .where((n) => n > 30)
      .take(2);

  print('   تم إنشاء الـ Pipeline (لم تنفذ أي دالة map حتى الآن!)');
  print('   الآن سنبدأ القراءة الفعلية عبر toList():');
  final resultList = pipeline.toList();
  print('   النتيجة النهائية: $resultList\n');

  // 3. سحب أول 10 أرقام من متسلسلة فيبوناتشي اللانهائية
  print('3. سحب أول 8 أرقام من متسلسلة فيبوناتشي الكسولة:');
  final first8Fib = fibonacciSequence().take(8).toList();
  print('   أول 8 أرقام: $first8Fib');
}
