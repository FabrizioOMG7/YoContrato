import 'package:flutter/material.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import '../../../domain/models/contract/contract_item.dart';
import 'contract_management_content.dart';

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
  bool _isLoading = false;

  // Lista de contratos de ejemplo
  final List<ContractItem> _contratos = [
    ContractItem(
      id: '1',
      nombre: 'RAMIREZ CARLOS MARTIN',
      dni: '46882447',
      evento: 'EVENTO PRUEBA FIN',
      fechaHora: '22/04/2025 - 00:12:13',
    ),
    ContractItem(
      id: '2',
      nombre: 'GARCIA ANA LUCIA',
      dni: '45667890',
      evento: 'EVENTO PRUEBA 2',
      fechaHora: '23/04/2025 - 14:30:00',
    ),
  ];

  void _onSedeChanged(String newSede) {
    if (mounted) {
      setState(() {
        _sede = newSede;
      });
    }
  }

  void _onLogout() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<void> _handleEditContract(ContractItem contrato) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Editando contrato: ${contrato.nombre}'),
          duration: const Duration(seconds: 2),
        ),
      );
      // TODO: Implementar lógica de edición
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al editar: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleAddContract() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Agregando nuevo contrato...'),
          duration: Duration(seconds: 2),
        ),
      );
      // TODO: Implementar lógica para agregar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al agregar: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
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
        backgroundColor: isDarkMode 
            ? const Color(0xFF030F0F) 
            : const Color(0xFFF5F6FA),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ContractManagementContent(
                sede: _sede,
                contratos: _contratos,
                onTapEditar: _handleEditContract,
                onTapAdd: _handleAddContract,
              ),
      ),
    );
  }
}