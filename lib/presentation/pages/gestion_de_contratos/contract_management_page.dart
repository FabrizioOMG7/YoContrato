// lib/presentation/pages/gestion_de_contratos/contract_management_page.dart

import 'package:flutter/material.dart';
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
  String sede = 'C5 NORTE';
  bool isDarkMode = false;

  // Lista mockup de contratos
  final List<ContractItem> contratos = [
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    const ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
  ];

  void _onTapBuscar(ContractItem contrato) {
    // TODO: Implementar navegación a búsqueda de postulantes
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ApplicantSearchPage(
    //       sede: sede,
    //       contractItem: contrato,
    //     ),
    //   ),
    // );
    
    // Por ahora, mostrar un SnackBar
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
            sede: sede,
            onSedeChanged: (newSede) {
              setState(() {
                sede = newSede;
              });
            },
            onLogout: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
        backgroundColor: AppTheme.primary,
        textColor: Colors.white,
      ),
      backgroundColor: isDarkMode 
          ? const Color(0xFF030F0F) 
          : const Color(0xFFF5F6FA),
      body: ContractManagementContent(
        sede: sede,
        contratos: contratos,
        onTapBuscar: _onTapBuscar,
      ),
    );
  }
}