import 'package:flutter/material.dart';

import '../models/sector_performance.dart';
import 'widgets/ui_helpers.dart';

class SectorDetailPage extends StatelessWidget {
  const SectorDetailPage({super.key, required this.item});

  final SectorPerformance item;

  @override
  Widget build(BuildContext context) {
    final sector = item.sector;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(sector.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Qué es ${sector.name}?',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Datos y movimientos de ejemplo, no son reales.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF21535B),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(sector.description),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final keyword in sector.keywords)
                        Chip(label: Text(keyword)),
                    ],
                  ),
                  if (sector.etf != null) ...[
                    const SizedBox(height: 24),
                    Text(
                      '¿Cómo se ha movido?',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Variación de ejemplo del ETF de referencia. Un signo + '
                      'indica una subida y un signo −, una bajada.',
                    ),
                    const SizedBox(height: 8),
                    Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _row('Día', item.day),
                          _row('Semana', item.week),
                          _row('Mes', item.month),
                          _row('Año', item.year),
                        ],
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 24),
                    const Text(
                      'No hay un porcentaje general: cada materia prima puede '
                      'moverse de forma diferente.',
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'Datos simulados; no representan el mercado real.',
                    style: theme.textTheme.bodySmall,
                  ),
                  if (item.driver != null) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Ejemplo de explicación',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(item.driver!),
                    const SizedBox(height: 4),
                    Text(
                      'Es un ejemplo ficticio, no una noticia ni un análisis actual.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    'Ejemplos de instrumentos',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ordenados por su cambio diario simulado. Son solo '
                    'ejemplos, no un ranking del mercado real.',
                  ),
                  const SizedBox(height: 8),
                  if (item.instruments.isEmpty)
                    const Text('No hay ejemplos disponibles para esta área.')
                  else
                    Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          for (final instrument in item.rankedInstruments)
                            ListTile(
                              title: Text(instrument.name),
                              subtitle: Text(
                                '${instrument.symbol} · ${instrument.type.label}'
                                '${instrument.description == null ? '' : '\n${instrument.description}'}',
                              ),
                              isThreeLine: instrument.description != null,
                              trailing: Text(
                                formatPct(instrument.day),
                                style: TextStyle(
                                  color: pctColor(instrument.day),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text('Para aprender', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    '${sector.etf == null ? '' : 'ETF de referencia: ${sector.etf}. '}'
                    'Una acción representa una parte de una empresa. '
                    'Un ETF es un fondo que se compra y vende en bolsa; puede '
                    'seguir empresas u otros activos, según el fondo.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Un dividendo es un pago que algunas empresas hacen a sus '
                    'accionistas. No todas las acciones pagan dividendos.',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Riesgo orientativo: ${sector.risk.label}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'El riesgo indica que el valor puede cambiar y que podrías '
                    'perder dinero. Esta clasificación es solo ilustrativa.',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Contenido educativo; no es una recomendación de inversión.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double? value) => ListTile(
    dense: true,
    title: Text(label),
    trailing: Text(
      value == null ? 'No disponible' : formatPct(value),
      style: TextStyle(
        color: value == null ? null : pctColor(value),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
