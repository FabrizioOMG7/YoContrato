// lib/presentation/widgets/shared/page_content/page_content_template.dart
import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/models/base/base_item.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/content_list/content_list_widget.dart'; 

import '../info_card.dart';


/// Template reutilizable para páginas de gestión
/// Encapsula TODA la lógica de diseño y layout
/// Las páginas solo pasan datos y callbacks
class PageContentTemplate<T extends BaseItem> extends StatelessWidget {
  /// Configuración del InfoCard superior
  final InfoCardConfig infoCardConfig;
  
  /// Configuración de la lista de contenido
  final ContentListConfig<T> contentListConfig;

  const PageContentTemplate({
    Key? key,
    required this.infoCardConfig,
    required this.contentListConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Info Card Section - Completamente encapsulado
        Padding(
          padding: const EdgeInsets.all(16),
          child: InfoCard(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: infoCardConfig.iconBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                infoCardConfig.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            items: infoCardConfig.items,
          ),
        ),
        
        // Content List Section - Completamente encapsulado
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
        
        const SizedBox(height: 16), // Bottom spacing
      ],
    );
  }
}

/// Configuración para InfoCard
/// Centraliza todos los parámetros de configuración
class InfoCardConfig {
  final IconData icon;
  final Color iconBackgroundColor;
  final List<InfoCardItem> items;

  const InfoCardConfig({
    required this.icon,
    required this.iconBackgroundColor,
    required this.items,
  });

  /// Factory para módulo de contratos
  factory InfoCardConfig.contracts(String sede) {
    return InfoCardConfig(
      icon: Icons.location_on_rounded,
      iconBackgroundColor: const Color(0xFF667EEA),
      items: [
        InfoCardItem(
          label: 'Sede principal',
          value: sede,
        ),
      ],
    );
  }

  /// Factory para módulo de BBSS
  factory InfoCardConfig.bbss(String sede, int totalPersonal) {
    return InfoCardConfig(
      icon: Icons.people_outline,
      iconBackgroundColor: const Color(0xFF10B981),
      items: [
        InfoCardItem(
          label: 'Sede principal',
          value: sede,
        ),
        InfoCardItem(
          label: 'Personal disponible',
          value: totalPersonal.toString(),
        ),
      ],
    );
  }

  /// Factory para módulo de eventos
  factory InfoCardConfig.events(String sede, int eventosActivos) {
    return InfoCardConfig(
      icon: Icons.event_outlined,
      iconBackgroundColor: const Color(0xFFF59E0B),
      items: [
        InfoCardItem(
          label: 'Sede principal',
          value: sede,
        ),
        InfoCardItem(
          label: 'Eventos activos',
          value: eventosActivos.toString(),
        ),
      ],
    );
  }
}

/// Configuración para la lista de contenido
/// Centraliza todos los parámetros de la lista
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

  /// Factory para módulo de contratos
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

  /// Factory para módulo de BBSS
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

  /// Factory para módulo de eventos
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