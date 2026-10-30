// ==============================================================================
// 02_intermediate_generic_constraints_covariance.dart
// Week 02 - Lecture 06: Generic Constraints & Reified Types
// ==============================================================================
// الهدف:
// 1. تقييد الأنواع المعممة (Type Bounds): فرض أن T يرث من فئة أساسية (T extends Base).
// 2. إثبات خاصية Reified Generics في Dart (الاحتفاظ بالنوع كاملاً في الذاكرة).
// 3. بناء مخزن آمن لا يقبل إلا الكائنات القابلة للتعريف (Identifiable).
// ==============================================================================

/// العقد الأساسي: أي كائن له معرف فريد ID
abstract class Identifiable {
  String get id;
}

class User implements Identifiable {
  @override
  final String id;
  final String name;

  const User(this.id, this.name);

  @override
  String toString() => 'User(id: $id, name: $name)';
}

class Product implements Identifiable {
  @override
  final String id;
  final double price;

  const Product(this.id, this.price);

  @override
  String toString() => 'Product(id: $id, price: \$$price)';
}

/// مستودع معمم مقيد: لا يقبل إلا كائنات تحقق عقد Identifiable
class Repository<T extends Identifiable> {
  final Map<String, T> _storage = {};

  void save(T item) {
    _storage[item.id] = item;
    print('💾 تم حفظ الكائن في المستودع: ${item.id}');
  }

  T? findById(String id) => _storage[id];

  List<T> getAll() => List.unmodifiable(_storage.values);
}

// -----------------------------------------------------------------------------
// دالة لإثبات أن لغة Dart تحتفظ بنوع Generics وقت التشغيل (Reified Generics)
// على عكس لغة Java التي تمسح النوع (Type Erasure)
// -----------------------------------------------------------------------------
void inspectType<E>(List<E> list) {
  print('🔍 فحص النوع وقت التشغيل: List<$E>');
  if (list is List<String>) {
    print('   -> هذه القائمة هي بالتأكيد قائمة نصوص حقيقية في الرام!');
  } else if (list is List<int>) {
    print('   -> هذه القائمة هي بالتأكيد قائمة أرقام صحيحة في الرام!');
  } else {
    print('   -> نوع عناصر القائمة الفعلي هو: $E');
  }
}

void main() {
  print('=== 🟡 كود المحاضرة 6: القيود على الأنواع و Reified Generics ===\n');

  // 1. استخدام مستودع مخصص للمستخدمين فقط
  final userRepo = Repository<User>();
  userRepo.save(const User('U-100', 'Ahmed'));
  userRepo.save(const User('U-200', 'Sara'));

  final foundUser = userRepo.findById('U-100');
  print('المستخدم المسترجع: $foundUser\n');

  // 2. استخدام مستودع مخصص للمنتجات فقط
  final productRepo = Repository<Product>();
  productRepo.save(const Product('PRD-50', 29.99));
  print('المنتجات المخزنة: ${productRepo.getAll()}\n');

  // 3. تجربة تمرير نوع لا يحقق الشرط (غير مسموح به بالمترجم):
  // final badRepo = Repository<String>(); // ❌ Compilation Error: String doesn't implement Identifiable

  // 4. اختبار Reified Types في Dart
  print('--- فحص الـ Reification في الذاكرة ---');
  final stringList = <String>['apple', 'banana'];
  final intList = <int>[1, 2, 3];

  inspectType(stringList);
  inspectType(intList);
}
