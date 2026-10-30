# Weekly Answer Key & Model Solutions — Week 01
> **تنبيه لهيئة التدريس:** هذا الملف خاص بالمحاضرين والمساعدين، ويحتوي على الحلول النموذجية للاختبار الشامل، والتحدي المعماري، والتحدي الخوارزمي للأسبوع الأول.

---

## 1. نموذج إجابة الاختبار الشامل (Weekly Exam 01)

### القسم الأول: الأسئلة النظرية
1. **خط إنتاج المترجم:** يبدأ الكود كـ Source Code، يمر على CFE (Common Front End) لإنتاج الـ AST والتحقق من الأنواع، ثم يتحول لـ Kernel Binary (`.dill`). في بيئة التطوير يُشغل بواسطة Dart VM JIT لدعم الـ Hot Reload، وفي بيئة الإنتاج يُترجم مسبقاً بواسطة AOT إلى Native Machine Code مباشر خالٍ من الـ VM Overhead.
2. **المقارنة:**
   - `var`: استنتاج نوع ساكن وقت الـ Compile time لا يقبل التغيير.
   - `Object`: أصل الشجرة غير القابل للـ null، يتيح فقط دوال الكائن الأساسية ويخضع للتحقق الساكن.
   - `dynamic`: تعطيل كامل للتحقق الساكن وتأجيل فحص الدوال للـ Runtime.
   - `Never`: نوع القاع الذي يمثل استحالة رجوع قيمة من الدالة (Non-terminating / Throwing).
3. **معجزة Sound Null Safety:** المترجم يمتلك برهاناً رياضياً على استحالة تخزين null في متغير غير Nullable، مما يسمح بحذف شفرات فحص null الزائدة أثناء التجميع (Dead Code Elimination) وتصغير حجم الملف التنفيذي وتسريع الوصول للذاكرة.
4. **الـ Lexical Closure في الذاكرة:** المتغيرات التي تلتقطها دالة closure يتم ترحيلها بواسطة Dart VM من الـ Stack إلى الـ Heap Memory داخل Scope Context كائن، ويظل حياً طالما أن دالة الـ Closure تمتلك مرجعاً إليه، مما يمنع حذفه عند خروج الـ Stack Frame.
5. **الـ Records والمساواة:** الـ Records بنى بيانات مجمعة ومصمتة لا تحتاج تعريف كلاس، وتتميز بالمساواة الهيكلية (Structural Equality) حيث يتساوى سجلان إذا تساوت أنواعهما وقيم حقولهما دون النظر لمكانهما الفيزيائي في الذاكرة.

### القسم الثاني: تتبع الكود
6. **سؤال 6:**
   - `identical(p1, p2)` $\rightarrow$ `true` (توحيد Canonicalization).
   - `identical(p1, p3)` $\rightarrow$ `false` (final في مكان منفصل).
   - `p1 == p3` $\rightarrow$ `true` (المساواة الهيكلية للـ Records).
7. **سؤال 7:** الناتج: `15 - 25 - 25` (لأن كلا الـ Closures يلتقطان نفس المتغير `x` المشترك في النطاق الخارجي).
8. **سؤال 8:** الناتج: `'SERVER_ERROR'` ثم `'LIST_HEAD_ROOT_TAIL_2'`.
9. **سؤال 9:** يمر بنجاح تام من الـ Compiler لأن الفئتين `Circle` و`Square` هما فقط المشتقات من `sealed class Shape`، وبالتالي الـ Switch Expression استوفت شرط الـ Exhaustiveness بالكامل.
10. **سؤال 10:** الناتج: `a, b, A, B`.

### القسم الثالث: تصحيح الأخطاء
11. **سؤال 11 (المصحح):**
    ```dart
    enum UserTier { standard, gold }

    class DiscountCalculator {
      final UserTier userTier;
      const DiscountCalculator({required this.userTier});

      double calculate(double cartTotal, String? promo) {
        if (promo == 'VIP100') return cartTotal;
        return switch (userTier) {
          UserTier.gold => cartTotal * 0.20,
          UserTier.standard => 0.0,
        };
      }
    }
    ```
12. **سؤال 12 (المصحح باستخدام Pattern Matching الآمن):**
    ```dart
    String formatUserData(Object? json) {
      if (json case {'user': {'name': String name, 'score': int score}}) {
        return '$name has score $score';
      }
      return 'GUEST has score 0';
    }
    ```

### القسم الرابع: التصميم البرمجي التطبيقي (سؤال 13)
```dart
typedef BankTx = (String id, double amount, String sourceCountry);

Never rejectTransaction(String reason) {
  throw ArgumentError('TRANSACTION_REJECTED: $reason');
}

String routeBankTransfer(BankTx tx) {
  final (id, amount, country) = tx;
  if (amount <= 0) {
    rejectTransaction('Invalid non-positive amount: $amount');
  }

  return switch ((country, amount)) {
    ('EGYPT', > 100000.0) => 'LOCAL_HIGH_VALUE_AUDIT',
    ('EGYPT', _) => 'LOCAL_STANDARD_CLEARING',
    (_, _) => 'INTERNATIONAL_CROSS_BORDER',
  };
}
```

---

## 2. حل التحدي المعماري (Weekly Architecture Challenge 01)

```dart
sealed class TelemetryEvent {}

class PaymentReceived extends TelemetryEvent {
  final String txId;
  final double amount;
  final String currency;
  PaymentReceived(this.txId, this.amount, this.currency);
}

class PaymentRefunded extends TelemetryEvent {
  final String txId;
  final double amount;
  final String reason;
  PaymentRefunded(this.txId, this.amount, this.reason);
}

class SystemHeartbeat extends TelemetryEvent {
  final int uptimeSeconds;
  final double cpuUsage;
  SystemHeartbeat(this.uptimeSeconds, this.cpuUsage);
}

typedef AggregatedState = ({double totalVolume, int paymentsCount, int refundsCount});

AggregatedState aggregateTelemetry(AggregatedState current, TelemetryEvent event) {
  return switch (event) {
    PaymentReceived(:final amount) => (
        totalVolume: current.totalVolume + amount,
        paymentsCount: current.paymentsCount + 1,
        refundsCount: current.refundsCount,
      ),
    PaymentRefunded(:final amount) => (
        totalVolume: current.totalVolume - amount,
        paymentsCount: current.paymentsCount,
        refundsCount: current.refundsCount + 1,
      ),
    SystemHeartbeat() => current, // Heartbeat does not alter financial state
  };
}
```

---

## 3. حل التحدي الخوارزمي (Weekly Problem Solving Challenge 01)

```dart
typedef SubarrayProductResult = ({int maxProduct, int startIndex, int endIndex});

int maxProductSubarray(List<int> nums) {
  if (nums.isEmpty) return 0;

  int maxSoFar = nums[0];
  int minSoFar = nums[0];
  int globalMax = nums[0];

  for (int i = 1; i < nums.length; i++) {
    final current = nums[i];

    // If negative, multiply with min makes it max, and vice versa!
    if (current < 0) {
      (maxSoFar, minSoFar) = (minSoFar, maxSoFar);
    }

    maxSoFar = current > (maxSoFar * current) ? current : (maxSoFar * current);
    minSoFar = current < (minSoFar * current) ? current : (minSoFar * current);

    if (maxSoFar > globalMax) {
      globalMax = maxSoFar;
    }
  }

  return globalMax;
}

void main() {
  assert(maxProductSubarray([2, 3, -2, 4]) == 6);
  assert(maxProductSubarray([-2, 0, -1]) == 0);
  assert(maxProductSubarray([-2, 3, -4]) == 24);
  print('Weekly Problem Solving Solution verified successfully!');
}
```
