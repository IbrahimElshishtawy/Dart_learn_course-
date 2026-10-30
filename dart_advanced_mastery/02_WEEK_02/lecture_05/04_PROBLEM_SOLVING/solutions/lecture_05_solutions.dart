// ==============================================================================
// lecture_05_solutions.dart
// Week 02 - Lecture 05: Official Problem Solving Solutions
// ==============================================================================

// -----------------------------------------------------------------------------
// حل المسألة 1: نظام حساب الرسوم للمركبات (Polymorphic Toll Booth)
// -----------------------------------------------------------------------------
abstract class Vehicle {
  final String licensePlate;
  const Vehicle(this.licensePlate);

  double calculateToll();
}

class Motorcycle extends Vehicle {
  const Motorcycle(super.licensePlate);
  @override
  double calculateToll() => 10.0;
}

class Car extends Vehicle {
  const Car(super.licensePlate);
  @override
  double calculateToll() => 25.0;
}

class Truck extends Vehicle {
  final double cargoWeightInTons;

  const Truck(super.licensePlate, {this.cargoWeightInTons = 0.0});

  @override
  double calculateToll() => 50.0 + (cargoWeightInTons * 10.0);
}

class TollStation {
  double _totalCollected = 0.0;
  int _vehiclesCount = 0;

  double get totalCollected => _totalCollected;
  int get vehiclesCount => _vehiclesCount;

  double processVehicle(Vehicle vehicle) {
    final toll = vehicle.calculateToll();
    _totalCollected += toll;
    _vehiclesCount++;
    return toll;
  }
}

// -----------------------------------------------------------------------------
// حل المسألة 2: محرك تقارير التصدير متعدد الصيغ (Document Exporter)
// -----------------------------------------------------------------------------
class ReportData {
  final String title;
  final DateTime generatedAt;
  final List<String> rows;

  const ReportData({
    required this.title,
    required this.generatedAt,
    required this.rows,
  });
}

abstract class ReportFormatter {
  String format(ReportData data);
}

class JsonReportFormatter implements ReportFormatter {
  @override
  String format(ReportData data) {
    final rowsJson = data.rows.map((r) => '"$r"').join(', ');
    return '{"title": "${data.title}", "rows": [$rowsJson]}';
  }
}

class CsvReportFormatter implements ReportFormatter {
  @override
  String format(ReportData data) {
    final buffer = StringBuffer('TITLE: ${data.title}\n');
    for (final row in data.rows) {
      buffer.writeln(row);
    }
    return buffer.toString().trim();
  }
}

class ReportGenerator {
  final ReportFormatter formatter;

  const ReportGenerator(this.formatter);

  String generate(ReportData data) => formatter.format(data);
}

// -----------------------------------------------------------------------------
// حل المسألة 3: خط معالجة الفلاتر الحسابية (Pipeline / Filter Pattern)
// -----------------------------------------------------------------------------
abstract class TextFilter {
  String apply(String input);
}

class TrimFilter implements TextFilter {
  @override
  String apply(String input) => input.trim();
}

class UpperCaseFilter implements TextFilter {
  @override
  String apply(String input) => input.toUpperCase();
}

class CensorBadWordsFilter implements TextFilter {
  final Set<String> bannedWords;

  const CensorBadWordsFilter(this.bannedWords);

  @override
  String apply(String input) {
    var output = input;
    for (final word in bannedWords) {
      output = output.replaceAll(RegExp(RegExp.escape(word), caseSensitive: false), '***');
    }
    return output;
  }
}

class FilterPipeline {
  final List<TextFilter> _filters = [];

  void addFilter(TextFilter filter) {
    _filters.add(filter);
  }

  String execute(String rawText) {
    var currentText = rawText;
    for (final filter in _filters) {
      currentText = filter.apply(currentText);
    }
    return currentText;
  }
}

// -----------------------------------------------------------------------------
// كود التحقق الذاتي والاختبارات
// -----------------------------------------------------------------------------
void main() {
  print('=== 🧪 تشغيل حلول وتأكيدات مسائل المحاضرة 5 ===');

  // 1. اختبار TollStation
  final station = TollStation();
  assert(station.processVehicle(const Motorcycle('M-101')) == 10.0);
  assert(station.processVehicle(const Car('C-202')) == 25.0);
  assert(station.processVehicle(const Truck('T-303', cargoWeightInTons: 3.5)) == 85.0);
  assert(station.totalCollected == 120.0);
  assert(station.vehiclesCount == 3);
  print('✅ المسألة 1 (Polymorphic Toll Station): تم التحقق واجتياز الحسابات.');

  // 2. اختبار ReportGenerator
  final report = ReportData(
    title: 'Monthly Sales',
    generatedAt: DateTime.now(),
    rows: ['Widget A, \$500', 'Widget B, \$800'],
  );
  final jsonGen = ReportGenerator(JsonReportFormatter());
  final csvGen = ReportGenerator(CsvReportFormatter());

  assert(jsonGen.generate(report).contains('"title": "Monthly Sales"'));
  assert(csvGen.generate(report).contains('TITLE: Monthly Sales'));
  print('✅ المسألة 2 (Document Exporter): تم التحقق واجتياز التعددية الشكلية.');

  // 3. اختبار FilterPipeline
  final pipeline = FilterPipeline()
    ..addFilter(TrimFilter())
    ..addFilter(const CensorBadWordsFilter({'SPAM', 'HACK'}))
    ..addFilter(UpperCaseFilter());

  final filtered = pipeline.execute('   hello spam world hack test   ');
  assert(filtered == 'HELLO *** WORLD *** TEST');
  print('✅ المسألة 3 (Pipeline Filter Pattern): تم التحقق واجتياز تسلسل الفلاتر.');

  print('\n🎉 جميع حلول المحاضرة 5 سليمة وجاهزة 100%!');
}
