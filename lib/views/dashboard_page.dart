import 'package:flutter/material.dart';

import '../controllers/market_controller.dart';
import '../models/sector_performance.dart';
import 'sector_detail_page.dart';
import 'widgets/sector_tile.dart';

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
              onPressed: controller.status == LoadStatus.loading
                  ? null
                  : controller.load,
            ),
          ],
        ),
        body: switch (controller.status) {
          LoadStatus.idle || LoadStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
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
    final theme = Theme.of(context);
    final visibleSectors = controller.visibleSectors;
    return RefreshIndicator(
      onRefresh: controller.load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explora el mercado',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF173B42),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Descubre cómo se mueve cada área. Toca una para aprender más.',
                  ),
                  const SizedBox(height: 16),
                  const _DemoNotice(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Áreas del mercado',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        'Cambio del día',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cambio del ETF de referencia: + sube · − baja, '
                    'respecto al cierre anterior.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  if (visibleSectors.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text('No hay áreas disponibles por ahora.'),
                    )
                  else
                    Column(
                      children: [
                        for (final item in visibleSectors)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SectorTile(
                              item: item,
                              onTap: () => _open(context, item),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoNotice extends StatelessWidget {
  const _DemoNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F5F7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB8E5E8)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFF087481)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Datos de ejemplo: no representan el mercado real.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF21535B)),
            ),
          ),
        ],
      ),
    );
  }
}
