# Programming Logic & Engineering Challenges — Lecture 03

تحديات هندسة البيانات والمنطق البرمجي للمحاضرة الثالثة لقياس القدرة على تصميم حلول خالية من الأخطاء النوعية وتوظف إمكانيات Dart 3 المتقدمة.

---

### Challenge 1 (Logic & Pattern Matching): Complex Nested JSON Destructuring
- **The Problem:**
  استقبال استجابة معقدة من سيرفر خارجي تضم قائمة طلبات؛ بعضها يحمل دفعات مكتملة، وبعضها معلق، وبعضها ملغى. المطلوب استخراج معرفات الطلبات المكتملة ذات القيمة الأكبر من 5000 دولار والتي تم دفعها ببطاقة ائتمانية فقط، وتجاهل أي طلبات معطوبة أو ناقصة بدون أي استثناءات في الـ Runtime.
- **Bad Implementation (السيئ):**
  ```dart
  List<String> getHighValueCardOrdersBad(dynamic raw) {
    var result = <String>[];
    for (var order in raw['orders']) {
      if (order['status'] == 'COMPLETED') {
        if (order['payment'] != null && order['payment']['method'] == 'CREDIT_CARD') {
          if (order['total'] > 5000) {
            result.add(order['id']); // معرض لـ TypeError أو NoSuchMethodError لو الداتا ناقصة
          }
        }
      }
    }
    return result;
  }
  ```
- **Better Implementation (المعماري المعتمد):**
  ```dart
  List<String> getHighValueCardOrdersRefactored(Object? raw) {
    if (raw case {'orders': List<dynamic> orders}) {
      return [
        for (final order in orders)
          if (order case {
            'id': String id,
            'status': 'COMPLETED',
            'payment': {'method': 'CREDIT_CARD'},
            'total': num total,
          } when total > 5000)
            id,
      ];
    }
    return const [];
  }
  ```
- **Explanation:**
  الـ Collection-for المدمجة مع `if-case` والـ Guard Clause (`when total > 5000`) تفحص البنية والمفاتيح والأنواع والقيم في خطوة واحدة بأمان نوعي كامل ودون أي سطر كود زائد.
- **Testing Strategy:**
  تمرير JSON يحتوي على طلبات بدون حقل `payment`، وطلبات بها `total` كنص، والتأكد من استخراج الطلبات المطابقة فقط بدون أي انهيار.

---

### Challenge 2 (Mathematical & Relational Patterns): Mathematical Interval Classifier
- **The Problem:**
  تصنيف قياسات ضغط الدم (Blood Pressure) إلى فئات طبية معتمدة بناءً على قراءتي الضغط الانقباضي والانبساطي (Systolic & Diastolic) باستخدام نمط العلاقات.
- **Better Implementation:**
  ```dart
  enum BpCategory { normal, elevated, stage1Hypertension, stage2Hypertension, crisis }

  BpCategory classifyBloodPressure((int sys, int dia) reading) {
    return switch (reading) {
      (> 180, _) || (_, > 120) => BpCategory.crisis,
      (>= 140, _) || (_, >= 90) => BpCategory.stage2Hypertension,
      (>= 130 && <= 139, _) || (_, >= 80 && <= 89) => BpCategory.stage1Hypertension,
      (>= 120 && <= 129, < 80) => BpCategory.elevated,
      (< 120, < 80) => BpCategory.normal,
      _ => BpCategory.normal,
    };
  }
  ```
- **Explanation:**
  استخدام الـ Tuple Patterns مع الـ Logical OR `||` والمعاملات العلاقية (`>`, `<=`) يختصر أكثر من 30 سطر كود من الـ `if-else` إلى تعبير رياضي مباشر ومقروء.

---

### Challenge 3 (Optimization & State): Deduplicated Transaction Stream Processor
- **The Problem:**
  معالجة تدفق معاملات متسارعة قادمة من عدة مصادر، ومنع إدخال أي معاملة مكررة تحمل نفس كود الـ (ID, Timestamp, Amount) خلال نافذة زمنية.
- **Better Implementation:**
  ```dart
  typedef TxSignature = (String id, int timestamp, int amount);

  class DeduplicationEngine {
    final Set<TxSignature> _seenSignatures = <TxSignature>{};

    bool processTransaction(TxSignature tx) {
      // Set.add returns false if the item was already in the set!
      // Records enjoy instant structural equality out of the box!
      return _seenSignatures.add(tx);
    }
  }
  ```
- **Explanation:**
  بما أن الـ Records تمتلك Structural Equality وHashCode تلقائي، يمكن استخدامها مباشرة كمفاتيح وعناصر في الـ Set لتحقيق التحقق من عدم التكرار في زمن قياسي $O(1)$ دون إنشاء أي فئة مخصصة.
