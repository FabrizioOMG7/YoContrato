// lib/core/design_system/app_spacing.dart
import 'package:flutter/material.dart';

class AppSpacing {
  // Espaciado base consistente en toda la app
  static const double xs = 4.0;   // 4px
  static const double sm = 8.0;   // 8px  
  static const double md = 12.0;  // 12px
  static const double lg = 16.0;  // 16px
  static const double xl = 24.0;  // 24px
  static const double xxl = 32.0; // 32px

  // Espaciado específico para cards
  static const double cardHorizontal = 16.0;
  static const double cardVertical = 12.0;
  static const double cardHeaderBottom = 8.0;
  static const double cardDividerVertical = 16.0;

  // Espaciado responsive para contenido principal
  static const double pageHorizontal = 16.0;
  static const double pageVertical = 12.0;

  // Método para obtener padding responsive basado en el ancho de pantalla
  static EdgeInsets getResponsiveCardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Para pantallas muy pequeñas, reducir el padding
    if (screenWidth < 360) {
      return const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: cardVertical,
      );
    }
    
    // Para pantallas normales
    return const EdgeInsets.symmetric(
      horizontal: cardHorizontal,
      vertical: cardVertical,
    );
  }

  // Método para obtener padding de página consistente
  static EdgeInsets getPagePadding() {
    return const EdgeInsets.symmetric(
      horizontal: pageHorizontal,
      vertical: pageVertical,
    );
  }
}