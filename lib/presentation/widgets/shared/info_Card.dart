import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget icon;
  final List<InfoCardItem> items;

  const InfoCard({
    super.key,
    required this.icon,
    required this.items,
  });

@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ícono principal
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: icon),
        ),
        const SizedBox(width: 18),
        // Lista de label-valor
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.value,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF111827),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}
}

// Clase para los pares label-valor
class InfoCardItem {
  final String label;
  final String value;

  InfoCardItem({required this.label, required this.value});
}