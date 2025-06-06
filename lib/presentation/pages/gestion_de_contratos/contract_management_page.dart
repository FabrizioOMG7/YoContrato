import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/navigation/nav_item.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_navbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import 'package:yo_contrato_app/core/theme/app_theme.dart';
import 'contract_management_content.dart';

class ContractManagementPage extends StatefulWidget {
  const ContractManagementPage({Key? key}) : super(key: key);

  @override
  State<ContractManagementPage> createState() => _ContractManagementPageState();
}

class _ContractManagementPageState extends State<ContractManagementPage> {
  // Estado local
  String _sede = 'C5 NORTE';
  int _currentIndex = NavItem.HOME.index;
  
  // Lista mockup de contratos (esto debería venir de un repository)
  final List<ContractItem> _contratos = [
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    // ... otros contratos
  ];

  // Handlers
  void _onNavBarTap(int index) {
    if (index == NavItem.MENU.index) {
      Navigator.pop(context);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  void _onSedeChanged(String newSede) {
    setState(() => _sede = newSede);
  }

  void _onLogout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onTapBuscar(ContractItem contrato) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buscar postulante para: ${contrato.nombre}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppTopBar(
        title: 'GESTIÓN DE CONTRATOS',
        actions: [
          SettingsButton(
            isDarkMode: isDarkMode,
            sede: _sede,
            onSedeChanged: _onSedeChanged,
            onLogout: _onLogout,
          ),
        ],
        backgroundColor: AppTheme.primary,
        textColor: Colors.white,
      ),
      backgroundColor: isDarkMode 
          ? const Color(0xFF030F0F) 
          : const Color(0xFFF5F6FA),
      body: ContractManagementContent(
        sede: _sede,
        contratos: _contratos,
        onTapBuscar: _onTapBuscar,
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}