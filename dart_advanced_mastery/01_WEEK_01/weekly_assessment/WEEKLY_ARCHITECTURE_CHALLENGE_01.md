# Weekly Software Architecture Challenge 01 — Week 01

## 🏛️ عنوان التحدي: Unified Telemetry Event Router & Aggregator

### 1. سيناريو العمل الهندسي (Business Context)
أنت تعمل كـ Lead Software Architect في منصة سحابية لتتبع حركة الدفع الإلكتروني. تستقبل المنصة أكثر من 50,000 حدث في الثانية قادمة من بوابات دفع مختلفة (Stripe, Fawry, Vodafone Cash). كل حدث يأتي في صورة غير متجانسة ويجب تنظيفه، تصنيفه، وحسابه بشكل وظيفي دون أي تسريب للذاكرة.

---

### 2. المتطلبات المعمارية الصارمة (Architectural Constraints)
1. **Sealed Event Hierarchy:**
   - نمذجة الأحداث السحابية عبر `sealed class TelemetryEvent`:
     - `PaymentReceived(String txId, double amount, String currency)`
     - `PaymentRefunded(String txId, double amount, String reason)`
     - `SystemHeartbeat(int uptimeSeconds, double cpuUsage)`
2. **Pattern-Based Pure Aggregator:**
   - كتابة دالة مجمعة نقية (Pure Reducer Function):
     ```dart
     typedef AggregatedState = ({double totalVolume, int paymentsCount, int refundsCount});
     ```
   - يجب تحديث الـ State في كل لفة عبر Record جديد بالكامل دون تعديل أي متغير عام.
3. **Guard Clauses & Security:**
   - إذا كان الـ Event من نوع `PaymentReceived` بمبلغ أكبر من 100,000 جنيه، يتم تسجيل تنبيه أمني عالي الخطورة.
4. **Performance & Memory:**
   - استخدام Constructor/Method Tear-offs في كل مراحل المعالجة.
   - تحقيق زمن معالجة أقل من 500 ميكروثانية لدفعة من 1,000 حدث.

---

### 3. معايير التقييم والتحكيم المعماري
- **التصميم الكائني والوظيفي (35%):** الاستخدام السليم للـ Sealed Classes ونمط الـ Reducer.
- **سلامة الأنواع وNull Safety (30%):** خلو الكود تماماً من `!` أو `as` أو `dynamic`.
- **استغلال ميزات Dart 3 الحديثة (20%):** استخدام Records وDestructuring وSwitch Expressions.
- **قابلية الاختبار والأداء (15%):** كتابة سيناريو تشغيل كامل واختبارات قياس.
