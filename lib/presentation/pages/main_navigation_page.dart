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
  ModuleType? _activeModule;

  final List<Widget> _screensNormal = [
    Container(),                   // 0: MENU (solo abre panel)
    Container(),                   // 1: SEARCH placeholder
    const DashboardPage(),         // 2: HOME
    const RegisterApplicantPage(), // 3: ADD_PERSON
    Container(),                   // 4: SYNC placeholder
  ];

  late final Map<ModuleType, Widget> _moduleScreens = {
    ModuleType.GESTION_DE_CONTRATOS:
        ContractManagementPage(onBack: _exitModule),
  };

  void _onNavBarTap(int index) {
    // Siempre permitimos mostrar el panel de módulos
    if (index == NavItem.MENU.index) {
      _showModulesPanel();
      return;
    }

    // Para otros índices
    setState(() {
      if (_activeModule != null) {
        // Si estamos en un módulo, salimos de él
        _activeModule = null;
      }
      _currentIndex = index;
    });
  }

  void _showModulesPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModulesPanel(
        isDarkMode: Theme.of(context).brightness == Brightness.dark,
        onModuleTap: _onModuleSelected,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _onModuleSelected(int moduleIndex) {
    final chosen = ModuleType.values[moduleIndex];
    Navigator.pop(context);

    // Si seleccionamos el mismo módulo, no hacemos nada
    if (chosen == _activeModule) return;

    if (_moduleScreens.containsKey(chosen)) {
      setState(() {
        _activeModule = chosen;
        _currentIndex = NavItem.MENU.index;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${chosen.displayName} no implementado aún'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _exitModule() {
    setState(() {
      _activeModule = null;
      _currentIndex = NavItem.HOME.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_activeModule != null) {
          _exitModule();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: _activeModule != null
            ? _moduleScreens[_activeModule]!
            : IndexedStack(
                index: _currentIndex,
                children: _screensNormal,
              ),
        bottomNavigationBar: AppNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          isInModule: _activeModule != null,
        ),
      ),
    );
  }
}