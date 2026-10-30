// ==============================================================================
// 01_beginner_inheritance_abstract.dart
// Week 02 - Lecture 05: Abstract Classes & Inheritance Basics
// ==============================================================================
// الهدف: فهم المفهوم التأسيسي للكلاس المجرد (Abstract Class) والوراثة (Inheritance):
// 1. لماذا لا يمكن إنشاء كائن مباشر من Abstract Class؟
// 2. استخدام extends لوراثة الخصائص والدوال المشتركة.
// 3. إعادة تعريف الدوال المجردة عبر @override.
// 4. استدعاء منشئ الفئة الأم باستخدام super.
// ==============================================================================

/// الفئة الأم المجردة: تحدد العقد والسلوك المشترك لجميع وسائل الإشعار
abstract class NotificationService {
  final String senderName;
  final DateTime createdAt;

  NotificationService(this.senderName) : createdAt = DateTime.now();

  // دالة مجردة (بدون جسم): تلزم أي فئة ترثها بكتابة المنطق الخاص بها
  bool sendNotification({required String recipient, required String message});

  // دالة عادية (لها كود افتراضي): يمكن لجميع الأبناء استخدامها مباشرة
  void logAudit(String recipient, bool success) {
    print('📋 [Audit Log] Sender: $senderName | To: $recipient | Status: ${success ? "SUCCESS" : "FAILED"} | Time: $createdAt');
  }
}

/// فئة فرعية 1: إرسال عبر البريد الإلكتروني
class EmailNotificationService extends NotificationService {
  final String smtpServer;

  EmailNotificationService({
    required String senderName,
    required this.smtpServer,
  }) : super(senderName); // تمرير البيانات لمنشئ الفئة الأم

  @override
  bool sendNotification({required String recipient, required String message}) {
    if (!recipient.contains('@')) {
      print('❌ خطأ في الإيميل: العنوان "$recipient" غير صالح!');
      logAudit(recipient, false);
      return false;
    }

    print('📧 [Email via $smtpServer] From: $senderName -> To: $recipient');
    print('   Body: $message');
    logAudit(recipient, true);
    return true;
  }
}

/// فئة فرعية 2: إرسال عبر الرسائل النصية القصيرة SMS
class SmsNotificationService extends NotificationService {
  final String telecomProvider;

  SmsNotificationService({
    required String senderName,
    required this.telecomProvider,
  }) : super(senderName);

  @override
  bool sendNotification({required String recipient, required String message}) {
    if (recipient.length < 10) {
      print('❌ خطأ في الهاتف: الرقم "$recipient" غير مكتمل!');
      logAudit(recipient, false);
      return false;
    }

    print('📱 [SMS via $telecomProvider] From: $senderName -> To: $recipient');
    print('   SMS Text: $message');
    logAudit(recipient, true);
    return true;
  }
}

void main() {
  print('=== 🟢 كود المحاضرة 5: الكلاسات المجردة والوراثة الأساسية ===\n');

  // 1. لا يمكن عمل new من الكلاس المجرد مباشرة:
  // final test = NotificationService("Admin"); // ❌ هذا يسبب خطأ ترجمة Compilation Error

  // 2. استخدام الفئات الفرعية
  final emailService = EmailNotificationService(
    senderName: 'Billing Team',
    smtpServer: 'smtp.google.com',
  );

  final smsService = SmsNotificationService(
    senderName: 'Security OTP',
    telecomProvider: 'Vodafone-Enterprise',
  );

  print('1. تجربة إرسال بريد إلكتروني:');
  emailService.sendNotification(
    recipient: 'student@example.com',
    message: 'تم تفعيل حسابك الأكاديمي بنجاح.',
  );

  print('\n2. تجربة إرسال رسالة نصية قصيرة SMS:');
  smsService.sendNotification(
    recipient: '01012345678',
    message: 'رمز التحقق الخاص بك هو 9482.',
  );

  print('\n3. تجربة التحقق الدفاعي من الأخطاء:');
  emailService.sendNotification(
    recipient: 'invalid-email-string',
    message: 'رسالة اختبارية',
  );
}
