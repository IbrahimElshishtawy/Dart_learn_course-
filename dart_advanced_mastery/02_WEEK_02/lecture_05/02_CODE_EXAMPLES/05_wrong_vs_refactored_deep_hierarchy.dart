// ==============================================================================
// 05_wrong_vs_refactored_deep_hierarchy.dart
// Week 02 - Lecture 05: Deep Inheritance Anti-Pattern vs Clean Composition
// ==============================================================================
// الهدف: تدريب الطالب على اكتشاف "مشكلة الفئة الأم الهشة" (Fragile Base Class)
// وشجرة الوراثة المتشابكة، وكيفية تفكيكها إلى سلوكيات تركيبية نظيفة.
// ==============================================================================

// -----------------------------------------------------------------------------
// ❌ الكود الخاطئ (Anti-Pattern): شجرة وراثة عميقة ومتشابكة غير قابلة للصيانة
// -----------------------------------------------------------------------------
class BaseEntity {
  String id = '';
}

class BaseUserEntity extends BaseEntity {
  String name = '';
}

class CustomerEntity extends BaseUserEntity {
  double balance = 0.0;
  void sendEmailReceipt() => print('Email sent to $name');
}

// تخيل لو أردنا إنشاء عميل يدفع كاش وليس لديه بريد إلكتروني، سيضطر لوراثة sendEmailReceipt غصباً!
// تخيل لو أردنا إضافة "VIPCustomer" بخصم 10% ثم "VIPCustomerCorporate" بخصم 15%.. انفجار في عدد الكلاسات!

// -----------------------------------------------------------------------------
// ✅ الكود الهندسي النظيف (Refactored): كائن خفيف مع واجهات وسلوكيات مستقلة
// -----------------------------------------------------------------------------
abstract class Notifier {
  void notify(String recipient, String message);
}

class EmailNotifier implements Notifier {
  @override
  void notify(String recipient, String message) =>
      print('📧 [Email] To: $recipient -> $message');
}

class SmsNotifier implements Notifier {
  @override
  void notify(String recipient, String message) =>
      print('📱 [SMS] To: $recipient -> $message');
}

class NullNotifier implements Notifier {
  @override
  void notify(String recipient, String message) {} // نمط الكائن الفارغ (Null Object Pattern)
}

/// كلاس العميل النظيف الذي يركب السلوكيات عبر الـ Composition
class CleanCustomer {
  final String id;
  final String name;
  final String contactInfo;
  final Notifier notifier;

  const CleanCustomer({
    required this.id,
    required this.name,
    required this.contactInfo,
    this.notifier = const NullNotifier(),
  });

  void sendAccountAlert(String alertText) {
    notifier.notify(contactInfo, alertText);
  }
}

void main() {
  print('=== 🔴 كود المقارنة: شجرة الوراثة العميقة مقابل التركيب النظيف ===\n');

  // عميل يستلم إشعارات بريد
  final customer1 = CleanCustomer(
    id: 'CUST-1',
    name: 'Karim Taha',
    contactInfo: 'karim@work.com',
    notifier: EmailNotifier(),
  );
  customer1.sendAccountAlert('تم تحديث رصيدك بنجاح.');

  // عميل يستلم رسائل نصية قصيرة SMS
  final customer2 = CleanCustomer(
    id: 'CUST-2',
    name: 'Mona Zaki',
    contactInfo: '01122334455',
    notifier: SmsNotifier(),
  );
  customer2.sendAccountAlert('كود الأمان الخاص بك هو 5511.');

  // عميل لا يرغب في أي إشعارات (بدون كتابة كود شاذ)
  final customerQuiet = CleanCustomer(
    id: 'CUST-3',
    name: 'Anonymous Shopper',
    contactInfo: 'none',
  );
  customerQuiet.sendAccountAlert('لن يظهر أي شيء في وحدة التحكم!');

  print('\n✅ النتيجة: فصلنا طريقة الإشعار تماماً عن كيان العميل بدون أي وراثة معقدة.');
}
