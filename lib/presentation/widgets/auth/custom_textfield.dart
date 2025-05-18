// lib/widgets/auth/custom_textfield.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final bool showVisibilityIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.onToggleVisibility,
    this.showVisibilityIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              boxShadow: hasFocus
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: GoogleFonts.montserrat(fontSize: 16),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.montserrat(
                  color: hasFocus ? Theme.of(context).primaryColor : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
                suffixIcon: showVisibilityIcon
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: onToggleVisibility,
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}