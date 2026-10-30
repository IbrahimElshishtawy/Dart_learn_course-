// ==============================================================================
// 03_advanced_immutability_equality.dart
// Week 02 - Lecture 04: Immutability, Value Objects & Structural Equality
// ==============================================================================
// الهدف:
// 1. فهم الفرق الجوهري بين المساواة في المرجع (Reference Identity) والمساواة في القيمة (Value Equality).
// 2. تطبيق الـ Immutability الكاملة باستخدام const constructor و final fields.
// 3. إعادة تعريف operator == و hashCode طبقاً لقواعد لغة Dart الرسمية.
// 4. توضيح كيف يعيد الـ Dart VM استخدام كائنات الـ const (Canonicalization).
// ==============================================================================

/// كائن قيمة غير قابل للتعديل (Immutable Value Object)
class Money {
  final int amountInCents; // تخزين الأموال في أرقام صحيحة لتفادي مشاكل الفاصلة العائمة
  final String currency;

  // Const Constructor لتمكين إنشاء الكائنات في الـ Compile-Time
  const Money(this.amountInCents, this.currency);

  const Money.zero([this.currency = 'USD']) : amountInCents = 0;

  // تحويل المبلغ لصيغة مادية مقروءة
  String get formatted =>
      '${(amountInCents / 100).toStringAsFixed(2)} $currency';

  // جمع مالي آمن يعيد كائناً جديداً دون تعديل الكائن الحالي
  Money operator +(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('لا يمكن جمع عملتين مختلفتين: $currency مع ${other.currency}');
    }
    return Money(amountInCents + other.amountInCents, currency);
  }

  // 1. إعادة تعريف الـ operator == للمساواة الهيكلية
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // تحسين أداء سريع: إذا كان نفس المرجع
    return other is Money &&
        other.amountInCents == amountInCents &&
        other.currency == currency;
  }

  // 2. الالتزام بالعقد الرياضي: إذا تساوى كائنان في == يجب أن يتساويا في الـ hashCode
  @override
  int get hashCode => Object.hash(amountInCents, currency);

  @override
  String toString() => formatted;
}

void main() {
  print('=== 🔵 كود المحاضرة 4: الكائنات غير القابلة للتعديل والمساواة الهيكلية ===\n');

  // أ. مقارنة كائنات غير const (تم إنشاؤها وقت التشغيل Runtime)
  final price1 = Money(1500, 'USD'); // $15.00
  final price2 = Money(1500, 'USD'); // $15.00

  print('--- مقارنة كائنين يحملان نفس القيمة بدون const ---');
  print('price1: $price1, price2: $price2');
  print('هل هما نفس الكائن في الذاكرة؟ identical: ${identical(price1, price2)} (False لأن لكل منهما مكان منفصل)');
  print('هل هما متساويان في القيمة؟ == : ${price1 == price2} (True بفضل operator ==)');

  // ب. مقارنة كائنات const (Canonical Instances)
  const constPrice1 = Money(2500, 'EGP');
  const constPrice2 = Money(2500, 'EGP');

  print('\n--- مقارنة كائنات const تم إنشاؤها في الـ Compile-time ---');
  print('هل هما نفس العنوان في الذاكرة؟ identical: ${identical(constPrice1, constPrice2)} (True بفضل الـ Canonicalization)');
  print('هل هما متساويان بالقيمة؟ == : ${constPrice1 == constPrice2} (True)');

  // ج. اختبار داخل Set و Map (للتأكد من صحة الـ hashCode)
  print('\n--- اختبار سلوك الكائنات كمفاتيح في Set ---');
  final walletSet = <Money>{
    const Money(5000, 'USD'),
    Money(5000, 'USD'), // كائن منفصل بنفس القيمة
    const Money(10000, 'EUR'),
  };

  print('عدد العناصر داخل الـ Set: ${walletSet.length} (المتوقع 2 لأن المكرر تم كشفه بالـ hashCode و ==)');

  // د. العمليات الحسابية الخالية من الآثار الجانبية (Pure Immutability)
  final total = price1 + Money(3000, 'USD');
  print('\nالناتج الجديد بعد الجمع: $total');
  print('هل تأثر السعر الأصلي؟ price1: $price1 (ثابت ولم يتغير إطلاقاً)');
}
