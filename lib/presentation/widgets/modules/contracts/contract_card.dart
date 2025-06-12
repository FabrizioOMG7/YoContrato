// lib/presentation/widgets/modules/contracts/contract_card.dart
import 'package:flutter/material.dart';
import '../../../../domain/models/contract/contract_item.dart';
import '../../shared/cards/base_card.dart';
import '../../shared/styles/card_styles.dart';

class ContractCard extends BaseCard {
  final ContractItem contract;
  final VoidCallback onTapEditar;

  const ContractCard({
    super.key,
    required this.contract,
    required this.onTapEditar,
    required super.isExpanded,
    required super.onToggleExpansion,
  }) : super(onEdit: onTapEditar); // CORREGIDO: Pasamos el callback al BaseCard

  @override
  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            contract.nombre,
            style: CardStyles.titleStyle(context, MediaQuery.of(context).size.width),
          ),
        ),
        AnimatedRotation(
          turns: isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(
            Icons.expand_more,
            color: Color(0xFF667EEA),
            size: 24,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildExpandedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          context,
          label: 'DNI',
          value: contract.dni,
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          label: 'EVENTO',
          value: contract.evento,
          icon: Icons.event_outlined,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          label: 'FECHA Y HORA',
          value: contract.fechaHora,
          icon: Icons.schedule_outlined,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: const Color(0xFF667EEA),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: CardStyles.subtitleStyle(context, MediaQuery.of(context).size.width)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: CardStyles.subtitleStyle(context, MediaQuery.of(context).size.width),
          ),
        ),
      ],
    );
  }
}