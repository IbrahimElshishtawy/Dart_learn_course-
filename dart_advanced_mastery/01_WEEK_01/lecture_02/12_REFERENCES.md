# References & Deep-Dive Readings — Lecture 02: Functions, Scope & Execution Model

قائمة بالمصادر الرسمية، التوثيق المعماري، والمقالات المتقدمة في هندسة البرمجيات والبرمجة الوظيفية في لغة Dart.

---

## 1. التوثيق الرسمي ومواصفات لغة Dart (Official Language Documentation)
- **Dart Functions & Parameter System Overview:**  
  [https://dart.dev/language/functions](https://dart.dev/language/functions)  
  *الدليل الرسمي الشامل لجميع أنماط المعاملات، الـ Tear-offs، والـ Anonymous Functions.*
- **Dart Constructor Tear-offs Specification (Language Feature Specification):**  
  [https://github.com/dart-lang/language/blob/master/accepted/2.15/constructor-tearoffs/feature-specification.md](https://github.com/dart-lang/language/blob/master/accepted/2.15/constructor-tearoffs/feature-specification.md)  
  *المواصفات التقنية الكاملة لكيفية تنفيذ المترجم لخاصية تقطيع الكونستركتور واستنتاج الأنواع العامة لها.*

---

## 2. البرمجة الوظيفية والـ Closures في علوم الحاسب (Computer Science Foundations)
- **Harold Abelson & Gerald Jay Sussman: "Structure and Interpretation of Computer Programs" (SICP):**  
  *المرجع الكلاسيكي الرائد لمعهد MIT في شرح First-Class Procedures والـ Lexical Environments وكيف تتشكل الـ Closures.*
- **Closure Allocation and Escaped Variables in Dart VM:**  
  [https://github.com/dart-lang/sdk/tree/main/runtime/vm](https://github.com/dart-lang/sdk/tree/main/runtime/vm)  
  *الكود المصدري لمحرك Dart VM في معالجة المتغيرات التي تفلت من الـ Stack إلى الـ Heap.*

---

## 3. مقالات ومصادر هندسة الأداء (Performance Engineering)
- **Effective Dart: Design Guidelines for Functions:**  
  [https://dart.dev/effective-dart/design#functions](https://dart.dev/effective-dart/design#functions)  
  *أفضل الممارسات المعتمدة من Google لتصميم الـ Signatures واستخدام الـ Tear-offs وتجنب التغليف الزائد.*
- **Tear-offs vs Closures Performance Impact by Dart SDK Team:**  
  *المقارنات المعيارية لتحسين الـ Inlining وتفادي تخصيص كائنات مكررة على الذاكرة.*
