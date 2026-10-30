# Programming Logic & Engineering Challenges — Lecture 01

تختبر هذه التحديات قدرتك على التفكير كمهندس برمجيات محترف يصمم كوداً يتجاوز مجرد مطابقة الـ Syntax إلى معايير الأمان الرياضي، الأداء، وقابلية الصيانة.

---

### Challenge 1 (Mathematical & Security): Financial Precision & Negative Drift
- **The Problem:**
  بناء نظام خصم عمولات مصرفية بنسبة $2.5\%$ على دفعات العملاء بالجنيه المصري، وتفادي مشاكل الفاصلة العائمة (Floating-point representation errors) التي تؤدي لضياع قروش في المعاملات المليونية.
- **Requirements:**
  1. حساب النسبة بدقة قاطعة دون أي انحراف في الأرقام العشرية.
  2. منع الحسابات السالبة أو غير المحددة (NaN / Infinity).
  3. حماية العمليات من تجاوز الحدود العليا (Integer Overflow).
- **Bad Implementation (السيئ):**
  ```dart
  double calculateFeeBad(double amount) {
    // خطأ فادح: استخدام double يسبب انحرافاً مثل 0.07500000000000001
    return amount * 0.025;
  }
  ```
- **Why It Is Bad:**
  أرقام الـ `double` تخضع لمعيار IEEE-754 الثنائي؛ الكسور العشرية مثل `0.1` لا يمكن تمثيلها بدقة في النظام الثنائي. بعد مليون عملية، تتجمع فروق القروش وتحدث عجزاً في الحساب الختامي للبنك.
- **Better Implementation (المعماري المعتمد):**
  ```dart
  int calculateFeeStrictInPiasters(int amountInPiasters) {
    if (amountInPiasters <= 0) {
      throw ArgumentError('Transaction amount must be strictly positive');
    }
    // حساب الرسوم في القروش عبر الضرب أولاً ثم القسمة لتجنب الكسور
    // Fee = 2.5% = 25 / 1000 = amount * 25 ~/ 1000
    // نستخدم round-half-up بإضافة 500 قبل القسمة
    final feePiasters = ((amountInPiasters * 25) + 500) ~/ 1000;
    return feePiasters;
  }
  ```
- **Explanation:**
  التعامل مع العملات كأعداد صحيحة (`int` تمثل القروش / Piasters أو Cents) يلغي تماماً أي خطأ في الفاصلة العائمة، ويجعل كل عملية حسابية حتمية بنسبة 100%.
- **Trade-offs:**
  الحسابات تتطلب تحويل المبلغ إلى قروش عند الإدخال وتحويله للعرض بالجنيه عند الطباعة فقط.
- **Testing Strategy:**
  اختبار مدخلات حدية: 1 قرش، 99 قرش، 1,000,000 جنيه، وتأكيد عدم وجود أي كسور ضائعة.

---

### Challenge 2 (Security & Defensive Flow): Untrusted Network Payload Sanitization
- **The Problem:**
  استقبال كائن JSON خام من سيرفر خارجي غير موثوق يحتوي على بيانات حساب بنكي قد تحمل قيماً `null`، أو نصوصاً فارغة، أو أنواعاً غير متطابقة.
- **Requirements:**
  1. استخراج حقول `id` و`username` و`creditLimit`.
  2. ضمان عدم حدوث أي Runtime Exception (مثل `TypeError` أو `NoSuchMethodError`).
  3. إنتاج كائن `ImmutableAccount` آمن للاستخدام الداخلي.
- **Bad Implementation (السيئ):**
  ```dart
  class AccountBad {
    final String id;
    final String username;
    final double creditLimit;

    AccountBad.fromJson(dynamic json)
        : id = json['id']!, // كارثة: استخدام ! مع بيانات خارجية غير موثوقة
          username = json['username'] as String, // خطر: TypeError لو كان القيمة int أو null
          creditLimit = json['creditLimit'] as double;
  }
  ```
- **Why It Is Bad:**
  لو السيرفر أرجع `null` أو غير نوع الحقل بالخطأ إلى رقم أو نص، سيتوقف التطبيق فوراً عند العميل بـ `Null check operator used on a null value` أو `TypeError`.
- **Better Implementation (المعماري المعتمد):**
  ```dart
  class ImmutableAccount {
    final String id;
    final String username;
    final double creditLimit;

    const ImmutableAccount({
      required this.id,
      required this.username,
      required this.creditLimit,
    });

    factory ImmutableAccount.fromUntrustedJson(Object? raw) {
      if (raw is! Map<String, dynamic>) {
        throw FormatException('Payload is not a valid JSON Object map');
      }

      // Safe extraction with explicit type checks and fallbacks
      final rawId = raw['id'];
      if (rawId == null || rawId.toString().trim().isEmpty) {
        throw FormatException('Account ID is missing or empty');
      }

      final rawUsername = raw['username'];
      final sanitizedUsername = (rawUsername is String && rawUsername.trim().isNotEmpty)
          ? rawUsername.trim()
          : 'UNKNOWN_USER';

      final rawCredit = raw['creditLimit'];
      final double sanitizedCredit;
      if (rawCredit is num) {
        sanitizedCredit = rawCredit.toDouble().clamp(0.0, 10000000.0);
      } else {
        sanitizedCredit = 0.0;
      }

      return ImmutableAccount(
        id: rawId.toString().trim(),
        username: sanitizedUsername,
        creditLimit: sanitizedCredit,
      );
    }
  }
  ```
- **Explanation:**
  استخدام `Object?` بدلاً من `dynamic` يجبر المطور على استخدام الـ Type Guards والتحقق من نوع الخريطة أولاً، ثم تنظيف كل حقل بقيم افتراضية آمنة.
- **Testing Strategy:**
  تمرير JSON يحتوي على `null`، أرقام في حقل الاسم، نصوص في حقل الرصيد، والتأكد من التعامل معها دون أي انهيار.

---

### Challenge 3 (Optimization & Maintainability): High-Throughput Value Object Cache
- **The Problem:**
  تطبيق لمعالجة مؤشرات البورصة يقوم بإنشاء ملايين كائنات الـ `MarketTick` في الثانية لنفس الرموز الثابتة (مثل 'AAPL', 'MSFT', 'EGX30').
- **Requirements:**
  1. تقليل الضغط على الـ Garbage Collector ومنع الـ Heap Thrashing.
  2. الحفاظ على سرعة الوصول الفورية $O(1)$.
- **Bad Implementation (السيئ):**
  ```dart
  class MarketTickBad {
    final String symbol;
    MarketTickBad(this.symbol); // حجز مكان جديد في الذاكرة مع كل تكة سعرية
  }
  ```
- **Better Implementation (المعماري المعتمد):**
  ```dart
  class MarketTick {
    final String symbol;
    static final Map<String, MarketTick> _cache = <String, MarketTick>{};

    const MarketTick._internal(this.symbol);

    factory MarketTick(String symbol) {
      final normalized = symbol.toUpperCase().trim();
      return _cache.putIfAbsent(normalized, () => MarketTick._internal(normalized));
    }
  }
  ```
- **Explanation:**
  استخدام الـ Flyweight Pattern مع Factory Constructor يضمن إعادة استخدام الكائنات ذات الرموز المتكررة، مما يوفر ملايين عمليات حجز الذاكرة.
- **Testing Strategy:**
  مقارنة مرجع كائنين بـ `identical(MarketTick('AAPL'), MarketTick('AAPL'))` للتأكد من أنهما يشيران إلى نفس الـ Memory Address.
