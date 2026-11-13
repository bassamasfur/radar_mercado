import 'package:flutter/material.dart';

import 'controllers/market_controller.dart';
import 'services/market_service.dart';
import 'services/mock_market_service.dart';
import 'views/dashboard_page.dart';

void main() {
  // Cambiar por el servicio real cuando exista la API.
  final MarketService service = MockMarketService();
  runApp(RadarMercadoApp(controller: MarketController(service)..load()));
}

class RadarMercadoApp extends StatelessWidget {
  const RadarMercadoApp({super.key, required this.controller});

  final MarketController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar de Mercado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087F8C)),
        scaffoldBackgroundColor: const Color(0xFFF6FAF8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6FAF8),
          foregroundColor: Color(0xFF173B42),
          titleTextStyle: TextStyle(
            color: Color(0xFF173B42),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        useMaterial3: true,
      ),
      home: DashboardPage(controller: controller),
    );
  }
}
