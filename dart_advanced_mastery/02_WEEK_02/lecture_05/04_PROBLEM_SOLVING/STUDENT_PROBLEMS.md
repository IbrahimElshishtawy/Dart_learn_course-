# Lecture 05 Problem Solving: Interfaces, Polymorphism & Composition
# مسائل حل المشكلات وتطوير التفكير البرمجي - المحاضرة 5

> 💡 **تعليمات للطالب**:
> - لا تقم بنسخ الأكواد أو استخدام حلول جاهزة.
> - صمم الواجهات (Contracts) أولاً على الورق قبل فتح المحرر.
> - تأكد من التزامك التام بمبدأ "Composition over Inheritance".

---

### المسألة 1 (سهلة): نظام حساب الرسوم للمركبات (Polymorphic Toll Booth)
- **السياق**: مطلوب تصميم نظام بوابة تحصيل رسوم طريق سريع (Toll Booth).
- **المتطلبات**:
  1. صمم كلاس مجرد `Vehicle` يحتوي على `licensePlate` ودالة مجردة `calculateToll()`.
  2. أنشئ 3 أنواع فرعية ترث منه:
     - `Motorcycle`: الرسوم ثابتة 10 جنيهات.
     - `Car`: الرسوم 25 جنيهاً.
     - `Truck`: الرسوم 50 جنيهاً + 10 جنيهات لكل طن حمولة إضافية (`cargoWeightInTons`).
  3. صمم كلاس `TollStation` يحتوي على دالة `processVehicle(Vehicle vehicle)` تستقبل أي مركبة وتضيف رسومها إلى إجمالي دخل المحطة اليومي دون معرفة نوع المركبة الداخلي.

---

### المسألة 2 (متوسطة): محرك تقارير التصدير متعدد الصيغ (Document Exporter)
- **السياق**: نظام توليد تقارير يدعم التصدير إلى صيغ مختلفة (PDF, JSON, CSV).
- **المتطلبات**:
  1. أنشئ نموذج بيانات غير قابل للتعديل `ReportData` يحمل `title`, `generatedAt`, `List<String> rows`.
  2. أنشئ واجهة `ReportFormatter` تحتوي على دالة `String format(ReportData data)`.
  3. قم بتنفيذ فئتين تطبقان الواجهة:
     - `JsonReportFormatter`: تحول التقرير لصيغة JSON نصية منسقة.
     - `CsvReportFormatter`: تحول السطور إلى قيم مفصولة بفواصل (Comma-separated).
  4. صمم كلاس `ReportGenerator` يقبل `ReportFormatter` عبر الـ Composition وينتج التقرير النهائي.

---

### المسألة 3 (متقدمة): خط معالجة الفلاتر الحسابية (Pipeline / Filter Pattern)
- **السياق**: في تطبيقات معالجة النصوص، نحتاج لتطبيق سلسلة فلاتر متتالية على النص (مثل: إزالة المسافات الزائدة، تحويل الحروف لكبيرة، تشفير خفيف).
- **المتطلبات**:
  1. صمم واجهة `TextFilter` بدالة `String apply(String input)`.
  2. نفذ 3 فلاتر: `TrimFilter`, `UpperCaseFilter`, `CensorBadWordsFilter(Set<String> bannedWords)`.
  3. صمم كلاس `FilterPipeline` يطبق نمط التركيب (Composition)، ويحتوي على دالة `addFilter(TextFilter filter)` ودالة `execute(String rawText)` التي تمرر النص على كل الفلاتر بالتتابع وتعيد الناتج المنقى نهائياً.
