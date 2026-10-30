# Instructor Solutions & Pedagogical Notes: Lecture 05
# دليل المحاضر لحلول مسائل المحاضرة 5

## 📌 المسألة 1: Polymorphic Toll Booth (تعددية الأشكال في الاستدعاء)
- **المفهوم المستهدف**: Polymorphic Dispatch & Abstract Classes.
- **الخطأ الشائع عند الطلاب**:
  - كتابة دوال منفصلة مثل `processCar(Car c)` و `processTruck(Truck t)` داخل المحطة!
- **توجيه المحاضر**:
  - اسأل الطالب: "لو بكره الدولة سمحت بمرور الأوتوبيسات (Buses)، هل هتروح تعدل في كلاس `TollStation`؟"
  - أظهر له كيف أن استدعاء `vehicle.calculateToll()` يجعل المحطة مغلقة ضد التعديل ومفتوحة للتوسع (Open/Closed Principle - OCP).

---

## 📌 المسألة 2: Document Exporter (نمط الاستراتيجية والواجهات)
- **المفهوم المستهدف**: Strategy Pattern & Interfaces.
- **الخطأ الشائع عند الطلاب**:
  - دمج كود الـ JSON والـ CSV داخل كلاس `ReportData` نفسه بجمل `switch/case`.
- **توجيه المحاضر**:
  - اشرح مبدأ المسؤولية الواحدة (Single Responsibility Principle - SRP): كلاس البيانات مسؤول فقط عن حمل البيانات، بينما كلاس الـ Formatter مسؤول عن التحويل الشكلي.

---

## 📌 المسألة 3: Pipeline / Filter Pattern (التركيب المتسلسل)
- **المفهوم المستهدف**: Composition & Chain of Execution.
- **الخطأ الشائع عند الطلاب**:
  - استخدام الوراثة المتعددة المتداخلة لتطبيق الفلاتر بدلاً من تخزين قائمة واجهات `List<TextFilter>`.
- **توجيه المحاضر**:
  - اربط هذا المفهوم بـ Middlewares في خوادم Dart (مثل Shelf) وبـ Interceptors في مكتبات الشبكات مثل Dio.
