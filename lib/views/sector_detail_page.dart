import 'package:flutter/material.dart';

import '../models/sector_performance.dart';
import 'widgets/ui_helpers.dart';

class SectorDetailPage extends StatelessWidget {
  const SectorDetailPage({super.key, required this.item});

  final SectorPerformance item;

  @override
  Widget build(BuildContext context) {
    final s = item.sector;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('${item.light.emoji} ${s.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('ETF de referencia: ${s.etf} · ${s.category.label}'),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                _row('Día', item.day),
                _row('Semana', item.week),
                _row('Mes', item.month),
                _row('Año', item.year),
              ],
            ),
          ),
          if (item.driver != null) ...[
            const SizedBox(height: 16),
            Text(item.driver!, style: theme.textTheme.bodyLarge),
          ],
          const SizedBox(height: 20),
          Text('¿Qué es ${s.name}?', style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(s.description),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [for (final k in s.keywords) Chip(label: Text(k))],
          ),
          const SizedBox(height: 16),
          Text('Nivel de riesgo: ${s.risk.label}',
              style: theme.textTheme.titleSmall),
        ],
      ),
    );
  }

  Widget _row(String label, double v) => ListTile(
        dense: true,
        title: Text(label),
        trailing: Text(
          formatPct(v),
          style: TextStyle(color: pctColor(v), fontWeight: FontWeight.bold),
        ),
      );
}
