import 'package:flutter/material.dart';
import '../../../domain/models/contract/contract_item.dart';
import '../../widgets/modules/contracts/contract_card.dart';
import '../../widgets/shared/page_content/page_content_template.dart';
import '../../widgets/shared/info_card.dart';

class ContractManagementContent extends StatelessWidget {
  final String sede;
  final List<ContractItem> contratos;
  final void Function(ContractItem) onTapEditar;
  final VoidCallback onTapAdd;

  const ContractManagementContent({
    Key? key,
    required this.sede,
    required this.contratos,
    required this.onTapEditar,
    required this.onTapAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContentTemplate<ContractItem>(
      // Icon para el InfoCard
      icon: const Icon(
        Icons.location_on_rounded,
        color: Colors.white,
        size:28
      ),
      
      // Items para el InfoCard
      infoCardItems: [
        InfoCardItem(
          label: 'Sede principal',
          value: sede.toUpperCase(),
        ),
      ],
      
      // Configuración de la lista
      contentListConfig: ContentListConfig.contracts(
        contratos: contratos,
        onAdd: onTapAdd,
        cardBuilder: (contract, isExpanded, onToggle) {
          return ContractCard(
            contract: contract,
            isExpanded: isExpanded,
            onToggleExpansion: onToggle,
            onTapEditar: () => onTapEditar(contract),
          );
        },
      ),
    );
  }
}