import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/presentation/pages/gestion_de_contratos/gestion_de_contratos_list_page.dart';
import 'package:yo_contrato_app/presentation/widgets/module_shell.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_navbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/modules_panel.dart';
import 'dashboard_page.dart';
import 'register_applicant_page.dart';


class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 2;

  // Lista de “pantallas” que aparecen al cambiar BottomNav,
  // excepto los módulos, que se abren desde el panel.
  final List<Widget> _screens = [
    Container(), // índice 0: Menú (no muestra pantalla)
    Container(), // índice 1: Buscar (placeholder)
    const DashboardPage(), // índice 2: Inicio
    const RegisterApplicantPage(), // índice 3: Agregar
    Container(), // índice 4: Sincronizar (placeholder)
    // No ponemos el Módulo aquí; se abre desde el panel.
  ];

  void _onNavBarTap(int index) {
    if (index == 0) {
      // Abrir panel de módulos
      showModalBottomSheet(
        context: context,
        builder: (_) => ModulesPanel(
          isDarkMode: Theme.of(context).brightness == Brightness.dark,
          onModuleTap: (i) {
            // Cuando el usuario toca un módulo:
            // 1) Primero cerramos el panel
            Navigator.pop(context);
            // 2) Luego abrimos la pantalla del módulo elegido
            final moduleType = ModuleType.values[i];
            // Pequeña demora para que el bottom sheet se cierre antes de navegar
            Future.delayed(Duration.zero, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ModuleShell(module: moduleType),
                ),
              );
            });
          },
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AppNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
