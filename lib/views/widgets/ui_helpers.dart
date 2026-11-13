import 'package:flutter/material.dart';

import '../../models/sector_performance.dart';

extension TrafficLightUi on TrafficLight {
  String get emoji => switch (this) {
        TrafficLight.green => '🟢',
        TrafficLight.yellow => '🟡',
        TrafficLight.red => '🔴',
      };
}

String formatPct(double v) => '${v >= 0 ? '+' : ''}${v.toStringAsFixed(2)}%';

Color pctColor(double v) =>
    v >= 0 ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
