// lib/presentation/pages/gestion_de_contratos/contract_search_page.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/models/contract/contract_item.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import 'package:yo_contrato_app/presentation/widgets/applicant/applicant_search_widget.dart';
import 'contract_management_content.dart'; // Para acceder a ContractItem

/// Pantalla que muestra el ApplicantSearchWidget para el contrato elegido.
/// Recibe el objeto ContractItem para personalizar textos si se desea.
class ContractSearchPage extends StatelessWidget {
  final ContractItem contrato;

  const ContractSearchPage({
    Key? key,
    required this.contrato,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Configuración específica para búsqueda desde Gestión de Contratos
    final config = ApplicantSearchConfig(
      searchTitle: 'Buscar postulante',
      searchDescription:
          'Ingresa DNI o escanea QR para el contrato de "${contrato.nombre}"',
      searchPlaceholder: 'Ej: 12345678',
      showQRSection: true,
      qrTitle: 'Código QR de contrato',
      qrDescription1: 'Escanea este código para buscar rápido',
      qrDescription2: 'el postulante en la base de datos',
      separatorText: 'O ESCANEA EL CÓDIGO QR',
      onSearch: (dni) async {
        // Aquí iría la llamada real al backend. Por ahora simulamos:
        await Future.delayed(const Duration(milliseconds: 800));
      },
      onSearchSuccess: (dni) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Postulante $dni encontrado (simulado).'),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );
      },
      onSearchError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
        );
      },
      customValidation: (dni) {
        if (dni.isEmpty) return 'Por favor ingresa un DNI';
        if (dni.length != 8) return 'El DNI debe tener 8 dígitos';
        return null;
      },
    );

    return Scaffold(
      appBar: AppTopBar(
        title: 'Buscar Postulante',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ApplicantSearchWidget(config: config),
      ),
    );
  }
}
