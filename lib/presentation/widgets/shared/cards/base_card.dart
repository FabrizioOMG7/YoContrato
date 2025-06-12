// lib/presentation/widgets/shared/cards/base_card.dart
import 'package:flutter/material.dart';

abstract class BaseCard extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final VoidCallback? onEdit; // CORREGIDO: Agregado callback para editar
  
  const BaseCard({
    super.key,
    required this.isExpanded,
    required this.onToggleExpansion,
    this.onEdit, // CORREGIDO: Opcional para cards que no necesiten editar
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleExpansion,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDarkMode 
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context),
                    if (isExpanded) ...[
                      const SizedBox(height: 12),
                      buildExpandedContent(context),
                    ],
                  ],
                ),
              ),
              // CORREGIDO: Agregado botón de editar condicional
              if (onEdit != null) ...[
                const SizedBox(width: 12),
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA).withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF667EEA).withAlpha(51),
                      ),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Color(0xFF667EEA),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context);
  Widget buildExpandedContent(BuildContext context);
}