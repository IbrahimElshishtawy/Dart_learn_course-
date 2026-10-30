# Lecture 04: Learning Outcomes & Competency Matrix
# مخرجات التعلم ومعايير الكفاءة - المحاضرة الرابعة

## 🎯 المخرجات التعليمية الأساسية (Core Competencies)
بنهاية هذه المحاضرة، يجب أن يكون الطالب قادراً على:
1. **تصميم كلاسات نموذجية نظيفة**: بناء نماذج بيانات تمثل مشاكل العالم الحقيقي مع تمييز دقيق بين الحقول والسلوكيات.
2. **إتقان التغليف (Encapsulation)**: إخفاء الحقول الحساسة خلف `_` وتوفير Getters و Setters دفاعية ترفض القيم غير المنطقية.
3. **تطبيق أنواع المنشئات المختلفة (Constructors)**:
   - استخدام Generative Constructor مع Initializer Lists.
   - بناء Named Constructors للتحويل من هياكل مختلفة.
   - استخدام Factory Constructors للتحكم في إنشاء الكائنات والتخزين المؤقت (Caching).
4. **بناء كائنات غير قابلة للتعديل (Immutable Objects)**:
   - تطبيق `final` و `const` constructors.
   - فهم الفارق بين `identical` ومساواة القيم `operator ==`.
   - كتابة دالة `copyWith` لتحديث الحالة بأمان تام بدون أي آثار جانبية (Side Effects).

---

## 📊 مستويات الإتقان (Mastery Levels)
- **مستوى المبتدئ (Novice)**: يستطيع إنشاء كلاس بسيط وتمرير معاملات بالـ constructor واستدعاء الدوال.
- **مستوى الكفاءة (Proficient)**: يستطيع تطبيق التغليف ومنع التعديل المباشر على الحقول وبناء كائنات Immutable مع `copyWith`.
- **مستوى المهندس (Advanced Engineer)**: يعيد تعريف `operator ==` و `hashCode` بطريقة سليمة رياضياً ويفهم أثر الـ Canonicalization والـ GC على أداء تطبيقات الـ Production.
