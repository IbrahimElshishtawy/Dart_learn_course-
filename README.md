# Dart Advanced Mastery Training Program 🚀
> **برنامج تدريبي هندسي متكامل لاحتراف لغة Dart من الصفر المعماري وحتى هندسة النظم المتقدمة**
>
> **الإصدار الأساسي المعتمد:** Dart 3.8.1+ (مع إبراز تحديثات Dart الحديثة)  
> **المدة الإجمالية:** 4 أسابيع | 12 محاضرة هندسية | 24 ساعة تدريب مباشر + 40 ساعة تطبيقات عملية  
> **الجمهور المستهدف:** مهندسو البرمجيات ومطورو Flutter الساعون لامتلاك لغة Dart بعمق الـ Compiler والـ Runtime وأنماط التصميم المعمارية.

---

## 🧭 خريطة المستودع وهيكل البرنامج (Repository Architecture)

تم تقسيم البرنامج إلى هيكل صارم يفصل بين مصادر الطالب، وأدلة المحاضر، وبنوك المسائل والمشاريع التطبيقية:

```text
dart_advanced_mastery/
├── 00_PROGRAM_GUIDE/                   # دليل المنهج، خارطة التعلم، وأدلة التدريس والدراسة
│   ├── MASTER_CURRICULUM.md            # المنهج الشامل والتفصيلي لجميع الأسابيع
│   ├── LEARNING_ROADMAP.md             # خارطة الطريق التقنية والمهارية
│   ├── INSTRUCTOR_TEACHING_PLAYBOOK.md # دليل واستراتيجيات المحاضر (طريقة الشرح والـ 4 Levels)
│   └── STUDENT_STUDY_GUIDE.md          # دليل الطالب وإرشادات المذاكرة والحل
├── 01_WEEK_01/                         # الأسبوع 1: Foundations, Type System & Modern Syntax
│   ├── lecture_01/                     # المحاضرة 1: Language Architecture & Type System
│   ├── lecture_02/                     # المحاضرة 2: Functions, Scope & Execution Model
│   ├── lecture_03/                     # المحاضرة 3: Collections, Records & Patterns
│   └── weekly_assessment/              # الاختبار الشامل والمشروع التجميعي للأسبوع الأول
├── 02_WEEK_02/                         # الأسبوع 2: OOP, Class Hierarchy & Advanced Generics
│   ├── lecture_04/                     # المحاضرة 4: Classes & Object Model
│   ├── lecture_05/                     # المحاضرة 5: OOP, Inheritance & Composition
│   ├── lecture_06/                     # المحاضرة 6: Generics & Advanced Type Modeling
│   └── weekly_assessment/              # مراجعة واختبار الأسبوع الثاني
├── 03_WEEK_03/                         # الأسبوع 3: Concurrency, Event Loop & Dart VM Runtime
│   ├── lecture_07/                     # المحاضرة 7: Asynchronous Programming & Event Loop
│   ├── lecture_08/                     # المحاضرة 8: Streams & Reactive Programming
│   ├── lecture_09/                     # المحاضرة 9: Isolates, Concurrency & Memory
│   └── weekly_assessment/              # مراجعة واختبار الأسبوع الثالث
├── 04_WEEK_04/                         # الأسبوع 4: Engineering Quality, Tooling & Dart VM Internals
│   ├── lecture_10/                     # المحاضرة 10: Dart Ecosystem & Package Engineering
│   ├── lecture_11/                     # المحاضرة 11: Testing, Debugging & Software Quality
│   ├── lecture_12/                     # المحاضرة 12: Runtime, Compilation & Performance
│   └── weekly_assessment/              # مراجعة واختبار الأسبوع الرابع
├── 05_FINAL_PROJECT/                   # مشروع التخرج: Dart Modular Engineering Core
├── 06_SHARED_RESOURCES/                # القاموس الموحد، أدوات الفحص، والمصادر المرجعية
└── 07_EXAMS_AND_ASSESSMENTS/           # الامتحانات النهائية وبنك الأسئلة التراكمي
```

---

## 🏛️ هيكل كل محاضرة (Standard 12-Component Lecture Architecture)

تتألف كل محاضرة من 12 عنصراً تعليمياً كاملاً ومستقلاً:

1. `01_INSTRUCTOR_GUIDE.md`: دليل المحاضر الكامل (توقيت، سيناريو الشرح باللهجة المصرية التقنية، أمثلة تدرج 4 مستويات).
2. `02_CODE_EXAMPLES/`: أكواد كاملة قابلة للتشغيل (`01_beginner`, `02_intermediate`, `03_advanced`, `04_engineering`, `05_wrong_vs_refactored`, `06_performance`).
3. `03_PRACTICAL_PROJECT/`: مشروع عملي واقعي متكامل مع Architecture وTests.
4. `04_PROBLEM_SOLVING/`: بنك مسائل على طريقة Stanford CS (مستويات 1 إلى 4 مع دراسة التعقيد الزمني والمكاني وفصل الحلول).
5. `05_DISCUSSION_QUESTIONS.md`: من 15 إلى 20 سؤال نقاشي معماري وتطبيقي.
6. `06_TERMINOLOGY_GLOSSARY.md`: مصطلحات المحاضرة مع الترجمة، التفسير المصري المبسط، والربط مع Flutter وEngineering.
7. `07_PROGRAMMING_LOGIC_CHALLENGES.md`: تحديات المنطق البرمجي (Mathematical, Security, Maintainability, Optimization).
8. `08_HOMEWORK.md`: تكليفات الطالب الأسبوعية المصنفة بالوقت ومستوى الصعوبة.
9. `09_QUIZ.md`: اختبار المحاضرة للطالب (MCQ, T/F, Output, Debugging, Practical).
10. `10_ANSWER_KEY.md`: نموذج الإجابة للمحاضر مع تفنيد الأخطاء وتحليلها.
11. `11_LEARNING_OUTCOMES.md`: مصفوفة المخرجات التعليمية القابلة للقياس (Bloom's Revised Taxonomy).
12. `12_REFERENCES.md`: المصادر والتوثيق الرسمي ومقالات هندسة لغة Dart.

---

## 📊 جدول المحاضرات والمواضيع (Curriculum Schedule)

| الأسبوع | المحاضرة | عنوان المحاضرة | التركيز التقني والمعماري | المشروع العملي المصاحب |
| :--- | :--- | :--- | :--- | :--- |
| **W1** | **L01** | **Language Architecture & Type System** | Dart Compiler Pipeline, Sound Type System, Null Safety, Late, Const/Final | Financial Transaction Validator Core |
| **W1** | **L02** | **Functions, Scope & Execution Model** | Closures, Higher-Order Functions, Call Stack, Tear-offs, Lexical Scope | Flexible Data Transformation Pipeline |
| **W1** | **L03** | **Collections, Records & Patterns** | Collection internals, Destructuring, Pattern Matching, Exhaustiveness | E-Commerce Pattern-Based Order Engine |
| **W2** | **L04** | **Classes & Object Model** | Constructors, Initializer lists, Factory, Constant evaluation, Object identity | Robust Configuration Management System |
| **W2** | **L05** | **OOP, Inheritance & Composition** | Abstract classes, Interfaces, Mixins, Extension Types, Composition over Inheritance | Modular Payment Processing Gateway |
| **W2** | **L06** | **Generics & Advanced Type Modeling** | Covariance/Contravariance, Type Bounds, Phantom Types, Generic Repositories | Type-Safe Generic Entity Cache Engine |
| **W3** | **L07** | **Asynchronous Programming & Event Loop** | Event Loop, Microtask Queue, Futures, async/await, unhandled exceptions | Async Job Scheduler & Resilient Worker |
| **W3** | **L08** | **Streams & Reactive Programming** | Single-subscription vs Broadcast, StreamTransformers, Backpressure, Rx operators | Real-Time Metrics & Event Bus Engine |
| **W3** | **L09** | **Isolates, Concurrency & Memory** | Actor model, Isolate message passing, TransferableTypedData, Dart GC mechanics | High-Throughput Heavy Data Cruncher |
| **W4** | **L10** | **Dart Ecosystem & Package Engineering** | Package anatomy, semantic versioning, pubspec, build_runner, documentation | Enterprise-Grade Open Source Package |
| **W4** | **L11** | **Testing, Debugging & Software Quality** | Unit, integration tests, mockito, code coverage, CI pipeline, lint rules | Industrial Test Suite & Quality Harness |
| **W4** | **L12** | **Runtime, Compilation & Performance** | Dart VM, JIT vs AOT, Memory profiling, Allocation tracking, Benchmarking | High-Performance Engine Optimizer |

---

## 📈 متابعة تقدم الطالب (Student Progress Tracker)

استخدم هذا الجدول لتسجيل تقدم المتدربين عبر الأسابيع:

- [ ] **Week 1 Completed:** (L01, L02, L03 + Assessment 1)
- [ ] **Week 2 Completed:** (L04, L05, L06 + Assessment 2)
- [ ] **Week 3 Completed:** (L07, L08, L09 + Assessment 3)
- [ ] **Week 4 Completed:** (L10, L11, L12 + Assessment 4)
- [ ] **Graduation Defense Completed:** Dart Modular Engineering Core

---

## 🛠️ متطلبات التشغيل (Environment Setup)

1. **Dart SDK:** الإصدار `3.8.1` أو أحدث (تم التحقق والتوافق حتى `3.13.x`).
2. **Editor:** VS Code أو Android Studio مع إضافة Dart الرسمية وتفعيل Linter الشديد (`pedantic` / `very_good_analysis`).
3. **تشغيل الأمثلة:**
   ```bash
   dart run <path_to_file.dart>
   ```
4. **فحص سلامة الأكواد والتحليل الساكن:**
   ```bash
   dart analyze .
   dart test
   ```