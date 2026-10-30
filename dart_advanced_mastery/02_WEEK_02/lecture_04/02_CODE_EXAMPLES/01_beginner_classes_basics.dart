// ==============================================================================
// 01_beginner_classes_basics.dart
// Week 02 - Lecture 04: Beginner Blueprint & Encapsulation
// ==============================================================================
// الهدف: فهم مفهوم الكلاس (Class) كنموذج تفصيل (Blueprint) لإنشاء كائنات (Objects)
// مع تطبيق قواعد التغليف (Encapsulation) والتحقق من صحة المدخلات.
// ==============================================================================

/// نموذج يمثل حساب طالب في المنصة الأكاديمية.
class StudentAccount {
  // الحقول (Fields / Attributes)
  final String id;
  String _fullName; // حقل خاص (Private) داخل نفس المكتبة/الملف
  double _gpa;      // حقل خاص لا يسمح بتعديله بقيم غير منطقية

  // Constructor أساسي مع التحقق من صحة البيانات (Validation)
  StudentAccount({
    required this.id,
    required String fullName,
    double initialGpa = 0.0,
  })  : _fullName = fullName,
        _gpa = (initialGpa >= 0.0 && initialGpa <= 4.0) ? initialGpa : 0.0 {
    if (fullName.trim().isEmpty) {
      throw ArgumentError('Student full name cannot be empty');
    }
  }

  // Getters للوصول الآمن للحقول الخاصة
  String get fullName => _fullName;
  double get gpa => _gpa;

  // Setter مع حماية المنطق الهندسي (Defensive Programming)
  set fullName(String newName) {
    if (newName.trim().isEmpty) {
      print('⚠️ تحذير: لا يمكن تغيير الاسم لنص فارغ!');
      return;
    }
    _fullName = newName.trim();
  }

  /// طريقة (Method) لتحديث المعدل مع التحقق الصارم
  bool updateGpa(double newGpa) {
    if (newGpa < 0.0 || newGpa > 4.0) {
      print('❌ خطأ: المعدل التراكمي يجب أن يكون بين 0.0 و 4.0');
      return false;
    }
    _gpa = newGpa;
    return true;
  }

  /// طباعة ملخص الحساب
  void displaySummary() {
    print('-----------------------------------------');
    print('🎓 Student ID : $id');
    print('👤 Name       : $_fullName');
    print('📊 GPA        : ${_gpa.toStringAsFixed(2)}');
    print('-----------------------------------------');
  }
}

void main() {
  print('=== 🟢 كود المحاضرة 4: مدخل إلى الكلاسات والتغليف ===\n');

  // 1. إنشاء كائنين منفصلين من نفس الـ Blueprint
  final student1 = StudentAccount(
    id: 'STD-101',
    fullName: 'Ahmed Ali',
    initialGpa: 3.75,
  );

  final student2 = StudentAccount(
    id: 'STD-102',
    fullName: 'Sara Mohamed',
    initialGpa: 3.90,
  );

  student1.displaySummary();
  student2.displaySummary();

  // 2. تجربة التعديل الآمن
  print('\n🔄 تحديث بيانات الطالب:');
  student1.fullName = 'Ahmed A. Ali';
  student1.updateGpa(3.85);
  student1.displaySummary();

  // 3. تجربة حماية الحقول من البيانات الخاطئة
  print('\n🛡️ اختبار الحماية ضد البيانات غير المنطقية:');
  student1.updateGpa(5.50); // مرفوض
  student1.fullName = '    '; // مرفوض

  print('\nالبيانات بعد محاولات التخريب الفاشلة:');
  student1.displaySummary();
}
