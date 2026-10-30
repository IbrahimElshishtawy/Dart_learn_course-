# References & Deep-Dive Readings — Lecture 01: Language Architecture & Type System

توفر هذه الوثيقة قائمة بالمصادر الرسمية، الأوراق البحثية، ومقالات هندسة النظم المعتمدة لتعميق الفهم المعماري لموضوعات المحاضرة الأولى.

---

## 1. التوثيق الرسمي ومواصفات اللغة (Official Documentation & Language Specs)
- **Dart Language Specification (Version 3.8+):**  
  [https://dart.dev/guides/language/spec](https://dart.dev/guides/language/spec)  
  *المواصفات الرياضية الدقيقة لقواعد بناء الجملة (Syntax) ودلالات الألفاظ (Semantics).*
- **Sound Null Safety Architectural Deep Dive:**  
  [https://dart.dev/null-safety/understanding-null-safety](https://dart.dev/null-safety/understanding-null-safety)  
  *الورقة الرسمية التي تشرح الإثبات الرياضي لنظام Sound Null Safety ونظرية الأنواع في Dart.*
- **The Dart Type System (Soundness & Subtyping Rules):**  
  [https://dart.dev/guides/language/type-system](https://dart.dev/guides/language/type-system)  
  *شرح قواعد التغاير، التضاد، واستنتاج الأنواع الساكن.*

---

## 2. معمارية الـ Virtual Machine وخط أنابيب المترجم (Dart VM Internals)
- **Dart VM Architecture Overview by Vyacheslav Egorov:**  
  [https://mrale.ph/dartvm/](https://mrale.ph/dartvm/)  
  *المرجع الأساسي الأعمق عالمياً لفهم معمارية الـ Dart VM، والـ Object Allocation، وخط أنابيب JIT/AOT، وتجميع الـ Kernel.*
- **Dart Kernel Binary Format Specification (`.dill` files):**  
  [https://github.com/dart-lang/sdk/tree/main/pkg/kernel](https://github.com/dart-lang/sdk/tree/main/pkg/kernel)  
  *تشريح الشجرة التجريدية (AST) والصيغة الوسيطة للمترجم.*

---

## 3. الأوراق البحثية التاريخية (Computer Science Classics)
- **Sir Tony Hoare (1965/2009): "Null References: The Billion Dollar Mistake":**  
  *العرض التاريخي لمخترع الـ Null Reference وأسباب ظهور تقنيات الـ Sound Null Safety الحديثة.*
- **IEEE 754 Standard for Floating-Point Arithmetic:**  
  *الأسباب الرياضية التي توجب استخدام الأعداد الصحيحة (Minor Units) بدلاً من `double` في النظم المالية المصرفية.*

---

## 4. مقالات هندسية متقدمة (Engineering Blogs)
- **Bob Nystrom: "Why Dart Types are Sound":**  
  *مقال عميق لمهندس لغة Dart يوضح كيف تم الانتقال من Dart 1.x (غير الصارمة) إلى Dart 2/3 Soundness.*
- **Effective Dart: Style & Design Guidelines:**  
  [https://dart.dev/effective-dart](https://dart.dev/effective-dart)  
  *المعايير المعتمدة من فريق هندسة Google لكتابة كود Dart احترافي قابل للصيانة.*
