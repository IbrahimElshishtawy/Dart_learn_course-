/// ==============================================================================
/// File: 03_advanced_higher_order_and_tearoffs.dart
/// Educational Objective: Master Higher-Order Functions (HOFs), Constructor & Method Tear-offs,
/// Function Type Aliases (`typedef`), and Functional Composition ($f \circ g$).
///
/// Execution:
///   dart run 03_advanced_higher_order_and_tearoffs.dart
/// ==============================================================================

// Generic Function Type Alias
typedef UnaryFunction<T, R> = R Function(T input);

class DataSanitizer {
  // Static method tear-off candidate
  static String trimAndLower(String raw) => raw.trim().toLowerCase();

  // Instance method tear-off candidate
  String prefixWithDomain(String text) => 'https://enterprise.internal/$text';
}

class UserRecord {
  final String username;
  // Constructor tear-off candidate: UserRecord.new
  const UserRecord(this.username);

  @override
  String toString() => 'UserRecord(username: $username)';
}

/// Higher-Order Function: Mathematical Function Composition: h(x) = f(g(x))
UnaryFunction<A, C> compose<A, B, C>(UnaryFunction<B, C> f, UnaryFunction<A, B> g) {
  return (A input) => f(g(input));
}

void main() {
  print('=== STEP 1: Method, Static, and Constructor Tear-offs ===');

  final rawUsernames = <String>['  Ahmed_Dev ', ' Sara_Architect  ', '  YOUSSEF '];

  // 1. Static Method Tear-off: DataSanitizer.trimAndLower
  // Instead of: rawUsernames.map((u) => DataSanitizer.trimAndLower(u))
  final sanitized = rawUsernames.map(DataSanitizer.trimAndLower).toList();
  print('Sanitized with Static Tear-off: $sanitized');

  // 2. Instance Method Tear-off:
  final sanitizer = DataSanitizer();
  // Instead of: sanitized.map((u) => sanitizer.prefixWithDomain(u))
  final urls = sanitized.map(sanitizer.prefixWithDomain).toList();
  print('URLs with Instance Tear-off: $urls');

  // 3. Constructor Tear-off (Dart 2.15+ / 3.x feature):
  // Instead of: sanitized.map((u) => UserRecord(u))
  final userObjects = sanitized.map(UserRecord.new).toList();
  print('Constructed via UserRecord.new Tear-off: $userObjects');

  print('\n=== STEP 2: Functional Composition in Action ===');
  // Define atomic transformation functions
  int stringLength(String s) => s.length;
  bool isEvenNumber(int n) => n % 2 == 0;

  // Compose: String -> int -> bool
  final isStringLengthEven = compose<String, int, bool>(isEvenNumber, stringLength);

  print('"test" has even length? ${isStringLengthEven("test")}');     // 4 -> true
  print('"hello" has even length? ${isStringLengthEven("hello")}');   // 5 -> false

  print('\n=== STEP 3: Currying & Partial Application ===');
  // Transforming a 2-parameter function into a sequence of unary functions
  UnaryFunction<int, int> multiplyBy(int factor) {
    return (int number) => number * factor;
  }

  final doubleIt = multiplyBy(2);
  final tripleIt = multiplyBy(3);

  print('Double 15: ${doubleIt(15)}');
  print('Triple 15: ${tripleIt(15)}');
}
