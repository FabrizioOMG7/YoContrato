// lib/core/design_system/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Obtener el factor de escala del sistema
  static double _getTextScaleFactor(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Limitar el factor de escala para evitar overflow
    return mediaQuery.textScaleFactor.clamp(0.8, 1.3);
  }

  // Títulos de tarjetas - responsive y limitado
  static TextStyle cardTitle(BuildContext context, {bool isDarkMode = false}) {
    return GoogleFonts.inter(
      fontSize: 14 * _getTextScaleFactor(context),
      fontWeight: FontWeight.w600,
      color: isDarkMode ? Colors.white : const Color(0xFF111827),
      letterSpacing: -0.2,
      height: 1.2, // Controlar altura de línea
    );
  }

  // Subtítulos de tarjetas
  static TextStyle cardSubtitle(BuildContext context, {bool isDarkMode = false}) {
    return GoogleFonts.inter(
      fontSize: 12 * _getTextScaleFactor(context),
      color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
      height: 1.3,
    );
  }

  // Texto de información en tarjetas
  static TextStyle cardInfo(BuildContext context, {bool isDarkMode = false}) {
    return GoogleFonts.inter(
      fontSize: 12 * _getTextScaleFactor(context),
      color: isDarkMode ? Colors.white70 : const Color(0xFF4B5563),
      height: 1.4,
    );
  }

  // Labels en información de tarjetas
  static TextStyle cardInfoLabel(BuildContext context, {bool isDarkMode = false}) {
    return GoogleFonts.inter(
      fontSize: 12 * _getTextScaleFactor(context),
      fontWeight: FontWeight.w600,
      color: isDarkMode ? Colors.white70 : const Color(0xFF4B5563),
      height: 1.4,
    );
  }

  // Títulos de sección
  static TextStyle sectionTitle(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 16 * _getTextScaleFactor(context),
      fontWeight: FontWeight.w700,
      color: const Color(0xFF111827),
      letterSpacing: -0.2,
      height: 1.25,
    );
  }
}