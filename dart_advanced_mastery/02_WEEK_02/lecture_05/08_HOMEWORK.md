# Lecture 05: Homework Assignment
# الواجب المنزلي والتطبيقي - المحاضرة الخامسة

## 📝 متطلبات الواجب:
1. **تصميم نظام حساب تكلفة الشحن (E-Commerce Shipping Calculator)**:
   - صمم واجهة `ShippingCarrier` تحتوي على:
     - `String get carrierName`.
     - `double calculateShippingCost(double weightInKg, double distanceInKm)`.
     - `int estimateDeliveryDays()`.
   - نفذ 3 شركات شحن مختلفة تطبق الواجهة:
     - `AramexExpress`: سعر أساسي 50 جنيهاً + 10 جنيهات لكل كيلو + نصف جنيه لكل كيلومتر. التوصيل خلال يومين.
     - `EgyptPost`: سعر أساسي 25 جنيهاً + 5 جنيهات لكل كيلو. التوصيل خلال 5 أيام.
     - `SameDayCourier`: سعر ثابت 120 جنيهاً مهما كان الوزن (بحد أقصى 5 كيلو). التوصيل في نفس اليوم (0 أيام).
2. **صمم كلاس السلة `CheckoutService`**:
   - يقبل شركة الشحن عبر الـ Composition.
   - يوفر دالة لمقارنة جميع شركات الشحن المسجلة واختيار أرخص شركة شحن للعميل تلقائياً `findCheapestCarrier()`.
3. **كتابة كود اختبار وتنفيذ `main.dart`**:
   - إثبات عمل النظام مع أوزان ومسافات مختلفة وطباعة المقارنة بصيغة واضحة ومهنية.
