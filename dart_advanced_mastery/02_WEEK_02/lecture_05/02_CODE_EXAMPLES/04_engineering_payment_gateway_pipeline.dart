// ==============================================================================
// 04_engineering_payment_gateway_pipeline.dart
// Week 02 - Lecture 05: Enterprise Payment Processing Pipeline
// ==============================================================================
// الهدف: تطبيق بنية معمارية احترافية تحاكي أنظمة الدفع العالمية:
// 1. تعريف واجهة بوابة الدفع (PaymentGateway).
// 2. تطبيق وسيط المعالجة (Middleware Pipeline) للتحقق والتسجيل.
// 3. التعامل مع نتائج العمليات عبر كائنات نتيجة موحدة (PaymentResult).
// ==============================================================================

class PaymentRequest {
  final String transactionId;
  final String customerEmail;
  final double amount;
  final String currency;

  const PaymentRequest({
    required this.transactionId,
    required this.customerEmail,
    required this.amount,
    this.currency = 'USD',
  });
}

class PaymentResult {
  final bool isSuccess;
  final String transactionId;
  final String? authorizationCode;
  final String? errorMessage;
  final DateTime processedAt;

  PaymentResult.success({
    required this.transactionId,
    required this.authorizationCode,
  })  : isSuccess = true,
        errorMessage = null,
        processedAt = DateTime.now();

  PaymentResult.failure({
    required this.transactionId,
    required this.errorMessage,
  })  : isSuccess = false,
        authorizationCode = null,
        processedAt = DateTime.now();

  @override
  String toString() => isSuccess
      ? '✅ [SUCCESS] AuthCode: $authorizationCode | Ref: $transactionId'
      : '❌ [FAILURE] Error: $errorMessage | Ref: $transactionId';
}

/// العقد الأساسي لأي بوابة دفع
abstract class PaymentGateway {
  String get providerName;
  PaymentResult charge(PaymentRequest request);
}

/// تطبيق محاكي لبوابة Stripe
class StripeGateway implements PaymentGateway {
  @override
  final String providerName = 'Stripe Cloud Payments';

  @override
  PaymentResult charge(PaymentRequest request) {
    if (request.amount < 1.0) {
      return PaymentResult.failure(
        transactionId: request.transactionId,
        errorMessage: 'الحد الأدنى للدفع في Stripe هو \$1.00',
      );
    }
    return PaymentResult.success(
      transactionId: request.transactionId,
      authorizationCode: 'ch_stripe_${DateTime.now().microsecondsSinceEpoch}',
    );
  }
}

/// تطبيق محاكي لبوابة Fawry
class FawryGateway implements PaymentGateway {
  @override
  final String providerName = 'Fawry Enterprise Egypt';

  @override
  PaymentResult charge(PaymentRequest request) {
    if (!request.customerEmail.contains('@')) {
      return PaymentResult.failure(
        transactionId: request.transactionId,
        errorMessage: 'البريد الإلكتروني للعميل غير صالح لفوري',
      );
    }
    return PaymentResult.success(
      transactionId: request.transactionId,
      authorizationCode: 'FAWRY-${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}

/// المعالج الهندسي المركزي (Pipeline Coordinator)
class PaymentProcessor {
  final PaymentGateway gateway;

  const PaymentProcessor(this.gateway);

  PaymentResult execute(PaymentRequest request) {
    print('⚙️ [Pipeline] بدء العملية عبر مزود الخدمة: ${gateway.providerName}');
    print('   المبلغ: \$${request.amount} ${request.currency} للعميل: ${request.customerEmail}');

    // التحقق الدفاعي من المدخلات (Pre-flight validation)
    if (request.amount <= 0) {
      return PaymentResult.failure(
        transactionId: request.transactionId,
        errorMessage: 'المبلغ المطلوب دفعه يجب أن يكون موجباً',
      );
    }

    // تفويض المعالجة للبوابة المحددة (Delegation)
    final result = gateway.charge(request);
    print('   النتيجة: $result\n');
    return result;
  }
}

void main() {
  print('=== 🟣 كود المحاضرة 5: خط معالجة الدفع الهندسي المتقدم ===\n');

  final req1 = PaymentRequest(
    transactionId: 'TX-1001',
    customerEmail: 'customer1@example.com',
    amount: 120.50,
  );

  final reqInvalid = PaymentRequest(
    transactionId: 'TX-1002',
    customerEmail: 'bad-email',
    amount: 50.0,
  );

  // 1. تشغيل عبر Stripe
  final stripeProcessor = PaymentProcessor(StripeGateway());
  stripeProcessor.execute(req1);

  // 2. تشغيل نفس المنظومة عبر Fawry بنقرة زر واحدة
  final fawryProcessor = PaymentProcessor(FawryGateway());
  fawryProcessor.execute(req1);
  fawryProcessor.execute(reqInvalid); // اختبار فشل التحقق في فوري
}
