import 'sector.dart';

enum TrafficLight { green, yellow, red }

/// Rendimiento (en %) de un sector en distintos plazos.
class SectorPerformance {
  const SectorPerformance({
    required this.sector,
    required this.day,
    required this.week,
    required this.month,
    required this.year,
    this.driver,
  });

  final Sector sector;
  final double day;
  final double week;
  final double month;
  final double year;

  /// Explicación simple de qué mueve al sector hoy.
  final String? driver;

  static const double _threshold = 0.5;

  TrafficLight get light {
    if (day >= _threshold) return TrafficLight.green;
    if (day <= -_threshold) return TrafficLight.red;
    return TrafficLight.yellow;
  }
}
