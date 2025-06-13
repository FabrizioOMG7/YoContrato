// lib/presentation/widgets/shared/cards/base_card.dart
import 'package:flutter/material.dart';
import '../../../../core/design_system/app_spacing.dart';

abstract class BaseCard extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final VoidCallback? onEdit;

  const BaseCard({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpansion,
    this.onEdit,
  }) : super(key: key);

  // Métodos abstractos que las subclases deben implementar
  Widget buildHeader(BuildContext context);
  Widget buildExpandedContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        color: isDarkMode ? const Color(0xFF1B254B) : Colors.white,
        child: InkWell(
          onTap: onToggleExpansion,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: AppSpacing.getResponsiveCardPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildHeader(context),
                if (isExpanded) ...[
                  const Divider(
                    height: AppSpacing.cardDividerVertical,
                    thickness: 1,
                  ),
                  buildExpandedContent(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}