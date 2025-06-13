// lib/presentation/widgets/modules/contracts/contract_card.dart
import 'package:flutter/material.dart';
import '../../../../domain/models/contract/contract_item.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
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
              Flexible(
                child: Text(
                  contract.nombre,
                  style: AppTextStyles.cardTitle(context, isDarkMode: isDarkMode),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                'DNI: ${contract.dni}',
                style: AppTextStyles.cardSubtitle(context, isDarkMode: isDarkMode),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        _buildIconButton(
          context: context,
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
        ),
        SizedBox(width: AppSpacing.xs),
        _buildIconButton(
          context: context,
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          onPressed: onEdit!,
          tooltip: 'Editar contrato',
        ),
      ],
    );
  }

  @override
  Widget buildExpandedContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          context,
          icon: Icons.event_outlined,
          label: 'EVENTO',
          value: contract.evento,
          isDarkMode: isDarkMode,
        ),
        SizedBox(height: AppSpacing.sm),
        _buildInfoRow(
          context,
          icon: Icons.schedule_outlined,
          label: 'FECHA Y HORA',
          value: contract.fechaHora,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  // Widget helper para botones de iconos consistentes
  Widget _buildIconButton({
    required BuildContext context,
    required Widget icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      padding: EdgeInsets.all(AppSpacing.sm),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      splashRadius: 20,
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: AppTextStyles.cardInfoLabel(context, isDarkMode: isDarkMode),
                ),
                TextSpan(
                  text: value,
                  style: AppTextStyles.cardInfo(context, isDarkMode: isDarkMode),
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