// lib/presentation/navigation/default_search_navigator.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/presentation/navigation/search_navigator.dart';

/// Implementación por defecto de SearchNavigator.
/// - Valida “pertenencia a sede” (aquí siempre true).
/// - Usa rutas relativas del Navigator interno:
///   'detail' para ir a la pantalla de detalle dentro del módulo.
class DefaultSearchNavigator implements SearchNavigator {
  const DefaultSearchNavigator();

  @override
  Future<void> navigateTo({
    required BuildContext context,
    required ModuleType module,
    required String dni,
  }) async {
    // Validación ligera (a futuro, extraer a UseCase). Aquí siempre true.
    final pertenece = _validaSede(module, dni);
    if (!pertenece) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No pertenece a esta sede'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Sólo manejamos el módulo “Gestión de Contratos” por ahora
    if (module == ModuleType.GESTION_DE_CONTRATOS) {
      // Ruta interna del Navigator anidado:
      Navigator.of(context).pushNamed('detail', arguments: dni);
    }
    // Si quieres manejar otros módulos, agrégalos aquí:
    // else if (module == ModuleType.RECLUTAMIENTO) { ... }
  }

  bool _validaSede(ModuleType module, String dni) {
    // Por ahora devuelve siempre true
    return true;
  }
}
