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
  bool _isInContractManagement = false;

  final List<Widget> _screens = [
    Container(), // MENU
    Container(), // SEARCH
    const DashboardPage(), // HOME
    const RegisterApplicantPage(), // ADD_PERSON
    Container(), // SYNC
  ];

  void _onNavBarTap(int index) {
    if (index == NavItem.MENU.index && !_isInContractManagement) {
      _showModulesPanel();
    } else {
      setState(() {
        _currentIndex = index;
        if (index != NavItem.MENU.index) {
          _isInContractManagement = false;
        }
      });
    }
  }

  void _showModulesPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModulesPanel(
        isDarkMode: Theme.of(context).brightness == Brightness.dark,
        onModuleTap: (moduleIndex) => _onModuleSelected(moduleIndex, context),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _onModuleSelected(int moduleIndex, BuildContext modalContext) {
    final module = ModuleType.values[moduleIndex];
    Navigator.pop(modalContext);
    
    if (module == ModuleType.GESTION_DE_CONTRATOS) {
      setState(() {
        _currentIndex = NavItem.MENU.index;
        _isInContractManagement = true;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContractManagementPage(
            onBack: () {
              setState(() {
                _currentIndex = NavItem.HOME.index;
                _isInContractManagement = false;
              });
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${module.displayName} no implementado aún'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != NavItem.HOME.index || _isInContractManagement) {
          setState(() {
            _currentIndex = NavItem.HOME.index;
            _isInContractManagement = false;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: AppNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          isInContractManagement: _isInContractManagement,
        ),
      ),
    );
  }
}