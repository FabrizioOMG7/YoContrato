import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  });

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
        Text(
          'DNI: ${contract.dni}',
          style: CardStyles.subtitleStyle(context, MediaQuery.of(context).size.width),
        ),
        const SizedBox(height: 8),
        Text(
          'EVENTO: ${contract.evento}',
          style: CardStyles.subtitleStyle(context, MediaQuery.of(context).size.width),
        ),
        const SizedBox(height: 8),
        Text(
          'FECHA Y HORA: ${contract.fechaHora}',
          style: CardStyles.subtitleStyle(context, MediaQuery.of(context).size.width),
        ),
      ],
    );
  }
}