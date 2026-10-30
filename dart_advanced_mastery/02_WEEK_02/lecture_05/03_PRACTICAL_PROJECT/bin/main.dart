import 'package:modular_payment_gateway/modular_payment_gateway.dart';

void main() {
  print('===========================================================');
  print('💳 Lecture 05 Practical Project: Modular Payment Gateway');
  print('===========================================================\n');

  // 1. تجهيز الـ Router وتسجيل البوابات المتعددة
  final router = PaymentRouter([
    StripeGateway(),
    PaypalGateway(),
    FawryGateway(),
  ]);

  print('✅ تم تسجيل ${router.registeredGatewayCount} بوابات دفع في النظام.\n');

  // 2. تجربة عملية دفع بالدولار (توجيه تلقائي لـ Stripe)
  final reqUSD = PaymentRequest(
    orderId: 'ORDER-101',
    customerEmail: 'ahmed.dev@example.com',
    amount: 149.99,
    currency: 'USD',
  );
  print('1. معالجة طلب بالدولار الأمريكي (USD):');
  final resUSD = router.routeAndProcess(reqUSD);
  print('   $resUSD\n');

  // 3. تجربة عملية دفع بالجنيه المصري (توجيه تلقائي لـ Fawry)
  final reqEGP = PaymentRequest(
    orderId: 'ORDER-202',
    customerEmail: 'sara.egypt@example.com',
    amount: 2500.0,
    currency: 'EGP',
  );
  print('2. معالجة طلب بالجنيه المصري (EGP):');
  final resEGP = router.routeAndProcess(reqEGP);
  print('   $resEGP\n');

  // 4. تجربة توجيه محدد لـ PayPal
  print('3. طلب دفع مع تحديد بوابة PayPal صراحة:');
  final resPayPal = router.routeAndProcess(reqUSD, preferredGatewayId: 'paypal');
  print('   $resPayPal\n');

  // 5. تجربة عملة غير مدعومة (Defensive Routing)
  final reqJPY = PaymentRequest(
    orderId: 'ORDER-999',
    customerEmail: 'tokyo@example.com',
    amount: 10000.0,
    currency: 'JPY',
  );
  print('4. طلب دفع بعملة الين الياباني غير المدعومة:');
  final resJPY = router.routeAndProcess(reqJPY);
  print('   $resJPY\n');

  print('===========================================================');
}
