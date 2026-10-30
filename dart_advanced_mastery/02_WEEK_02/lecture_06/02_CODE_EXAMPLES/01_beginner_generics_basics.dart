// ==============================================================================
// 01_beginner_generics_basics.dart
// Week 02 - Lecture 06: Generics Fundamentals & Type Safety
// ==============================================================================
// الهدف:
// 1. فهم لماذا نحتاج إلى Generics بدلاً من dynamic أو Object.
// 2. بناء كلاس معمم (Generic Box<T>) يتعامل مع أي نوع بأمان تام.
// 3. كتابة دوال معممة (Generic Functions) تقبل وترجع أنواعاً محددة تلقائياً.
// ==============================================================================

/// كلاس معمم يمثل صندوقاً آمناً لحفظ قيمة واحدة من أي نوع T
class Box<T> {
  final T content;
  final DateTime storedAt;

  Box(this.content) : storedAt = DateTime.now();

  T unpack() {
    print('📦 فتح الصندوق واستخراج محتوى من نوع: ${content.runtimeType}');
    return content;
  }

  void describe() {
    print('Box<$T> يحتوي على: $content تم تخزينه في: $storedAt');
  }
}

/// دالة معممة لدمج عنصرين في زوج مرتب (Pair)
class Pair<A, B> {
  final A first;
  final B second;

  const Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';
}

/// دالة مستقلة معممة لعكس ترتيب عناصر أي قائمة وإرجاع قائمة من نفس النوع بدقة
List<E> reverseList<E>(List<E> source) {
  final result = <E>[];
  for (var i = source.length - 1; i >= 0; i--) {
    result.add(source[i]);
  }
  return result;
}

void main() {
  print('=== 🟢 كود المحاضرة 6: مدخل إلى الأنواع المعممة (Generics) والأمان النوعي ===\n');

  // 1. استخدام Box مع أرقام صحيحة (Type Safe int)
  final intBox = Box<int>(42);
  final number = intBox.unpack();
  // المترجم يعرف أن number هو int بنسبة 100% ويسمح بالعمليات الحسابية:
  print('ضعف الرقم: ${number * 2}\n');

  // 2. استخدام Box مع نصوص (Type Safe String)
  final strBox = Box<String>('Dart Mastery');
  final text = strBox.unpack();
  // المترجم يعرف أن text هو String ويسمح بدوال النصوص مباشرة دون أي Type Cast:
  print('النص بأحرف كبيرة: ${text.toUpperCase()}\n');

  // 3. استخدام كلاس Pair بنوعين مختلفين
  final studentScore = Pair<String, double>('Ahmed', 98.5);
  final coord = Pair<int, int>(1920, 1080);
  print('زوج الطالب والدرجة: $studentScore');
  print('زوج إحداثيات الشاشة: $coord\n');

  // 4. استخدام الدالة المعممة reverseList
  final names = ['Sara', 'Mona', 'Ali'];
  final reversedNames = reverseList(names);
  print('القائمة المعكوسة: $reversedNames');
  // المترجم يضمن أن reversedNames من نوع List<String>
}
