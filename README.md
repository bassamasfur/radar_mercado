# Radar de Mercado

App Flutter para inversionistas principiantes: explica en lenguaje simple qué sectores lideran o están débiles en el mercado.

## Funcionalidades (MVP)

- Dashboard con líder del día, top 3 fuertes y top 3 débiles
- Semáforo sectorial (verde / amarillo / rojo) de las 16 áreas
- Detalle por sector: rendimiento día/semana/mes/año, explicación y riesgo
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

Los datos son mock. Para usar la API real, implementar `MarketService` y cambiarlo en `main.dart`.

## Uso

```
flutter pub get
flutter run
flutter test
```
