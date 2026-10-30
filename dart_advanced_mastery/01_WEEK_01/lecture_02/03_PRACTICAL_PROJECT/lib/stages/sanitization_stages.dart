/// Reusable pure sanitization stages designed for tear-off usage in pipelines
class SanitizationStages {
  /// Strips leading and trailing whitespaces
  static String trim(String raw) => raw.trim();

  /// Normalizes casing to lowercase
  static String toLowerCase(String raw) => raw.toLowerCase();

  /// Replaces underscores and hyphens with spaces
  static String normalizeSeparators(String raw) =>
      raw.replaceAll(RegExp(r'[-_]'), ' ');

  /// Parses string to strictly positive integer or throws FormatException
  static int parsePositiveInt(String raw) {
    final parsed = int.parse(raw.trim());
    if (parsed <= 0) {
      throw FormatException('Parsed integer must be strictly positive: $parsed');
    }
    return parsed;
  }
}
