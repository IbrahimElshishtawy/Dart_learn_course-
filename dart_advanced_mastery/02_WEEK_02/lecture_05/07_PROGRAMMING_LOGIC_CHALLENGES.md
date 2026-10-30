# Lecture 05: Programming Logic & OOP Architecture Challenges
# تحديات المنطق البرمجي وتصميم الأنظمة - المحاضرة 5

## 🧩 التحدي 1: نظام التخزين السحابي متعدد المزودين (Multi-Cloud Storage Engine)
صمم نظاماً لرفع الملفات إلى مزودي السحاب المختلفين:
1. صمم واجهة `CloudStorageProvider` تحتوي على:
   - `Future<bool> uploadFile(String fileName, List<int> bytes)` (يمكن تمثيلها كدالة عادية متزامنة حالياً).
   - `String getProviderName()`.
2. نفذ 3 فئات تطبق الواجهة: `AwsS3Provider`, `GoogleCloudStorageProvider`, `LocalFileSystemProvider`.
3. صمم كلاس `BackupManager` يستقبل مزود التخزين عبر الـ Constructor (Composition)، ويحتوي على دالة `performBackup(String fileName, List<int> data)`، مع إضافة ميزة الفشل التلقائي (Fallback): إذا فشل الرفع في المزود الأساسي، يجرب المزود الاحتياطي.

---

## 🧩 التحدي 2: لعبة المحاربين بنمط الاستراتيجية (Role-Playing Combat Strategies)
صمم نظام قتال في لعبة مغامرات دون استخدام الوراثة الصلبة:
1. صمم واجهة `AttackBehavior` تحتوي على دالة `int executeAttack()`.
2. نفذ السلوكيات التالية:
   - `SwordAttack`: يسبب 25 ضرر.
   - `BowAndArrowAttack`: يسبب 18 ضرر.
   - `MagicSpellAttack`: يسبب 40 ضرر.
3. صمم كلاس `Hero` يمتلك `healthPoints` و `attackBehavior`.
4. مكن البطل من تغيير سلاحه في أي وقت أثناء المعركة `setAttackBehavior(AttackBehavior newBehavior)` لإثبات قوة الـ Composition في تغيير السلوك ديناميكياً أثناء وقت التشغيل (Runtime).
