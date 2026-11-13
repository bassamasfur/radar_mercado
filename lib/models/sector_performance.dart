import 'sector.dart';
import 'market_instrument.dart';

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
    this.instruments = const [],
  });

  final Sector sector;
  final double? day;
  final double? week;
  final double? month;
  final double? year;
  final List<MarketInstrument> instruments;

  List<MarketInstrument> get rankedInstruments =>
      [...instruments]..sort((a, b) => b.day.compareTo(a.day));

  /// Explicación simple de qué mueve al sector hoy.
  final String? driver;

  static const double _threshold = 0.5;

  TrafficLight? get light {
    final value = day;
    if (value == null) return null;
    if (value >= _threshold) return TrafficLight.green;
    if (value <= -_threshold) return TrafficLight.red;
    return TrafficLight.yellow;
  }
}
