import 'package:flutter/material.dart';

import '../../models/sector_performance.dart';
import 'ui_helpers.dart';

class SectorTile extends StatelessWidget {
  const SectorTile({super.key, required this.item, required this.onTap});

  final SectorPerformance item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(item.light.emoji, style: const TextStyle(fontSize: 22)),
      title: Text(item.sector.name),
      subtitle: Text('${item.sector.etf} · ${item.sector.category.label}'),
      trailing: Text(
        formatPct(item.day),
        style: TextStyle(
          color: pctColor(item.day),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
