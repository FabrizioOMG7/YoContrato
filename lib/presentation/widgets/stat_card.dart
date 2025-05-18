import 'package:flutter/material.dart';
import '../../domain/entities/stat_entity.dart';
import '../../core/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final StatEntity stat;
  final bool isDark; // <-- Nuevo parámetro

  const StatCard({super.key, required this.stat, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final iconData = _iconMap[stat.iconName] ?? Icons.error_outline;

    return Card(
      color: isDark ? const Color(0x33161F49) : Colors.white, // Fondo adaptado
      elevation: isDark ? 0 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: isDark ? Colors.white : AppTheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              stat.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              stat.count.toString(),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  static const Map<String, IconData> _iconMap = {
    'check_circle_outline': Icons.check_circle_outline,
    'access_time': Icons.access_time,
    'cancel_outlined': Icons.cancel_outlined,
    'sentiment_dissatisfied': Icons.sentiment_dissatisfied,
  };
}