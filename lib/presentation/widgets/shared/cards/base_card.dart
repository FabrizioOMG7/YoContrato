import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Constantes para manejo de espaciado responsive
class ResponsiveSpacing {
  // Porcentajes del ancho de pantalla
  static const double HORIZONTAL_PADDING_FACTOR = 0.04; // 4% del ancho
  static const double MIN_HORIZONTAL_PADDING = 8.0;
  static const double MAX_HORIZONTAL_PADDING = 16.0;
}

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

  // Calcula el padding horizontal basado en el ancho de la pantalla
  double _calculateHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final calculatedPadding = screenWidth * ResponsiveSpacing.HORIZONTAL_PADDING_FACTOR;
    
    // Limita el padding entre los valores mínimo y máximo
    return calculatedPadding.clamp(
      ResponsiveSpacing.MIN_HORIZONTAL_PADDING,
      ResponsiveSpacing.MAX_HORIZONTAL_PADDING,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final horizontalPadding = _calculateHorizontalPadding(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        color: isDarkMode ? const Color(0xFF1B254B) : Colors.white,
        child: InkWell(
          onTap: onToggleExpansion,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildHeader(context),
                if (isExpanded) ...[
                  Divider(
                    height: 16,
                    thickness: 1,
                    indent: horizontalPadding * 0.5, // Mitad del padding horizontal
                    endIndent: horizontalPadding * 0.5,
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