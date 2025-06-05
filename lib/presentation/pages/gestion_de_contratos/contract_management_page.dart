import 'package:flutter/material.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import 'package:yo_contrato_app/core/theme/app_theme.dart';

class ContractManagementPage extends StatefulWidget {
  const ContractManagementPage({Key? key}) : super(key: key);

  @override
  State<ContractManagementPage> createState() => _ContractManagementPageState();
}

class _ContractManagementPageState extends State<ContractManagementPage> {
  String sede = 'CHICLAYO';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gestión de Contratos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Sede: $sede',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}