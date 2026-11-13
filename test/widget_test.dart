import 'package:flutter_test/flutter_test.dart';
import 'package:radar_mercado/controllers/market_controller.dart';
import 'package:radar_mercado/main.dart';
import 'package:radar_mercado/models/sector_performance.dart';
import 'package:radar_mercado/services/mock_market_service.dart';

void main() {
  test('el controlador calcula ranking y semáforo', () async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await c.load();
    expect(c.status, LoadStatus.success);
    expect(c.sectors.length, 16);
    expect(c.leader!.sector.name, 'Tecnología');
    expect(c.topStrong.length, 3);
    expect(c.topWeak.first.sector.name, 'REITs');
    expect(c.byLight(TrafficLight.green), isNotEmpty);
  });

  test('el controlador reporta error', () async {
    final c = MarketController(
        MockMarketService(latency: Duration.zero, shouldFail: true));
    await c.load();
    expect(c.status, LoadStatus.error);
  });

  testWidgets('el dashboard muestra al líder', (tester) async {
    final c = MarketController(MockMarketService(latency: Duration.zero));
    await tester.runAsync(c.load);
    await tester.pumpWidget(RadarMercadoApp(controller: c));
    await tester.pump();
    expect(find.text('🏆 Líder del día'), findsOneWidget);
  });
}
