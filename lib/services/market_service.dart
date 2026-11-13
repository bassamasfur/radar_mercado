import '../models/sector_performance.dart';

/// Contrato de datos de mercado. Hoy lo implementa un mock;
/// luego se reemplaza por la API Node.js sin tocar controladores ni vistas.
abstract class MarketService {
  Future<List<SectorPerformance>> fetchSectors();
}
