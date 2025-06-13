// lib/presentation/widgets/shared/content_list/content_list_widget.dart
import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/models/base/base_item.dart';
import '../styles/card_styles.dart';
import '../../../../core/design_system/app_spacing.dart';

class ContentListWidget<T extends BaseItem> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item, bool isExpanded, VoidCallback onToggle) cardBuilder;
  final VoidCallback? onAdd;
  final String emptyText;

  const ContentListWidget({
    super.key,
    required this.title,
    required this.items,
    required this.cardBuilder,
    required this.emptyText,
    this.onAdd,
  });

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context),
        Flexible(
          fit: FlexFit.loose,
          child: _buildContent(context),
        ),
      ],
    );
  }

  /// Header compacto con padding reducido
  Widget _buildHeader(BuildContext context) {
    return Padding(
      // Padding del header reducido
      padding: AppSpacing.getListHeaderPadding(),
      child: Row(
        children: [
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
          
          Expanded(
            child: Text(
              widget.title,
              style: CardStyles.titleStyle(context, MediaQuery.of(context).size.width),
            ),
          ),
          
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
            const SizedBox(width: 8),
          ],

          // Contador compacto
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

          // Botón de agregar compacto
          if (widget.onAdd != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: widget.onAdd,
              icon: const Icon(
                Icons.person_add_alt_1,
                size: 26, // Reducido de 30 a 26
                color: Color(0xFF667EEA),
              ),
              tooltip: 'Agregar nuevo elemento',
              // Padding reducido del botón
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            )
          ],
        ],
      ),
    );
  }

  /// Lista con padding optimizado para maximizar espacio
  Widget _buildContent(BuildContext context) {
    if (widget.items.isEmpty) {
      return Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24), // Reducido de 32 a 24
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      // Padding de la lista reducido para maximizar espacio de cards
      padding: AppSpacing.getListPadding(),
      itemCount: widget.items.length,
      // Separación entre cards reducida
      separatorBuilder: (_, __) => SizedBox(height: AppSpacing.cardSpacing),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isExpanded = _expansionStates[item.id] ?? false;
        
        return widget.cardBuilder(
          item,
          isExpanded,
          () => _toggleExpansion(item.id),
        );
      },
    );
  }
}