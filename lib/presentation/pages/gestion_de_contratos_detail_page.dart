// lib/presentation/pages/gestion_de_contratos/gestion_de_contratos_detail_page.dart

import 'package:flutter/material.dart';

/// Pantalla de detalle del contrato. Recibe el DNI como argumento.
class GestionDeContratosDetailPage extends StatelessWidget {
  final String? dni;
  const GestionDeContratosDetailPage({Key? key, this.dni}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Contrato'),
      ),
      body: Center(
        child: Text(
          dni != null
              ? 'Detalle del contrato para DNI: $dni'
              : 'DNI no proporcionado',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
