// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Colores base
  static const Color primary = Color.fromRGBO(22, 31, 73, 1);
  static const Color scaffoldBackground = Color(0xFFF5F5F5);

  static ThemeData get lightTheme => ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldBackground,
    
    // Configuración AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Configuración de Cards
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Configuración de Textos
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'Stabillo Medium 500',
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.black54,
        fontSize: 12,
      ),
    ),

    // Configuración de Íconos
    iconTheme: const IconThemeData(
      color: primary,
      size: 32,
    ),

    // Nueva configuración para Checkboxes
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        return states.contains(WidgetState.selected) 
            ? primary 
            : Colors.grey[300]!;
      }),
    ),
  );
}