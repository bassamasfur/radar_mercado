# Radar de Mercado

App Flutter para inversionistas principiantes: explica en lenguaje simple qué sectores lideran o están débiles en el mercado.

## Funcionalidades (MVP)

- Pantalla inicial con 16 áreas y variación diaria de ejemplo cuando hay ETF de referencia
- Detalle por área: explicación, rendimientos de ejemplo, riesgo orientativo e instrumentos ordenados por cambio diario simulado
- Materias primas explica oro, plata y cobre sin asignar un porcentaje general al grupo
- Los dividendos se explican en el detalle educativo, no como un sector independiente
- Sin registro

## Arquitectura (MVC)

```
lib/
  models/       Sector, SectorPerformance
  services/     MarketService (interfaz) + MockMarketService
  controllers/  MarketController (ChangeNotifier)
  views/        Páginas y widgets
  main.dart
```

Los porcentajes y las explicaciones de movimientos son ficticios: no representan el mercado real ni son recomendaciones de inversión. Los instrumentos muestran una selección ilustrativa, no los de mejor rendimiento real. Materias primas usa ETFs de referencia, incluido CPER, que utiliza futuros de cobre. Para usar la API real, implementar `MarketService`, cambiarlo en `main.dart` y actualizar los avisos de datos de ejemplo en las vistas. Antes de ofrecer rankings reales, definir su universo, período, fuente y fecha de actualización.

## Uso

```
flutter pub get
flutter run
flutter test
```
