import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/domain/navigation/nav_item.dart';
import 'package:yo_contrato_app/presentation/pages/dashboard_page.dart';
import 'package:yo_contrato_app/presentation/pages/register_applicant_page.dart';
import 'package:yo_contrato_app/presentation/pages/gestion_de_contratos/contract_management_page.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_navbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/modules_panel.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = NavItem.HOME.index;
  int? _activeModuleScreenIndex;

  /// Pantallas “normales” (índices 0 a 4)
  final List<Widget> _screensNormal = [
    Container(),                   // índice 0: MENU (abre panel)
    Container(),                   // índice 1: SEARCH (placeholder)
    const DashboardPage(),         // índice 2: HOME
    const RegisterApplicantPage(), // índice 3: ADD_PERSON
    Container(),                   // índice 4: SYNC (placeholder)
  ];

  /// Pantallas totales: normales + módulo en posición 5.
  late final List<Widget> _screensTotal = [
    ..._screensNormal,
    ContractManagementPage(onBack: _exitContractManagement), // índice 5
  ];

  void _onNavBarTap(int index) {
    // 1) Si NO hay módulo activo, comportamiento normal:
    if (_activeModuleScreenIndex == null) {
      if (index == NavItem.MENU.index) {
        _showModulesPanel();
      } else {
        setState(() {
          _currentIndex = index;
        });
      }
      return;
    }

    // 2) Si SÍ hay módulo activo:
    //    - Si tocan “Menú” (índice 0), NO SALIMOS del módulo (ignoramos).
    if (index == NavItem.MENU.index) {
      return;
    }

    //    - Si tocan CUALQUIER OTRO ícono (SEARCH=1, HOME=2, ADD_PERSON=3, SYNC=4),
    //      SALIMOS del módulo y vamos a esa pestaña normal:
    setState(() {
      _activeModuleScreenIndex = null;
      _currentIndex = index;
    });
  }

  void _showModulesPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModulesPanel(
        isDarkMode: Theme.of(context).brightness == Brightness.dark,
        onModuleTap: (moduleIndex) => _onModuleSelected(moduleIndex),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _onModuleSelected(int moduleIndex) {
    final module = ModuleType.values[moduleIndex];
    Navigator.pop(context); // cerramos el panel

    if (module == ModuleType.GESTION_DE_CONTRATOS) {
      setState(() {
        _activeModuleScreenIndex = 5;       // índice en _screensTotal
        _currentIndex = NavItem.MENU.index; // forzamos que marque “Menú”
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${module.displayName} no implementado aún'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _exitContractManagement() {
    setState(() {
      _activeModuleScreenIndex = null;
      _currentIndex = NavItem.HOME.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_activeModuleScreenIndex != null) {
          _exitContractManagement();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: _activeModuleScreenIndex != null
            ? _screensTotal[_activeModuleScreenIndex!]
            : IndexedStack(
                index: _currentIndex,
                children: _screensNormal,
              ),
        bottomNavigationBar: AppNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          isInContractManagement: _activeModuleScreenIndex != null,
        ),
      ),
    );
  }
}
