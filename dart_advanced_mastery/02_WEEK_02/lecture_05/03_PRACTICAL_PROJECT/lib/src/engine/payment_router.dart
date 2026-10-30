import '../models/payment_request.dart';
import '../models/payment_result.dart';
import '../gateways/payment_gateway.dart';

/// Central Polymorphic Payment Router.
/// Routes requests dynamically to appropriate gateways using composition.
class PaymentRouter {
  final List<PaymentGateway> _registeredGateways = [];

  PaymentRouter([List<PaymentGateway>? initialGateways]) {
    if (initialGateways != null) {
      _registeredGateways.addAll(initialGateways);
    }
  }

  int get registeredGatewayCount => _registeredGateways.length;

  void registerGateway(PaymentGateway gateway) {
    if (!_registeredGateways.any((g) => g.id == gateway.id)) {
      _registeredGateways.add(gateway);
    }
  }

  PaymentResult routeAndProcess(PaymentRequest request, {String? preferredGatewayId}) {
    if (!request.isValid) {
      return PaymentResult.failure(
        orderId: request.orderId,
        gatewayProvider: 'Router Validation',
        errorMessage: 'Invalid payment request parameters (check email, order ID, or amount).',
      );
    }

    // 1. إذا حدد العميل بوابة بعينها
    if (preferredGatewayId != null) {
      final match = _registeredGateways.where((g) => g.id == preferredGatewayId);
      if (match.isEmpty) {
        return PaymentResult.failure(
          orderId: request.orderId,
          gatewayProvider: 'PaymentRouter',
          errorMessage: 'Requested gateway "$preferredGatewayId" is not registered in router.',
        );
      }

      final gateway = match.first;
      if (!gateway.canHandle(request)) {
        return PaymentResult.failure(
          orderId: request.orderId,
          gatewayProvider: gateway.displayName,
          errorMessage: 'Gateway "${gateway.displayName}" cannot process currency "${request.currency}".',
        );
      }

      return gateway.process(request);
    }

    // 2. توجيه تلقائي لأول بوابة تدعم العملة
    for (final gateway in _registeredGateways) {
      if (gateway.canHandle(request)) {
        return gateway.process(request);
      }
    }

    return PaymentResult.failure(
      orderId: request.orderId,
      gatewayProvider: 'PaymentRouter',
      errorMessage: 'No registered gateway can handle currency "${request.currency}".',
    );
  }
}
