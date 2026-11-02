/// ==============================================================================
/// اسم الملف: 03_advanced_canonicalization_and_late.dart
/// الهدف التعليمي: فهم إدارة الذاكرة في Dart والفرق بين `final` و `const`،
/// وفهم توحيد الكائنات في الذاكرة (Canonicalization) باستخدام `identical()`،
/// وتشريح الميكانيكا الداخلية للكلمة المفتاحية `late` وسيناريوهات الفشل بتاعتها.
///
/// طريقة التشغيل:
///   dart run 03_advanced_canonicalization_and_late.dart
/// ==============================================================================

class ImmutableCoordinate {
  final double x;
  final double y;

  // الـ const constructor بيخلي Dart تحسب الكائن وقت الـ Compile وتوحده في الذاكرة (Canonicalization)
  const ImmutableCoordinate(this.x, this.y);

  @override
  String toString() => 'Coordinate($x, $y)';
}

class HeavyCalculationService {
  HeavyCalculationService() {
    print('>> [عملية ثقيلة ومكلفة] اشتغل الـ Constructor بتاع HeavyCalculationService وحمّل ملفات وموارد ضخمة!');
  }

  double computeMatrixEigenValue() {
    return 42.9981;
  }
}

class SystemConfig {
  // 1. التحميل الكسول (Lazy Evaluation) باستخدام 'late':
  // مش هيتعمله إنشاء في الذاكرة نهائي إلا أول ما حد يطلب يقراه!
  late final HeavyCalculationService heavyService = HeavyCalculationService();

  // 2. تأجيل التحديد من غير قيمة ابتدائية: لازم تسند له قيمة يدوياً قبل ما تحاول تقراه
  late final String encryptionKey;

  void initializeSecurity(String key) {
    encryptionKey = key;
  }
}

void main() {
  print('=== الخطوة 1: الفرق بين const و final وتوحيد الذاكرة (Canonicalization) ===');

  // هنا c1 و c2 متعرفين بـ 'const' وبنفس القيم بالمللي
  const c1 = ImmutableCoordinate(10.0, 20.0);
  const c2 = ImmutableCoordinate(10.0, 20.0);

  // هنا f1 و f2 متعرفين بـ 'final' وبيتم إنشاؤهم وقت التشغيل في الـ Heap
  final f1 = ImmutableCoordinate(10.0, 20.0);
  final f2 = ImmutableCoordinate(10.0, 20.0);

  print('c1: $c1, c2: $c2');
  print('f1: $f1, f2: $f2');

  // دالة identical() بتفحص: هل المتغيرين باصين على نفس العنوان الفيزيائي في الرام (RAM) بالضبط؟
  print('\nفحص هوية المكان في الذاكرة (Memory Identity):');
  bool constAreIdentical = identical(c1, c2);
  bool finalAreIdentical = identical(f1, f2);

  print('هل c1 و c2 نفس المكان بالضبط في الذاكرة؟ $constAreIdentical (حصل Canonicalization: نعم)');
  print('هل f1 و f2 نفس المكان في الذاكرة؟ $finalAreIdentical (مكانين منفصلين تماماً في الـ Heap: لأ)');

  print('\n=== الخطوة 2: قاعدة التوحيد الذهبية (The Canonicalization Rule) ===');
  print('أي كائن بيتعمل بـ const constructor وبنفس القيم وقت الـ Compile،');
  print('بيتعمله نسخة واحدة بس في الذاكرة وبتتشارك على مدار عمر التطبيق كله.');

  print('\n=== الخطوة 3: سحر كلمة "late" (التحميل الكسول - Lazy Evaluation) ===');
  print('دلوقتي بننشئ نسخة من SystemConfig...');
  final config = SystemConfig();
  print('تم إنشاء SystemConfig بنجاح! خد بالك إن HeavyCalculationService لسه ما اتعملش أصلاً.');

  print('\nدلوقتي هنطلب config.heavyService لأول مرة في الكود:');
  double result = config.heavyService.computeMatrixEigenValue();
  print('نتيجة الحسبة: $result');

  print('\nهنطلب config.heavyService للمرة الثانية:');
  // الـ Constructor مش هيشتغل تاني خلاص، هيستخدم نفس النسخة المتخزنة في الكاش
  double cachedResult = config.heavyService.computeMatrixEigenValue();
  print('نتيجة الحسبة من النسخة الكاش: $cachedResult');

  print('\n=== الخطوة 4: خطر "late" الكارثي: خطأ LateInitializationError ===');
  final uninitializedConfig = SystemConfig();

  try {
    // بنحاول نقرأ 'encryptionKey' قبل ما ننادي initializeSecurity()
    print('بنحاول نقرأ مفتاح التشفير: ${uninitializedConfig.encryptionKey}');
  } catch (e) {
    print('مسكنا خطأ وقت التشغيل (Runtime Exception): $e');
    print('خد بالك: المتغير مش راجع بـ null! ده ضارب خطأ قاتل اسمه LateInitializationError.');
  }

  print('\nدلوقتي هنديله القيمة بتاعته بالأصول:');
  uninitializedConfig.initializeSecurity('AES_256_GCM_SECURE_TOKEN_XYZ');
  print('قرينا المفتاح بنجاح بعد تهيئته: ${uninitializedConfig.encryptionKey}');
}

/*
================================================================================
الشرح الفني وملاحظات معمارية (بالبلدي كده)
================================================================================
1. توحيد الذاكرة (Canonicalization):
   - لما مترجم Dart يلاقي كائنات `const` واخدة نفس القيم، بيمسكهم ويدمجهم كلهم في كائن واحد
     بس في مكان قراءة ثابت في الذاكرة (Constant Pool).
   - الفايدة: توفير جبار في مساحة الرامات، وسرعة فائقة في المقارنة، لأن مقارنة مؤشرات الذاكرة
     بـ `identical()` بتاخد O(1) مقارنة بفحص كل متغير جوة الكائن سطر بسطر.

2. إيه اللي بيحصل تحت الكبوت مع كلمة `late`؟
   - الـ Dart VM بتحول المتغير اللي واخد `late` إلى دالة Getter ودالة Setter مع علامة داخلية (Flag)
     بتعرف هل المتغير ده اتملى ولا لسه.
   - أول ما تطلب المتغير، المترجم بيسأل: "هل لسه فاضي؟"
     لو آه ومعاه قيمة ابتدائية، بيشغلها مرة واحدة ويخزنها عنده.
     لو آه ومعهوش قيمة ابتدائية، بيفجر التطبيق فوراً بـ `LateInitializationError`!
   - نصيحة معمارية: استخدم `late` أساساً للخدمات الثقيلة اللي عاوز تأجل تحميلها، وماتستخدمهاش
     كحيلة رخيصة عشان تتهرب من الـ Null Safety.
================================================================================
*/
