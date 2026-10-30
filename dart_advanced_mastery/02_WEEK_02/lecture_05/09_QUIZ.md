# Lecture 05: Assessment Quiz
# اختبار تقييم الفهم - المحاضرة الخامسة

### السؤال 1 (اختيار من متعدد)
ما الفرق الرئيسي في لغة Dart بين استخدام `extends BaseClass` واستخدام `implements BaseClass`؟
- [ ] أ) `extends` تجبرك على إعادة كتابة كل الدوال، بينما `implements` ترث الكود المكتوب.
- [ ] ب) `extends` ترث الكود والخصائص المشتركة، بينما `implements` تعامل الكلاس كواجهة وتلزمك بإعادة كتابة وتطبيق كل حقل ودالة.
- [ ] ج) لغة Dart لا تدعم `implements` إلا مع الكلاسات التي تبدأ بكلمة `interface`.
- [ ] د) لا يوجد أي فرق إطلاقاً بينهما في لغة Dart.

---

### السؤال 2 (اختيار من متعدد)
ماذا يقصد بمبدأ "Favor Composition Over Inheritance"؟
- [ ] أ) كتابة كل الدوال داخل ملف واحد لتجنب إنشاء كلاسات جديدة.
- [ ] ب) الاعتماد على امتلاك الكائن لكائنات وسلوكيات أخرى (Has-A) بدلاً من وراثتها في شجرة صلبة (Is-A).
- [ ] ج) جعل كل الكلاسات ترث من كلاس أساسي وحيد يسمى `Object`.
- [ ] د) تفضيل الوراثة المتعددة على إنشاء واجهات منفصلة.

---

### السؤال 3 (صواب أو خطأ مع التعليل)
في لغة Dart، يمكن لأي كلاس أن يرث (extends) من أكثر من كلاس أم في نفس الوقت (Multiple Inheritance).
- [ ] صواب
- [ ] خطأ

---

### السؤال 4 (تتبع الكود)
ما ناتج تنفيذ الكود التالي؟
```dart
abstract class Speaker {
  void speak();
}

class Robot implements Speaker {
  @override
  void speak() => print('Beep Boop');
}

void makeNoise(Speaker s) {
  s.speak();
}

void main() {
  makeNoise(Robot());
}
```
- [ ] أ) Beep Boop
- [ ] ب) Compilation Error: Robot cannot be instantiated
- [ ] ج) Runtime Exception
