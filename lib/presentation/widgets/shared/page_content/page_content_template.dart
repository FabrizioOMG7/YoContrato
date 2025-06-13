// lib/presentation/widgets/shared/page_content/page_content_template.dart
import 'package:flutter/material.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../info_card.dart';
import '../content_list/content_list_widget.dart';
import '../../../../domain/models/base/base_item.dart';

class ContentListConfig<T extends BaseItem> {
  final List<T> items;
  final VoidCallback? onAdd;
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;
  final String? emptyMessage;
  final String listTitle;

  const ContentListConfig({
    required this.items,
    required this.cardBuilder,
    required this.listTitle,
    this.onAdd,
    this.emptyMessage,
  });

  factory ContentListConfig.contracts({
    required List<T> contratos,
    required VoidCallback onAdd,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
  }) {
    return ContentListConfig(
      items: contratos,
      onAdd: onAdd,
      cardBuilder: cardBuilder,
      listTitle: 'POSTULANTES REGISTRADOS',
      emptyMessage: 'No hay postulantes disponibles',
    );
  }
}

/// Template optimizado para maximizar el espacio de los cards
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
      // Padding de página reducido
      padding: AppSpacing.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// InfoCard compacto
          InfoCard(
            icon: icon,
            items: infoCardItems,
          ),
          
          // Espaciado reducido entre InfoCard y lista
          SizedBox(height: AppSpacing.md), // Reducido de xl (20) a md (12)

          /// Lista expandida que ocupa todo el espacio disponible
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