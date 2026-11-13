enum InstrumentType {
  stock('Acción'),
  etf('ETF');

  const InstrumentType(this.label);
  final String label;
}

class MarketInstrument {
  const MarketInstrument({
    required this.name,
    required this.symbol,
    required this.type,
    required this.day,
    this.description,
  });

  final String name;
  final String symbol;
  final InstrumentType type;
  final double day;
  final String? description;
}
