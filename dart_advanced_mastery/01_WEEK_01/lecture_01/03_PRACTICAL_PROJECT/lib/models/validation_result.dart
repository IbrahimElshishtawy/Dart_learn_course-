/// The overall status of a transaction validation check
enum ValidationStatus { approved, rejected, requiresManualReview }

/// Encapsulates the complete diagnostic outcome of an audit
class ValidationResult {
  final ValidationStatus status;
  final List<String> rejectionReasons;
  final DateTime auditedAt;
  final String? auditRiskScore;

  const ValidationResult._({
    required this.status,
    required this.rejectionReasons,
    required this.auditedAt,
    this.auditRiskScore,
  });

  factory ValidationResult.approved({String riskScore = 'LOW_RISK'}) {
    return ValidationResult._(
      status: ValidationStatus.approved,
      rejectionReasons: const <String>[],
      auditedAt: DateTime.now(),
      auditRiskScore: riskScore,
    );
  }

  factory ValidationResult.rejected(List<String> reasons, {String riskScore = 'HIGH_RISK'}) {
    return ValidationResult._(
      status: ValidationStatus.rejected,
      rejectionReasons: List<String>.unmodifiable(reasons),
      auditedAt: DateTime.now(),
      auditRiskScore: riskScore,
    );
  }

  factory ValidationResult.requiresManualReview(List<String> warnings) {
    return ValidationResult._(
      status: ValidationStatus.requiresManualReview,
      rejectionReasons: List<String>.unmodifiable(warnings),
      auditedAt: DateTime.now(),
      auditRiskScore: 'ELEVATED_SUSPICION',
    );
  }

  bool get isApproved => status == ValidationStatus.approved;

  @override
  String toString() {
    if (isApproved) {
      return '[PASSED] Status: $status (Score: $auditRiskScore) at $auditedAt';
    }
    return '[FAILED] Status: $status (Score: $auditRiskScore). Reasons: ${rejectionReasons.join("; ")}';
  }
}
