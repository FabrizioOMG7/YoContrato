import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/models/base/base_item.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/content_list/content_list_widget.dart'; 
import '../info_card.dart';

/// Template reutilizable para páginas de gestión
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ContentListWidget<T>(
              title: contentListConfig.title,
              items: contentListConfig.items,
              emptyText: contentListConfig.emptyText,
              headerIcon: contentListConfig.headerIcon,
              onAdd: contentListConfig.onAdd,
              cardBuilder: contentListConfig.cardBuilder,
            ),
          ),
        ),
      ],
    );
  }
}

/// Configuración para la lista de contenido
class ContentListConfig<T extends BaseItem> {
  final String title;
  final List<T> items;
  final String emptyText;
  final IconData? headerIcon;
  final VoidCallback? onAdd;
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;

  const ContentListConfig({
    required this.title,
    required this.items,
    required this.emptyText,
    required this.cardBuilder,
    this.headerIcon,
    this.onAdd,
  });

  factory ContentListConfig.contracts({
    required List<T> contratos,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
    VoidCallback? onAdd,
  }) {
    return ContentListConfig<T>(
      title: 'Postulantes registrados',
      items: contratos,
      emptyText: 'No hay postulantes registrados\nPuedes agregar uno usando el botón superior',
      headerIcon: Icons.people_outline,
      onAdd: onAdd,
      cardBuilder: cardBuilder,
    );
  }

  factory ContentListConfig.bbss({
    required List<T> bbssItems,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
    VoidCallback? onAdd,
  }) {
    return ContentListConfig<T>(
      title: 'Base de datos personal',
      items: bbssItems,
      emptyText: 'No hay personal registrado\nAgrega nuevo personal usando el botón superior',
      headerIcon: Icons.people_alt_outlined,
      onAdd: onAdd,
      cardBuilder: cardBuilder,
    );
  }

  factory ContentListConfig.events({
    required List<T> eventos,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
    VoidCallback? onAdd,
  }) {
    return ContentListConfig<T>(
      title: 'Eventos programados',
      items: eventos,
      emptyText: 'No hay eventos programados\nCrea un nuevo evento usando el botón superior',
      headerIcon: Icons.event_note_outlined,
      onAdd: onAdd,
      cardBuilder: cardBuilder,
    );
  }
}