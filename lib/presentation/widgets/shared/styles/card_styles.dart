import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardStyles {
  // Title style for headers
  static TextStyle titleStyle(BuildContext context, double width) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF111827),
    letterSpacing: -0.2,
  );

  // Subtitle style for secondary text
  static TextStyle subtitleStyle(BuildContext context, double width) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF6B7280),
  );

  // Action button text style
  static TextStyle actionStyle(BuildContext context, double width) => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF667EEA),
  );

  // Counter style for numbers
  static TextStyle counterStyle(BuildContext context, double width) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF667EEA),
  );

  // Empty state style
  static TextStyle emptyStyle(BuildContext context, double width) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF6B7280),
  );

  // Helper method for action buttons
  static BoxDecoration actionButtonDecoration(double width) => BoxDecoration(
    color: const Color(0xFF667EEA).withAlpha(20),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color: const Color(0xFF667EEA).withAlpha(51),
    ),
  );

  // Helper method for container decoration
  static BoxDecoration containerDecoration(double width) => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(10),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Header decoration
  static BoxDecoration headerDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ),
  );
}