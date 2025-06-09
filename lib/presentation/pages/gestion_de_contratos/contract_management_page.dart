// lib/presentation/pages/gestion_de_contratos/contract_management_page.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import 'contract_management_content.dart';

/// Página de “Gestión de Contratos” con su propio AppBar.
/// Recibe un callback onBack para “volver” al MainNavigationPage.
class ContractManagementPage extends StatefulWidget {
  final VoidCallback onBack;

  const ContractManagementPage({
    Key? key,
    required this.onBack,
  }) : super(key: key);

  @override
  State<ContractManagementPage> createState() => _ContractManagementPageState();
}

class _ContractManagementPageState extends State<ContractManagementPage> {
  String _sede = 'C5 NORTE';

  final List<ContractItem> _contratos = const [
    ContractItem(
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    // Puedes agregar más ejemplos aquí...
  ];

  void _onSedeChanged(String newSede) {
    setState(() {
      _sede = newSede;
    });
  }

  void _onLogout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      // Interceptamos la flecha atrás del sistema: en lugar de hacer pop,
      // invocamos el callback onBack para regresar a MainNavigationPage.
      onWillPop: () async {
        widget.onBack();
        return false;
      },
      child: Scaffold(
        appBar: AppTopBar(
          title: 'GESTIÓN DE CONTRATOS',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          actions: [
            SettingsButton(
              isDarkMode: isDarkMode,
              sede: _sede,
              onSedeChanged: _onSedeChanged,
              onLogout: _onLogout,
            ),
          ],
        ),
        backgroundColor:
            isDarkMode ? const Color(0xFF030F0F) : const Color(0xFFF5F6FA),
        body: ContractManagementContent(
          sede: _sede,
          contratos: _contratos,
          onTapEditar: (contrato) {
            // Aquí podrías implementar la navegación interna a “editar postulante”:
            // Por ahora, lo dejamos vacío o mostramos un SnackBar.
          },
        ),
      ),
    );
  }
}
