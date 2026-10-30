// ==============================================================================
// lecture_04_solutions.dart
// Week 02 - Lecture 04: Official Problem Solving Solutions
// ==============================================================================

// -----------------------------------------------------------------------------
// حل المسألة 1: نموذج الصندوق المحمي (Secure Bank Vault)
// -----------------------------------------------------------------------------
class Vault {
  final String vaultId;
  final int _pinCode;
  double _balance;

  Vault({
    required this.vaultId,
    required int pinCode,
    double initialBalance = 0.0,
  })  : _pinCode = pinCode,
        _balance = initialBalance >= 0 ? initialBalance : 0.0 {
    if (vaultId.trim().isEmpty) {
      throw ArgumentError('Vault ID cannot be empty');
    }
  }

  bool _isAuthorized(int pin) => pin == _pinCode;

  double checkBalance(int pin) {
    if (!_isAuthorized(pin)) {
      throw StateError('⛔ Access Denied: Invalid PIN code');
    }
    return _balance;
  }

  bool deposit(int pin, double amount) {
    if (!_isAuthorized(pin)) {
      print('❌ Deposit rejected: Invalid PIN');
      return false;
    }
    if (amount <= 0) {
      print('❌ Deposit rejected: Amount must be positive');
      return false;
    }
    _balance += amount;
    return true;
  }

  bool withdraw(int pin, double amount) {
    if (!_isAuthorized(pin)) {
      print('❌ Withdrawal rejected: Invalid PIN');
      return false;
    }
    if (amount <= 0 || amount > _balance) {
      print('❌ Withdrawal rejected: Invalid amount or insufficient balance');
      return false;
    }
    _balance -= amount;
    return true;
  }
}

// -----------------------------------------------------------------------------
// حل المسألة 2: تتبع سلة التسوق الذكية (Immutable Shopping Cart)
// -----------------------------------------------------------------------------
class CartItem {
  final String id;
  final String title;
  final int unitPriceInCents;
  final int quantity;

  const CartItem({
    required this.id,
    required this.title,
    required this.unitPriceInCents,
    this.quantity = 1,
  }) : assert(quantity > 0, 'Quantity must be positive');

  int get totalInCents => unitPriceInCents * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      unitPriceInCents: unitPriceInCents,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          other.id == id &&
          other.title == title &&
          other.unitPriceInCents == unitPriceInCents &&
          other.quantity == quantity;

  @override
  int get hashCode => Object.hash(id, title, unitPriceInCents, quantity);
}

class ShoppingCart {
  final List<CartItem> _items;

  const ShoppingCart([List<CartItem> items = const []]) : _items = items;

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalInCents =>
      _items.fold(0, (sum, item) => sum + item.totalInCents);

  ShoppingCart addItem(CartItem newItem) {
    final existingIndex = _items.indexWhere((item) => item.id == newItem.id);

    if (existingIndex >= 0) {
      final updatedList = List<CartItem>.from(_items);
      final currentItem = updatedList[existingIndex];
      updatedList[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + newItem.quantity,
      );
      return ShoppingCart(updatedList);
    } else {
      return ShoppingCart([..._items, newItem]);
    }
  }
}

// -----------------------------------------------------------------------------
// حل المسألة 3: مخبأ الكائنات الفريد (Design Pattern: Flyweight Shape Cache)
// -----------------------------------------------------------------------------
class CircleSpec {
  final double radius;
  final String color;

  static final Map<String, CircleSpec> _cache = {};

  const CircleSpec._internal(this.radius, this.color);

  factory CircleSpec.cached(double radius, String color) {
    final key = '$radius-$color';
    return _cache.putIfAbsent(key, () => CircleSpec._internal(radius, color));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CircleSpec && other.radius == radius && other.color == color;

  @override
  int get hashCode => Object.hash(radius, color);
}

// -----------------------------------------------------------------------------
// كود التحقق الذاتي والاختبارات
// -----------------------------------------------------------------------------
void main() {
  print('=== 🧪 تشغيل حلول وتأكيدات مسائل المحاضرة 4 ===');

  // 1. اختبار Vault
  final vault = Vault(vaultId: 'V-001', pinCode: 1234, initialBalance: 1000.0);
  assert(vault.deposit(1234, 500.0) == true);
  assert(vault.checkBalance(1234) == 1500.0);
  assert(vault.withdraw(1234, 200.0) == true);
  assert(vault.checkBalance(1234) == 1300.0);
  assert(vault.withdraw(9999, 200.0) == false); // Invalid PIN
  print('✅ المسألة 1 (Secure Vault): تم التحقق واجتياز جميع الشروط.');

  // 2. اختبار ShoppingCart
  var cart = const ShoppingCart();
  cart = cart.addItem(const CartItem(id: 'item1', title: 'Dart Book', unitPriceInCents: 2000, quantity: 1));
  assert(cart.totalInCents == 2000);
  assert(cart.items.length == 1);

  // إضافة نفس العنصر يجب أن يدمج الكمية
  cart = cart.addItem(const CartItem(id: 'item1', title: 'Dart Book', unitPriceInCents: 2000, quantity: 2));
  assert(cart.totalInCents == 6000);
  assert(cart.items.first.quantity == 3);
  assert(cart.items.length == 1);
  print('✅ المسألة 2 (Immutable Cart): تم التحقق واجتياز دمج العناصر و Immutability.');

  // 3. اختبار CircleSpec Flyweight Cache
  final c1 = CircleSpec.cached(10.0, 'RED');
  final c2 = CircleSpec.cached(10.0, 'RED');
  final c3 = CircleSpec.cached(15.0, 'BLUE');

  assert(identical(c1, c2) == true); // نفس المرجع في الذاكرة
  assert(identical(c1, c3) == false);
  print('✅ المسألة 3 (Flyweight Cache): تم التحقق واجتياز مطابقة الذاكرة identical.');

  print('\n🎉 جميع حلول المحاضرة 4 سليمة وجاهزة 100%!');
}
