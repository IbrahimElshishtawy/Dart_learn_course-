# Programming Logic & Engineering Challenges — Lecture 02

تحديات المنطق البرمجي والهندسة الوظيفية للمحاضرة الثانية لاختبار قدرتك على تصميم كود وظيفي نقي، متماسك، وقابل للتوسع.

---

### Challenge 1 (Logic & State Encapsulation): Secure Rate-Limiter Closure
- **The Problem:**
  تصميم Rate Limiter وظيفي يعتمد على الـ Closures لحماية API Endpoint من الغرق بالطلبات (Denial of Service)، بحيث يسمح بعدد أقصى $M$ من الطلبات خلال نافذة زمنية قدرها $T$ ثوانٍ لكل مستخدم.
- **Requirements:**
  1. لا يجوز استخدام متغيرات عامة (Global variables).
  2. تغليف عداد الطلبات والوقت المنقضي داخل Closure نقي.
  3. إرجاع دالة `bool Function() canProceed` تعيد `true` إذا كان الطلب مسموحاً و`false` إذا تجاوز الحد.
- **Bad Implementation (السيئ):**
  ```dart
  int globalHits = 0; // خطأ: حالة مشتركة ملوثة لكل المستخدمين
  bool checkRateLimitBad() {
    globalHits++;
    return globalHits <= 5;
  }
  ```
- **Better Implementation (المعماري المعتمد):**
  ```dart
  bool Function() createRateLimiter({required int maxRequests, required Duration window}) {
    final timestamps = <DateTime>[];

    return () {
      final now = DateTime.now();
      // حذف التوقيعات القديمة التي خرجت خارج النافذة الزمنية
      timestamps.removeWhere((t) => now.difference(t) > window);

      if (timestamps.length < maxRequests) {
        timestamps.add(now);
        return true; // مسموح
      }

      return false; // تم خنق الطلب Rate Limited
    };
  }
  ```
- **Explanation:**
  الـ Closure يلتقط قائمة `timestamps` المعزولة تماماً في الـ Heap؛ كل مستخدم يحصل على نسخة Rate Limiter مستقلة به، ولا يوجد أي تداخل في الـ State.
- **Testing Strategy:**
  إنشاء ليمتر يسمح بـ 3 طلبات في الثانية، وإرسال 5 طلبات متتالية والتأكد من رفض الطلبين 4 و5.

---

### Challenge 2 (Mathematical & Optimization): Recursive Memoized Combinatorics
- **The Problem:**
  حساب معاملات التوافيق $\binom{n}{k} = \frac{n!}{k!(n-k)!}$ للأعداد الكبيرة بدون الوقوع في مشكلة الـ Integer Overflow وبأقل عدد من العمليات الحسابية المتكررة.
- **Requirements:**
  1. استخدام قاعدة باسكال: $\binom{n}{k} = \binom{n-1}{k-1} + \binom{n-1}{k}$.
  2. منع التكرار الأسي $O(2^n)$ عبر تقنية الـ Closure Memoization.
- **Better Implementation:**
  ```dart
  int Function(int n, int k) createCombinationsCalculator() {
    final memo = <String, int>{};

    int compute(int n, int k) {
      if (k < 0 || k > n) return 0;
      if (k == 0 || k == n) return 1;

      final cacheKey = '$n:$k';
      if (memo.containsKey(cacheKey)) {
        return memo[cacheKey]!;
      }

      final result = compute(n - 1, k - 1) + compute(n - 1, k);
      memo[cacheKey] = result;
      return result;
    }

    return compute;
  }
  ```
- **Complexity:**
  يخفض التعقيد من $O(2^N)$ إلى $O(N \times K)$ ويوفر حسابات لحظية.

---

### Challenge 3 (Security & Sanitization): Functional Middleware Sanitizer
- **The Problem:**
  بناء سلسلة معالجة مدخلات مستخدم تفحص النصوص من مخاطر الحقن (XSS / SQL Injection)، وتقوم بتنظيفها عبر سلسلة مراحل وظيفية غير قابلة للكسر.
- **Better Implementation:**
  ```dart
  typedef Sanitizer = String Function(String raw);

  Sanitizer composeSanitizers(List<Sanitizer> sanitizers) {
    return (String input) {
      return sanitizers.fold(input, (current, sanitizer) => sanitizer(current));
    };
  }

  void main() {
    final xssSanitizer = (String s) => s.replaceAll('<', '&lt;').replaceAll('>', '&gt;');
    final trimSanitizer = (String s) => s.trim();
    final quoteSanitizer = (String s) => s.replaceAll("'", "''");

    final masterSanitizer = composeSanitizers([trimSanitizer, xssSanitizer, quoteSanitizer]);
    final clean = masterSanitizer("  <script>alert('hack');</script>  ");
    print('Sanitized: $clean'); // &lt;script&gt;alert(''hack'');&lt;/script&gt;
  }
  ```
- **Explanation:**
  استخدام `fold` لتطبيق الدوال واحدة تلو الأخرى بشكل وظيفي بحت (Functional Reduction)، مما يضمن عدم وجود أي أثر جانبي.
