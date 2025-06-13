// lib/presentation/widgets/shared/page_content/page_content_template.dart
import 'package:flutter/material.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../info_card.dart';
import '../content_list/content_list_widget.dart';
import '../../../../domain/models/base/base_item.dart';

/// Configuración para la lista de contenido que define cómo se comporta la lista
/// Aplica el principio de Responsabilidad Única (SRP) al encapsular toda la configuración de la lista
class ContentListConfig<T extends BaseItem> {
  final List<T> items;
  final VoidCallback? onAdd;
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;
  final String? emptyMessage;
  final String listTitle; // Nuevo campo para el título de la lista

  const ContentListConfig({
    required this.items,
    required this.cardBuilder,
    required this.listTitle, // Título obligatorio
    this.onAdd,
    this.emptyMessage,
  });

  /// Factory constructor para contratos
  /// Aplica el patrón Factory para crear configuraciones específicas
  factory ContentListConfig.contracts({
    required List<T> contratos,
    required VoidCallback onAdd,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
  }) {
    return ContentListConfig(
      items: contratos,
      onAdd: onAdd,
      cardBuilder: cardBuilder,
      listTitle: 'CONTRATOS REGISTRADOS', // Título específico para contratos
      emptyMessage: 'No hay contratos disponibles',
    );
  }
}

/// Template de página que combina InfoCard con ContentListWidget
/// Aplica el principio de Composición sobre Herencia al usar ContentListWidget en lugar de reimplementar la funcionalidad
class PageContentTemplate<T extends BaseItem> extends StatelessWidget {
  final Widget icon;
  final List<InfoCardItem> infoCardItems;
  final ContentListConfig<T> contentListConfig;

  const PageContentTemplate({
    Key? key,
    required this.icon,
    required this.infoCardItems,
    required this.contentListConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// InfoCard en la parte superior
          /// Muestra información contextual de la página (ej: sede)
          InfoCard(
            icon: icon,
            items: infoCardItems,
          ),
          
          SizedBox(height: AppSpacing.xl),

          /// ContentListWidget que maneja toda la funcionalidad de la lista
          /// Aplica el principio de Delegación al usar un widget especializado
          /// que ya tiene implementado: título, contador, expandir/comprimir, botón agregar
          Expanded(
            child: ContentListWidget<T>(
              title: contentListConfig.listTitle,
              items: contentListConfig.items,
              cardBuilder: contentListConfig.cardBuilder,
              onAdd: contentListConfig.onAdd,
              emptyText: contentListConfig.emptyMessage ?? 'No hay elementos disponibles',
            ),
          ),
        ],
      ),
    );
  }
}