enum SectorCategory {
  crecimiento('Crecimiento'),
  defensivo('Defensivo'),
  economia('Economía'),
  patrimonio('Patrimonio'),
  estrategia('Estrategia'),
  alternativos('Alternativos'),
  geografia('Geografía');

  const SectorCategory(this.label);
  final String label;
}

enum RiskLevel {
  bajo('Bajo'),
  medio('Medio'),
  alto('Alto');

  const RiskLevel(this.label);
  final String label;
}

/// Información estática de un sector (no cambia con el mercado).
class Sector {
  const Sector({
    required this.id,
    required this.name,
    required this.etf,
    required this.category,
    required this.risk,
    required this.description,
    required this.keywords,
  });

  final String id;
  final String name;
  final String etf;
  final SectorCategory category;
  final RiskLevel risk;
  final String description;
  final List<String> keywords;
}
