/// ==============================================================================
/// File: 02_intermediate_records_destructuring.dart
/// Educational Objective: Master Dart 3 Records as immutable, anonymous aggregates,
/// utilize named and positional fields, and perform multi-variable destructuring.
///
/// Execution:
///   dart run 02_intermediate_records_destructuring.dart
/// ==============================================================================

// 1. Function returning an anonymous positional Record
(String, int, bool) parseUserEntry(String rawLine) {
  // Simulating parsing CSV: "Ahmed,28,true"
  final parts = rawLine.split(',');
  return (parts[0].trim(), int.parse(parts[1].trim()), parts[2].trim() == 'true');
}

// 2. Function returning a Record with mixed positional and named fields
({String code, double rate, DateTime effectiveDate}) fetchFxRate(String currencyPair) {
  return (
    code: currencyPair,
    rate: 50.45,
    effectiveDate: DateTime.now(),
  );
}

// 3. Coordinate record type alias
typedef GeoPoint = (double lat, double lng);

void main() {
  print('=== STEP 1: Basic Records and Field Access ===');
  final userRecord = parseUserEntry('Mahmoud,32,true');

  // Positional fields are accessed via $1, $2, $3 ...
  print('Raw Positional Record: $userRecord');
  print('Name: ${userRecord.$1}, Age: ${userRecord.$2}, Active: ${userRecord.$3}');

  // Named fields access
  final fx = fetchFxRate('USD/EGP');
  print('\nNamed Record: FX Code=${fx.code}, Rate=${fx.rate}, Date=${fx.effectiveDate}');

  print('\n=== STEP 2: Destructuring Assignment ===');
  // Destructuring unpacks the record directly into individual typed local variables!
  final (userName, userAge, isVerified) = parseUserEntry('Fatima,27,false');
  print('Destructured variables: Name="$userName", Age=$userAge, Verified=$isVerified');

  // Destructuring named record
  final (:code, :rate, :effectiveDate) = fetchFxRate('EUR/EGP');
  print('Destructured named: code=$code, rate=$rate');

  print('\n=== STEP 3: Structural Equality of Records ===');
  // Two distinct records with the same field values and types are AUTOMATICALLY EQUAL!
  // No need to override == or hashCode!
  final r1 = ('Cairo', 30.0);
  final r2 = ('Cairo', 30.0);
  final r3 = ('Alexandria', 31.2);

  print('r1 == r2? ${r1 == r2} (Value Equality: TRUE)');
  print('r1 == r3? ${r1 == r3} (Value Equality: FALSE)');
  print('r1.hashCode == r2.hashCode? ${r1.hashCode == r2.hashCode} (TRUE)');

  print('\n=== STEP 4: Swapping Variables Without Temp Variables ===');
  var a = 'FIRST';
  var b = 'SECOND';
  print('Before swap: a=$a, b=$b');

  // Clean, instantaneous variable swapping using Record destructuring!
  (a, b) = (b, a);
  print('After swap:  a=$a, b=$b');
}
