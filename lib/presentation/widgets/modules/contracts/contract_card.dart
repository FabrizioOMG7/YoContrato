// lib/presentation/widgets/modules/contracts/contract_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/models/contract/contract_item.dart';
import '../../shared/cards/base_card.dart';

class ContractCard extends BaseCard {
  final ContractItem contract;

  const ContractCard({
    Key? key,
    required this.contract,
    required bool isExpanded,
    required VoidCallback onToggleExpansion,
    required VoidCallback onTapEditar,
  }) : super(
          key: key,
          isExpanded: isExpanded,
          onToggleExpansion: onToggleExpansion,
          onEdit: onTapEditar,
        );

  @override
  Widget buildHeader(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Usar Flexible para evitar overflow en textos largos
              Text(
                contract.nombre,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF111827),
                  letterSpacing: -0.2,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'DNI: ${contract.dni}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.expand_more,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
          onPressed: onToggleExpansion,
          tooltip: isExpanded ? 'Ocultar detalles' : 'Ver detalles',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          onPressed: onEdit!,
          tooltip: 'Editar contrato',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }

  @override
  Widget buildExpandedContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : const Color(0xFF4B5563);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          context,
          icon: Icons.event_outlined,
          label: 'EVENTO',
          value: contract.evento,
          textColor: textColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          icon: Icons.schedule_outlined,
          label: 'FECHA Y HORA',
          value: contract.fechaHora,
          textColor: textColor,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}