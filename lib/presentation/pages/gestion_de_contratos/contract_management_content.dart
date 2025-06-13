// lib/presentation/pages/gestion_de_contratos/contract_management_content.dart
import 'package:flutter/material.dart';
import '../../../domain/models/contract/contract_item.dart';
import '../../widgets/modules/contracts/contract_card.dart';
import '../../widgets/shared/page_content/page_content_template.dart';
import '../../widgets/shared/info_card.dart';

/// Widget de contenido para la gestión de contratos
/// Aplica el principio de Responsabilidad Única (SRP) al enfocarse solo en la presentación del contenido
/// Aplica el principio de Inversión de Dependencias (DIP) al depender de abstracciones (callbacks) en lugar de implementaciones concretas
class ContractManagementContent extends StatelessWidget {
  final String sede;
  final List<ContractItem> contratos;
  final void Function(ContractItem) onTapEditar;
  final VoidCallback onTapAdd;

  const ContractManagementContent({
    super.key,
    required this.sede,
    required this.contratos,
    required this.onTapEditar,
    required this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    return PageContentTemplate<ContractItem>(
      /// Configuración del InfoCard
      /// Muestra información contextual de la sede
      icon: const Icon(
        Icons.location_on_rounded,
        color: Colors.white,
        size: 28
      ),
      
      infoCardItems: [
        InfoCardItem(
          label: 'Sede principal',
          value: sede.toUpperCase(),
        ),
      ],
      
      /// Configuración de la lista de contratos
      /// Usa el factory method para crear la configuración específica de contratos
      /// Esto aplica el patrón Factory y el principio de Abierto/Cerrado (OCP)
      contentListConfig: ContentListConfig.contracts(
        contratos: contratos,
        onAdd: onTapAdd,
        cardBuilder: (contract, isExpanded, onToggle) {
          /// Builder que crea cada ContractCard
          /// Aplica el patrón Builder para la construcción de widgets complejos
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