// lib/presentation/pages/gestion_de_contratos/contract_management_content.dart
import 'package:flutter/material.dart';
import '../../../domain/models/contract/contract_item.dart';
import '../../widgets/modules/contracts/contract_card.dart';
import '../../widgets/shared/page_content/page_content_template.dart';

/// Content para gestión de contratos
/// SOLO contiene lógica de datos y callbacks
/// TODO el diseño está encapsulado en PageContentTemplate
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
      // Configuración del InfoCard - Sin código de diseño
      infoCardConfig: InfoCardConfig.contracts(sede),
      
      // Configuración de la lista - Sin código de diseño
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

// COMPARACIÓN:
// ANTES: ~100 líneas con mucho código de diseño mezclado
// AHORA: ~20 líneas, solo lógica de negocio y datos