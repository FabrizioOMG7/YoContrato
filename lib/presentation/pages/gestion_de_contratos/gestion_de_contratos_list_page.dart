// lib/presentation/pages/gestion_de_contratos/gestion_de_contratos_list_page.dart

import 'package:flutter/material.dart';

/// Pantalla de listado de “Gestión de Contratos”.
/// Desde aquí se accede a la búsqueda de postulantes dentro del módulo.
class GestionDeContratosListPage extends StatelessWidget {
  const GestionDeContratosListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Contratos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Aquí irá el listado de contratos (placeholder).',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navega dentro del Navigator interno a 'search'
                Navigator.of(context).pushNamed('search');
              },
              child: const Text('Buscar Postulante por DNI/QR'),
            ),
          ],
        ),
      ),
    );
  }
}
