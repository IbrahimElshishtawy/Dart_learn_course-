void main() {
  print("=== 1. الأنواع الأساسية واستنتاج النوع (Type Inference) ==\n");

  String studentName = "أحمد محمد";
  int studentAge = 22;
  double studentGPA = 3.75;
  bool isGraduated = false;

  print(
    "الطالب: $studentName, العمر: $studentAge, التقدير: $studentGPA, متخرج: $isGraduated",
  );

  var university = "جامعة طنطا";
  var studyYear = 4;

  print("الجامعة: $university (السنة الدراسية: $studyYear)");

  print("\n=== 2. الفرق بين Explicit Types و Object و dynamic ==\n");

  String city = "المحلة الكبرى";
  // city = 10;

  Object flexibleData = "مرحباً";
  flexibleData = 500;
  flexibleData = true;

  dynamic dangerousVar = "Flutter";
  dangerousVar = 42;
  print(dangerousVar.toUpperCase());

  print("\n=== 3. نظام الأمان الصارم (Null Safety) ومعاملات الحماية ===\n");

  String username = "ibrahim_dev";
  print("اسم المستخدم: $username");

  String? nickName;
  print("اللقب (قبل التحديد): $nickName");

  nickName = "هندسة البرمجيات";

  print("طول اللقب بأمان: ${nickName?.length}");

  String? userTitle;
  String finalTitle = userTitle ?? "مهندس برمجيات مبتدئ";
  print("المسمى الوظيفي: $finalTitle");

  print("اللقب بالأحرف الكبيرة: ${nickName!.toUpperCase()}");

  print("\n=== 4. العمليات الحسابية والمنطقية (Operators) ===\n");

  int x = 10;
  int y = 3;

  print("الجمع: ${x + y}");
  print("الطرح: ${x - y}");
  print("الضرب: ${x * y}");
  print("القسمة العادية: ${x / y}");
  print("قسمة الأعداد الصحيحة فقط: ${x ~/ y}");
  print("باقي القسمة (Modulus): ${x % y}");

  print("هل x أكبر من y؟ ${x > y}");
  print("هل x يساوي y؟ ${x == y}");

  bool isAdmin = true;
  bool isAuthorized = false;

  bool canAccessDashboard = isAdmin && isAuthorized;
  print("صلاحية الدخول (AND): $canAccessDashboard");

  bool canReadContent = isAdmin || isAuthorized;
  print("صلاحية القراءة (OR): $canReadContent");

  print("عكس حالة isAdmin: ${!isAdmin}");
}
