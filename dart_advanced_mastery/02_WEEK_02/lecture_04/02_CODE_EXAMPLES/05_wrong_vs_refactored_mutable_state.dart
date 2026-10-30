// ==============================================================================
// 05_wrong_vs_refactored_mutable_state.dart
// Week 02 - Lecture 04: Anti-Patterns vs Clean Refactoring in Dart OOP
// ==============================================================================
// الهدف: تدريب الطالب على اكتشاف الكود الهش (Mutable State Leaks) وكيفية
// إعادة هيكلته وفق مبادئ هندسة البرمجيات والتغليف الصارم.
// ==============================================================================

// -----------------------------------------------------------------------------
// ❌ الكود الخاطئ (Anti-Pattern): حقول عامة غير محمية تسمح بتدمير منطق العمل
// -----------------------------------------------------------------------------
class BadBankAccount {
  String accountNumber; // عام وقابل للتعديل العشوائي
  double balance;       // أي شخص يستطيع تعديل الرصيد مباشرة بدون تسجيل عملية
  List<String> transactions; // مرجع القائمة متاح للعبث الخارجي

  BadBankAccount(this.accountNumber, this.balance, this.transactions);
}

// -----------------------------------------------------------------------------
// ✅ الكود المعاد هندسته (Refactored): تغليف كامل، كائنات غير قابلة للتعديل
// -----------------------------------------------------------------------------
class GoodBankAccount {
  final String accountNumber;
  double _balance;
  final List<String> _transactions;

  GoodBankAccount({
    required this.accountNumber,
    double initialBalance = 0.0,
  })  : _balance = initialBalance >= 0 ? initialBalance : 0.0,
        _transactions = [] {
    if (accountNumber.trim().isEmpty) {
      throw ArgumentError('Account number is mandatory');
    }
    if (initialBalance > 0) {
      _transactions.add('Initial deposit: +\$$initialBalance');
    }
  }

  // قراءة الرصيد فقط (Read-only Getter)
  double get balance => _balance;

  // إرجاع نسخة غير قابلة للتعديل من العمليات لمنع التلاعب الخارجي (Defensive Copy)
  List<String> get transactions => List.unmodifiable(_transactions);

  bool deposit(double amount) {
    if (amount <= 0) {
      print('❌ عملية إيداع مرفوضة: المبلغ يجب أن يكون موجباً.');
      return false;
    }
    _balance += amount;
    _transactions.add('Deposit: +\$$amount (Balance: \$$_balance)');
    return true;
  }

  bool withdraw(double amount) {
    if (amount <= 0) {
      print('❌ عملية سحب مرفوضة: المبلغ غير صحيح.');
      return false;
    }
    if (amount > _balance) {
      print('❌ عملية سحب مرفوضة: الرصيد غير كافٍ (\$$_balance).');
      return false;
    }
    _balance -= amount;
    _transactions.add('Withdrawal: -\$$amount (Balance: \$$_balance)');
    return true;
  }
}

void main() {
  print('=== 🔴 كود مقارنة: Anti-Pattern مقابل الكود الهندسي النظيف ===\n');

  // تجربة الكود السيء
  print('--- 1. مخاطر الكود السيء (Bad Design) ---');
  final badAcc = BadBankAccount('ACC-001', 500.0, ['Initial: 500']);
  print('الرصيد الأولي: ${badAcc.balance}');

  // أي كود خارجي يستطيع تخريب الحساب دون حسيب!
  badAcc.balance = -99999.0; // كارثة: رصيد بالسالب بدون عملية سحب
  badAcc.transactions.clear(); // مسح سجل العمليات تماماً
  print('الرصيد بعد التخريب الخارجي المباشر: ${badAcc.balance}');
  print('عدد العمليات بعد التصفير: ${badAcc.transactions.length}');

  // تجربة الكود المحمي
  print('\n--- 2. أمان الكود المعاد هندسته (Good Design) ---');
  final goodAcc = GoodBankAccount(accountNumber: 'ACC-100', initialBalance: 500.0);
  print('الرصيد المحمي: \$${goodAcc.balance}');

  goodAcc.deposit(250.0);
  goodAcc.withdraw(100.0);
  goodAcc.withdraw(1000.0); // مرفوض بأمان

  print('\nسجل العمليات الرسمي المحمي:');
  for (final tx in goodAcc.transactions) {
    print('  - $tx');
  }

  // محاولة تخريب القائمة الخارجية
  print('\nمحاولة العبث بسجل العمليات من الخارج:');
  try {
    goodAcc.transactions.add('عملية وهمية مخترقة');
  } catch (e) {
    print('🛡️ تم إحباط المحاولة بنجاح بفضل List.unmodifiable!');
    print('رسالة الحماية: $e');
  }
}
