import 'package:flutter/material.dart';

import '../controllers/market_controller.dart';
import '../models/sector_performance.dart';
import 'sector_detail_page.dart';
import 'widgets/sector_tile.dart';
import 'widgets/ui_helpers.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.controller});

  final MarketController controller;

  void _open(BuildContext context, SectorPerformance item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => SectorDetailPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Radar de Mercado'),
          actions: [
            IconButton(
              tooltip: 'Actualizar',
              icon: const Icon(Icons.refresh),
              onPressed: controller.load,
            ),
          ],
        ),
        body: switch (controller.status) {
          LoadStatus.idle || LoadStatus.loading =>
            const Center(child: CircularProgressIndicator()),
          LoadStatus.error => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.error ?? 'Error'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: controller.load,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          LoadStatus.success => _content(context),
        },
      ),
    );
  }

  Widget _content(BuildContext context) {
    final leader = controller.leader;
    return RefreshIndicator(
      onRefresh: controller.load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (leader != null)
            _LeaderCard(item: leader, onTap: () => _open(context, leader)),
          _section(context, '💪 Top 3 sectores fuertes', controller.topStrong),
          _section(context, '⚠️ Top 3 sectores débiles', controller.topWeak),
          _section(context, '🚦 Radar completo', [
            ...controller.byLight(TrafficLight.green),
            ...controller.byLight(TrafficLight.yellow),
            ...controller.byLight(TrafficLight.red),
          ]),
        ],
      ),
    );
  }

  Widget _section(
      BuildContext context, String title, List<SectorPerformance> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 4),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        Card(
          child: Column(
            children: [
              for (final i in items)
                SectorTile(item: i, onTap: () => _open(context, i)),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeaderCard extends StatelessWidget {
  const _LeaderCard({required this.item, required this.onTap});

  final SectorPerformance item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🏆 Líder del día'),
              const SizedBox(height: 8),
              Text(item.sector.name, style: theme.textTheme.headlineSmall),
              Text(
                formatPct(item.day),
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: pctColor(item.day)),
              ),
              if (item.driver != null) ...[
                const SizedBox(height: 8),
                Text(item.driver!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
