// lib/presentation/widgets/shared/page_content/page_content_template.dart
import 'package:flutter/material.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../info_card.dart';

class ContentListConfig<T> {
  final List<T> items;
  final VoidCallback? onAdd;
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;
  final String? emptyMessage;

  const ContentListConfig({
    required this.items,
    required this.cardBuilder,
    this.onAdd,
    this.emptyMessage,
  });

  // Factory constructor para contratos
  factory ContentListConfig.contracts({
    required List<T> contratos,
    required VoidCallback onAdd,
    required Widget Function(T, bool, VoidCallback) cardBuilder,
  }) {
    return ContentListConfig(
      items: contratos,
      onAdd: onAdd,
      cardBuilder: cardBuilder,
      emptyMessage: 'No hay contratos disponibles',
    );
  }
}

class PageContentTemplate<T> extends StatefulWidget {
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
  State<PageContentTemplate<T>> createState() => _PageContentTemplateState<T>();
}

class _PageContentTemplateState<T> extends State<PageContentTemplate<T>> {
  final Map<int, bool> _expansionStates = {};

  @override
  void initState() {
    super.initState();
    // Inicializar todos los elementos como comprimidos
    for (int i = 0; i < widget.contentListConfig.items.length; i++) {
      _expansionStates[i] = false;
    }
  }

  void _toggleExpansion(int index) {
    setState(() {
      _expansionStates[index] = !(_expansionStates[index] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.getPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InfoCard con botón de agregar si está disponible
          InfoCard(
            icon: widget.icon,
            items: widget.infoCardItems,
            trailing: widget.contentListConfig.onAdd != null
                ? IconButton(
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: Color(0xFF667EEA),
                      size: 24,
                    ),
                    onPressed: widget.contentListConfig.onAdd,
                    tooltip: 'Agregar elemento',
                  )
                : null,
          ),
          
          SizedBox(height: AppSpacing.xl),

          // Lista de contenido
          Expanded(
            child: widget.contentListConfig.items.isEmpty
                ? _buildEmptyState()
                : _buildContentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            widget.contentListConfig.emptyMessage ?? 'No hay elementos',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    return ListView.separated(
      itemCount: widget.contentListConfig.items.length,
      separatorBuilder: (context, index) => SizedBox(height: AppSpacing.xs),
      itemBuilder: (context, index) {
        final item = widget.contentListConfig.items[index];
        final isExpanded = _expansionStates[index] ?? false;

        return widget.contentListConfig.cardBuilder(
          item,
          isExpanded,
          () => _toggleExpansion(index),
        );
      },
    );
  }
}