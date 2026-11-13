import 'package:flutter/material.dart';

import '../../models/sector.dart';
import '../../models/sector_performance.dart';
import 'ui_helpers.dart';

class SectorTile extends StatelessWidget {
  const SectorTile({super.key, required this.item, required this.onTap});

  final SectorPerformance item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, background, foreground) = switch (item.sector.category) {
      SectorCategory.crecimiento => (
        Icons.rocket_launch_rounded,
        const Color(0xFFE8E8FF),
        const Color(0xFF5C56B5),
      ),
      SectorCategory.defensivo => (
        Icons.favorite_rounded,
        const Color(0xFFFFE9E9),
        const Color(0xFFB54B58),
      ),
      SectorCategory.economia => (
        Icons.business_rounded,
        const Color(0xFFFFF1D7),
        const Color(0xFF966000),
      ),
      SectorCategory.patrimonio => (
        Icons.home_rounded,
        const Color(0xFFE9EDFF),
        const Color(0xFF5364A8),
      ),
      SectorCategory.alternativos => (
        Icons.auto_awesome_rounded,
        const Color(0xFFFFF1D7),
        const Color(0xFF966000),
      ),
      SectorCategory.geografia => (
        Icons.public_rounded,
        const Color(0xFFE0F3F8),
        const Color(0xFF13778C),
      ),
    };
    final day = item.day;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDCEAE6), width: 1.5),
        boxShadow: const [
          BoxShadow(color: Color(0xFFDCEAE6), offset: Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: foreground, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.sector.name,
                    style: TextStyle(
                      color: Color(0xFF173B42),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (day == null)
                  const Flexible(
                    child: Text(
                      'Ver detalle',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xFF21535B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: day < 0
                          ? const Color(0xFFFFECEC)
                          : const Color(0xFFE7F5E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      formatPct(day),
                      style: TextStyle(
                        color: pctColor(day),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF78928D),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
