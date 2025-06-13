// lib/core/design_system/app_spacing.dart
import 'package:flutter/material.dart';

class AppSpacing {
  // Espaciados base
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;

  // Espaciados específicos para cards
  static const double cardDividerVertical = 20.0;
  
  /// Padding de página reducido para maximizar espacio de contenido
  /// Aplica el principio de Configuración Centralizada
  static EdgeInsets getPagePadding() {
    return const EdgeInsets.symmetric(
      horizontal: 12.0, // Reducido de 16.0 a 12.0
      vertical: 8.0,    // Reducido de 16.0 a 8.0
    );
  }

  /// Padding responsivo para cards - optimizado para más contenido
  /// Aplica responsive design según el tamaño de pantalla
  static EdgeInsets getResponsiveCardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 600) {
      // Tablets y pantallas grandes
      return const EdgeInsets.all(16.0);
    } else {
      // Móviles - padding reducido para maximizar espacio
      return const EdgeInsets.symmetric(
        horizontal: 12.0, // Reducido de 16.0 a 12.0
        vertical: 10.0,   // Reducido de 12.0 a 10.0
      );
    }
  }

  /// Espaciado entre cards optimizado
  static const double cardSpacing = 8.0; // Reducido de 12.0 a 8.0

  /// Espaciado interno de listas reducido
  static EdgeInsets getListPadding() {
    return const EdgeInsets.symmetric(
      horizontal: 12.0, // Reducido de 16.0 a 12.0
      vertical: 8.0,    // Reducido de 16.0 a 8.0
    );
  }

  /// Espaciado del header de lista reducido
  static EdgeInsets getListHeaderPadding() {
    return const EdgeInsets.symmetric(
      horizontal: 12.0, // Reducido de 16.0 a 12.0
      vertical: 12.0,   // Reducido de 16.0 a 12.0
    );
  }
}
