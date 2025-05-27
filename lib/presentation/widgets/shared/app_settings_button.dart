import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class SettingsButton extends StatelessWidget {
  final bool isDarkMode;
  final String sede;
  final ValueChanged<String> onSedeChanged;
  final VoidCallback onLogout;

  const SettingsButton({
    super.key,
    required this.isDarkMode,
    required this.sede,
    required this.onSedeChanged,
    required this.onLogout,
  });

  void _showSettingsModal(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final iconColor = isDarkMode ? Colors.white : AppTheme.primary;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF030F0F) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Barra superior del panel
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Opción: Cambiar sede
              ListTile(
                leading: Icon(Icons.location_on, color: iconColor),
                title: Text(
                  "Cambiar sede",
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: DropdownButton<String>(
                  dropdownColor:
                      isDarkMode ? const Color(0xFF161F49) : Colors.white,
                  value: sede,
                  underline: const SizedBox(),
                  style: GoogleFonts.montserrat(color: textColor),
                  items: const [
                    DropdownMenuItem(value: "Chiclayo", child: Text("Chiclayo")),
                    DropdownMenuItem(value: "Lima", child: Text("Lima")),
                    DropdownMenuItem(value: "Arequipa", child: Text("Arequipa")),
                    DropdownMenuItem(value: "Trujillo", child: Text("Trujillo")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      onSedeChanged(value);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),

              Divider(color: isDarkMode ? Colors.white24 : Colors.grey[300]),

              // Opción: Tema (sin funcionalidad)
              SwitchListTile(
                secondary: Icon(
                  isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_outlined,
                  color: iconColor,
                ),
                title: Text(
                  "Tema",
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: isDarkMode,
                onChanged: (_) {
                  // Aquí NO se ejecuta ninguna lógica
                  Navigator.pop(context); // Solo cierra el modal (opcional)
                },
                activeColor: Colors.white,
              ),

              Divider(color: isDarkMode ? Colors.white24 : Colors.grey[300]),

              // Opción: Salir
              ListTile(
                leading: Icon(Icons.logout, color: iconColor),
                title: Text(
                  "Salir",
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onLogout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: isDarkMode ? Colors.amber : Colors.white,
      ),
      onPressed: () => _showSettingsModal(context),
    );
  }
}
