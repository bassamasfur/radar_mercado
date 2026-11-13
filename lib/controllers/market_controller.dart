import 'package:flutter/foundation.dart';

import '../models/sector_performance.dart';
import '../services/market_service.dart';

enum LoadStatus { idle, loading, success, error }

class MarketController extends ChangeNotifier {
  MarketController(this._service);

  final MarketService _service;

  LoadStatus _status = LoadStatus.idle;
  List<SectorPerformance> _sectors = const [];
  String? _error;

  LoadStatus get status => _status;
  String? get error => _error;
  List<SectorPerformance> get sectors => _sectors;

  List<SectorPerformance> get _ranked =>
      [..._sectors]..sort((a, b) => b.day.compareTo(a.day));

  SectorPerformance? get leader => _ranked.isEmpty ? null : _ranked.first;
  List<SectorPerformance> get topStrong => _ranked.take(3).toList();
  List<SectorPerformance> get topWeak => _ranked.reversed.take(3).toList();

  List<SectorPerformance> byLight(TrafficLight light) =>
      _ranked.where((s) => s.light == light).toList();

  Future<void> load() async {
    _status = LoadStatus.loading;
    _error = null;
    notifyListeners();
    try {
      _sectors = await _service.fetchSectors();
      _status = LoadStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LoadStatus.error;
    }
    notifyListeners();
  }
}
