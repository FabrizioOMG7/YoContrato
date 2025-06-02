import 'package:flutter/material.dart';
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

  final List<Widget> _screens = [
    // El orden debe coincidir con el orden de los ítems del navbar
    Container(),               // Buscar (puedes poner tu página de búsqueda)
    Container(),           // Menú
    DashboardPage(),           // Inicio (puedes cambiar por otra página principal)
    RegisterApplicantPage(),   // Agregar
    Container(),               // Sincronizar (puedes poner tu página de sincronización)
  ];

void _onNavBarTap(int index) {
  if (index == 0) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ModulesPanel(
        isDarkMode: Theme.of(context).brightness == Brightness.dark,
        onModuleTap: (i) {
          // Acción al seleccionar módulo (opcional)
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
    // No cambias el _currentIndex si solo quieres mostrar el panel
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