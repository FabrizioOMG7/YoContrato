import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/models/base/base_item.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/content_list/content_list_widget.dart'; 
import '../info_card.dart';

class PageContentTemplate<T extends BaseItem> extends StatelessWidget {
  final Widget icon;
  final List<InfoCardItem> infoCardItems;
  final ContentListConfig<T> contentListConfig;

  const PageContentTemplate({
    super.key,
    required this.icon,
    required this.infoCardItems,
    required this.contentListConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Info Card Section - Fija en la parte superior
        Padding(
          padding: const EdgeInsets.all(16),
          child: InfoCard(
            icon: icon,
            items: infoCardItems,
          ),
        ),
        
        // Content List Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8), // Reducido de 16 a 8
            child: ContentListWidget<T>(
              title: contentListConfig.title,
              items: contentListConfig.items,
              emptyText: contentListConfig.emptyText,
              onAdd: contentListConfig.onAdd,
              cardBuilder: contentListConfig.cardBuilder,
            ),
          ),
        ),
      ],
    );
  }
}

class ContentListConfig<T extends BaseItem> {
  final String title;
  final List<T> items;
  final String emptyText;
  final VoidCallback? onAdd;
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;

  const ContentListConfig({
    required this.title,
    required this.items,
    required this.emptyText,
    required this.cardBuilder,
    this.onAdd,
  });

  // Factory para configuración de contratos
  factory ContentListConfig.contracts({
    required List<T> contratos,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
    VoidCallback? onAdd,
  }) {
    return ContentListConfig<T>(
      title: 'Postulantes registrados',
      items: contratos,
      emptyText: 'No hay postulantes registrados\nPuedes agregar uno usando el botón superior',
      cardBuilder: cardBuilder,
      onAdd: onAdd,
    );
  }
}