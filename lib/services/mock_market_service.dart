import '../models/sector.dart';
import '../models/sector_performance.dart';
import 'market_service.dart';
import 'mock_instruments.dart';

class MockMarketService implements MarketService {
  MockMarketService({
    this.latency = const Duration(milliseconds: 600),
    this.shouldFail = false,
  });

  final Duration latency;

  /// Permite probar el estado de error en la UI.
  final bool shouldFail;

  @override
  Future<List<SectorPerformance>> fetchSectors() async {
    await Future<void>.delayed(latency);
    if (shouldFail) throw Exception('Servicio no disponible (mock)');
    return [
      for (final item in _data)
        SectorPerformance(
          sector: item.sector,
          day: item.day,
          week: item.week,
          month: item.month,
          year: item.year,
          driver: item.driver,
          instruments:
              mockInstruments[item.sector.id] ??
              (throw StateError(
                'Faltan instrumentos de ejemplo para ${item.sector.id}',
              )),
        ),
    ];
  }

  static const List<SectorPerformance> _data = [
    SectorPerformance(
      sector: Sector(
        id: 'tech',
        name: 'Tecnología',
        etf: 'XLK',
        category: SectorCategory.crecimiento,
        risk: RiskLevel.alto,
        description:
            'Empresas que crean software, hardware y servicios digitales.',
        keywords: [
          'Software',
          'Inteligencia Artificial',
          'Cloud',
          'Semiconductores',
        ],
      ),
      day: 2.35,
      week: 4.50,
      month: 8.70,
      year: 24.50,
      driver: 'Impulsado por Inteligencia Artificial y Semiconductores.',
    ),
    SectorPerformance(
      sector: Sector(
        id: 'comm',
        name: 'Comunicación',
        etf: 'XLC',
        category: SectorCategory.crecimiento,
        risk: RiskLevel.alto,
        description: 'Redes sociales, streaming, telecomunicaciones y medios.',
        keywords: ['Redes sociales', 'Streaming', 'Publicidad digital'],
      ),
      day: 0.80,
      week: 1.90,
      month: 3.20,
      year: 18.10,
      driver: 'La publicidad digital sigue creciendo.',
    ),
    SectorPerformance(
      sector: Sector(
        id: 'disc',
        name: 'Consumo Discrecional',
        etf: 'XLY',
        category: SectorCategory.crecimiento,
        risk: RiskLevel.alto,
        description: 'Lo que la gente compra cuando le sobra dinero.',
        keywords: ['Autos', 'Comercio electrónico', 'Viajes', 'Restaurantes'],
      ),
      day: 0.30,
      week: 1.10,
      month: 2.40,
      year: 12.60,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'health',
        name: 'Salud',
        etf: 'XLV',
        category: SectorCategory.defensivo,
        risk: RiskLevel.medio,
        description: 'Farmacéuticas, hospitales y tecnología médica.',
        keywords: ['Farmacéuticas', 'Biotecnología', 'Hospitales'],
      ),
      day: 0.10,
      week: 0.60,
      month: 1.50,
      year: 7.80,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'staples',
        name: 'Consumo Básico',
        etf: 'XLP',
        category: SectorCategory.defensivo,
        risk: RiskLevel.bajo,
        description:
            'Productos que se compran siempre: comida, higiene, hogar.',
        keywords: ['Alimentos', 'Bebidas', 'Supermercados'],
      ),
      day: -0.20,
      week: 0.10,
      month: 0.90,
      year: 5.40,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'util',
        name: 'Servicios públicos',
        etf: 'XLU',
        category: SectorCategory.defensivo,
        risk: RiskLevel.bajo,
        description: 'Empresas de electricidad, agua y gas.',
        keywords: ['Electricidad', 'Agua', 'Gas', 'Energía renovable'],
      ),
      day: -0.90,
      week: -1.20,
      month: -0.50,
      year: 3.10,
      driver: 'Suben las tasas de interés y pesan sobre sectores con deuda.',
    ),
    SectorPerformance(
      sector: Sector(
        id: 'fin',
        name: 'Finanzas',
        etf: 'XLF',
        category: SectorCategory.economia,
        risk: RiskLevel.medio,
        description: 'Bancos, aseguradoras y servicios financieros.',
        keywords: ['Bancos', 'Seguros', 'Pagos'],
      ),
      day: 0.40,
      week: 1.30,
      month: 2.80,
      year: 14.20,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'ind',
        name: 'Industrial',
        etf: 'XLI',
        category: SectorCategory.economia,
        risk: RiskLevel.medio,
        description: 'Fabricación, transporte, defensa y construcción.',
        keywords: ['Maquinaria', 'Aerolíneas', 'Defensa', 'Logística'],
      ),
      day: 0.55,
      week: 1.60,
      month: 3.90,
      year: 16.70,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'mat',
        name: 'Materiales',
        etf: 'XLB',
        category: SectorCategory.economia,
        risk: RiskLevel.medio,
        description: 'Materias primas para construir y fabricar.',
        keywords: ['Químicos', 'Minería', 'Acero'],
      ),
      day: -0.70,
      week: -0.80,
      month: 0.20,
      year: 4.60,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'energy',
        name: 'Energía',
        etf: 'XLE',
        category: SectorCategory.economia,
        risk: RiskLevel.alto,
        description: 'Petróleo, gas y combustibles.',
        keywords: ['Petróleo', 'Gas natural', 'Refinerías'],
      ),
      day: 1.45,
      week: 3.10,
      month: 5.30,
      year: 9.40,
      driver: 'Sube el precio del petróleo.',
    ),
    SectorPerformance(
      sector: Sector(
        id: 'defense',
        name: 'Defensa y aeroespacial',
        etf: 'ITA',
        category: SectorCategory.economia,
        risk: RiskLevel.alto,
        description:
            'Empresas que fabrican aeronaves, sistemas de defensa y equipos militares. Algunas también forman parte del sector Industrial. Los conflictos y presupuestos militares pueden influir en sus resultados, pero no garantizan subidas.',
        keywords: ['Aeronaves', 'Defensa', 'Tecnología militar'],
      ),
      day: 0.65,
      week: 1.20,
      month: 2.40,
      year: 10.20,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'reit',
        name: 'Bienes raíces',
        etf: 'VNQ',
        category: SectorCategory.patrimonio,
        risk: RiskLevel.medio,
        description: 'Fondos que poseen inmuebles y cobran alquileres.',
        keywords: ['Oficinas', 'Centros comerciales', 'Vivienda'],
      ),
      day: -1.10,
      week: -1.80,
      month: -2.30,
      year: 1.20,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'commodities',
        name: 'Materias primas',
        etf: null,
        category: SectorCategory.alternativos,
        risk: RiskLevel.medio,
        description:
            'Recursos como el oro, la plata y el cobre. El oro y la plata son metales preciosos; el cobre se usa en la industria y la construcción. A diferencia del área Materiales, aquí observamos productos y no empresas que los producen.',
        keywords: ['Oro', 'Plata', 'Cobre'],
      ),
      day: null,
      week: null,
      month: null,
      year: null,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'btc',
        name: 'Bitcoin',
        etf: 'IBIT',
        category: SectorCategory.alternativos,
        risk: RiskLevel.alto,
        description: 'La criptomoneda más grande, muy volátil.',
        keywords: ['Cripto', 'Volatilidad', 'Activo digital'],
      ),
      day: 1.90,
      week: 5.20,
      month: 11.40,
      year: 45.30,
      driver: 'Mayor entrada de dinero institucional.',
    ),
    SectorPerformance(
      sector: Sector(
        id: 'intl',
        name: 'Internacional',
        etf: 'VXUS',
        category: SectorCategory.geografia,
        risk: RiskLevel.medio,
        description:
            'Empresas de países desarrollados y emergentes fuera de EE.UU.',
        keywords: ['Europa', 'Japón', 'Diversificación'],
      ),
      day: 0.25,
      week: 0.80,
      month: 1.60,
      year: 9.90,
    ),
    SectorPerformance(
      sector: Sector(
        id: 'em',
        name: 'Emergentes',
        etf: 'VWO',
        category: SectorCategory.geografia,
        risk: RiskLevel.alto,
        description: 'Empresas de países en desarrollo como China o India.',
        keywords: ['China', 'India', 'Brasil', 'Crecimiento'],
      ),
      day: -0.15,
      week: 0.40,
      month: 1.90,
      year: 6.70,
    ),
  ];
}
