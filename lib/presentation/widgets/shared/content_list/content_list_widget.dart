// lib/presentation/widgets/shared/content_list/content_list_widget.dart
import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/models/base/base_item.dart';
import '../styles/card_styles.dart';

/// Widget genérico reutilizable para listas de contenido
/// Implementa el patrón Template Method para máxima reutilización
class ContentListWidget<T extends BaseItem> extends StatefulWidget {
  /// Título de la sección (ej: "Postulantes registrados", "Base de datos", etc.)
  final String title;
  
  /// Lista de items a mostrar
  final List<T> items;
  
  /// Builder para crear cada card específica
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;
  
  /// Callback para agregar nuevo item
  final VoidCallback? onAdd;
  
  /// Texto a mostrar cuando la lista está vacía
  final String emptyText;
  
  /// Icono para la cabecera (opcional)
  final IconData? headerIcon;

  const ContentListWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.cardBuilder,
    required this.emptyText,
    this.onAdd,
    this.headerIcon,
  }) : super(key: key);

  @override
  State<ContentListWidget<T>> createState() => _ContentListWidgetState<T>();
}

class _ContentListWidgetState<T extends BaseItem> extends State<ContentListWidget<T>> {
  final Map<String, bool> _expansionStates = {};
  bool _areAllExpanded = false;

  void _toggleExpansion(String id) {
    setState(() {
      _expansionStates[id] = !(_expansionStates[id] ?? false);
    });
  }

  void _toggleAllExpansion() {
    setState(() {
      _areAllExpanded = !_areAllExpanded;
      for (var item in widget.items) {
        _expansionStates[item.id] = _areAllExpanded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Decorative line
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          
          // Optional header icon
          if (widget.headerIcon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF667EEA).withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.headerIcon,
                size: 16,
                color: const Color(0xFF667EEA),
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          // Title
          Text(
            widget.title,
            style: CardStyles.titleStyle(context, MediaQuery.of(context).size.width),
          ),
          const SizedBox(width: 12),
          
          // Expand/Collapse button
          if (widget.items.isNotEmpty) ...[
            InkWell(
              onTap: _toggleAllExpansion,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: CardStyles.actionButtonDecoration(
                  MediaQuery.of(context).size.width,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedRotation(
                      turns: _areAllExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.expand_more,
                        size: 16,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _areAllExpanded ? 'Comprimir' : 'Expandir',
                      style: CardStyles.actionStyle(
                        context, 
                        MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          
          const Spacer(),
          
          // Add button (if provided)
          if (widget.onAdd != null) ...[
            InkWell(
              onTap: widget.onAdd,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: CardStyles.actionButtonDecoration(
                  MediaQuery.of(context).size.width,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 16,
                      color: Color(0xFF667EEA),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Agregar',
                      style: CardStyles.actionStyle(
                        context,
                        MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          // Counter
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${widget.items.length}',
              style: CardStyles.counterStyle(
                context,
                MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: widget.items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.emptyText,
                      style: CardStyles.emptyStyle(
                        context,
                        MediaQuery.of(context).size.width,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: widget.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isExpanded = _expansionStates[item.id] ?? false;
                
                return widget.cardBuilder(
                  item,
                  isExpanded,
                  () => _toggleExpansion(item.id),
                );
              },
            ),
    );
  }
}