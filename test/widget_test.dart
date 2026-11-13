import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radar_mercado/controllers/market_controller.dart';
import 'package:radar_mercado/main.dart';
import 'package:radar_mercado/models/sector_performance.dart';
import 'package:radar_mercado/services/mock_market_service.dart';
import 'package:radar_mercado/views/widgets/sector_tile.dart';
import 'package:radar_mercado/views/widgets/ui_helpers.dart';

void main() {
  test('el controlador calcula ranking y semáforo', () async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await c.load();
    expect(c.status, LoadStatus.success);
    expect(c.sectors.length, 16);
    expect(c.sectors.any((s) => s.sector.id == 'div'), isFalse);
    expect(c.leader!.sector.name, 'Tecnología');
    expect(c.topStrong.length, 3);
    expect(c.topWeak.first.sector.name, 'Bienes raíces');
    expect(c.byLight(TrafficLight.green), isNotEmpty);
    expect(
      c.sectors.singleWhere((s) => s.sector.id == 'commodities').light,
      isNull,
    );
    expect(c.topWeak.any((s) => s.sector.id == 'commodities'), isFalse);
  });

  test('cada área tiene ejemplos ordenados y referencias coherentes', () async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await c.load();
    expect(c.sectors.map((s) => s.sector.id).toSet().length, 16);
    for (final item in c.sectors) {
      expect(item.instruments.length, 3, reason: item.sector.name);
      final ranked = item.rankedInstruments;
      for (var i = 1; i < ranked.length; i++) {
        expect(ranked[i - 1].day, greaterThanOrEqualTo(ranked[i].day));
      }
      for (final instrument in item.instruments) {
        if (instrument.symbol == item.sector.etf) {
          expect(instrument.day, item.day);
        }
      }
    }
  });

  test('el controlador reporta error', () async {
    final c = MarketController(
      MockMarketService(latency: Duration.zero, shouldFail: true),
    );
    await c.load();
    expect(c.status, LoadStatus.error);
  });

  testWidgets('muestra las 16 áreas una vez con sus porcentajes', (
    tester,
  ) async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));

    expect(
      find.text('Datos de ejemplo: no representan el mercado real.'),
      findsOneWidget,
    );
    expect(find.byType(SectorTile), findsNWidgets(16));
    expect(find.text('Dividendos'), findsNothing);
    for (final item in c.sectors) {
      final tile = find.byWidgetPredicate(
        (widget) =>
            widget is SectorTile && widget.item.sector.id == item.sector.id,
      );
      expect(tile, findsOneWidget);
      expect(
        find.descendant(of: tile, matching: find.text(item.sector.name)),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: tile,
          matching: find.text(
            item.day == null ? 'Ver detalle' : formatPct(item.day!),
          ),
        ),
        findsOneWidget,
      );
    }
    expect(find.textContaining('Top 3'), findsNothing);
    expect(find.textContaining('Líder del día'), findsNothing);
  });

  testWidgets('abre el detalle y regresa a la lista, incluso desde el final', (
    tester,
  ) async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));

    await tester.tap(find.text('Tecnología'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué es Tecnología?'), findsOneWidget);
    expect(
      find.textContaining('No todas las acciones pagan dividendos'),
      findsOneWidget,
    );
    expect(find.text('+2.35%'), findsOneWidget);
    expect(find.text('+4.50%'), findsOneWidget);
    expect(
      find.text('Datos simulados; no representan el mercado real.'),
      findsOneWidget,
    );
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Emergentes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Emergentes'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué es Emergentes?'), findsOneWidget);
    final dailyRow = find.widgetWithText(ListTile, 'Día');
    expect(
      find.descendant(of: dailyRow, matching: find.text('-0.15%')),
      findsOneWidget,
    );
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(SectorTile), findsNWidgets(16));
  });

  testWidgets('materias primas abre detalle directo sin porcentaje general', (
    tester,
  ) async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));
    await Scrollable.ensureVisible(
      tester.element(find.text('Materias primas')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Materias primas'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué es Materias primas?'), findsOneWidget);
    expect(find.textContaining('No hay un porcentaje general'), findsOneWidget);
    expect(find.text('¿Cómo se ha movido?'), findsNothing);
    expect(find.text('Ejemplos de instrumentos'), findsOneWidget);
    for (final metal in ['Oro', 'Plata', 'Cobre']) {
      expect(find.widgetWithText(ListTile, metal), findsOneWidget);
    }
    expect(find.textContaining('CPER · ETF'), findsOneWidget);
    expect(find.textContaining('GLDM · ETF'), findsOneWidget);
  });

  testWidgets('defensa explica el sector y muestra ejemplos simulados', (
    tester,
  ) async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));
    await tester.ensureVisible(find.text('Defensa y aeroespacial'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Defensa y aeroespacial'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué es Defensa y aeroespacial?'), findsOneWidget);
    expect(find.textContaining('no garantizan subidas'), findsOneWidget);
    expect(find.text('Lockheed Martin'), findsOneWidget);
    expect(
      find.textContaining('no un ranking del mercado real'),
      findsOneWidget,
    );
  });

  testWidgets('permite reintentar cuando falla la carga', (tester) async {
    final c = MarketController(
      MockMarketService(latency: Duration.zero, shouldFail: true),
    );
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));
    expect(find.textContaining('Servicio no disponible'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Reintentar'), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.textContaining('Servicio no disponible'), findsOneWidget);
  });

  testWidgets('la lista y el detalle se adaptan a una pantalla pequeña', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final c = MarketController(MockMarketService(latency: Duration.zero));
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Consumo Discrecional'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Consumo Discrecional'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué es Consumo Discrecional?'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await Scrollable.ensureVisible(
      tester.element(find.text('Materias primas')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Materias primas'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué es Materias primas?'), findsOneWidget);
    await tester.ensureVisible(find.textContaining('CPER · ETF'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
