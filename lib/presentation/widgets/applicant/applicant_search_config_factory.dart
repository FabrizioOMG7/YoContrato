// lib/presentation/widgets/applicant/applicant_search_config_factory.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/presentation/navigation/search_navigator.dart';
import 'package:yo_contrato_app/presentation/widgets/applicant/applicant_search_widget.dart';


/// Fábrica que produce un ApplicantSearchConfig configurado para cada módulo.
class ApplicantSearchConfigFactory {
  static ApplicantSearchConfig forModule({
    required BuildContext context,
    required ModuleType module,
    required SearchNavigator navigator,
    String? customTitle,
    String? customDescription,
    bool? showQRSection,
  }) {
    String title;
    String description;
    bool qr = showQRSection ?? true;

    if (module == ModuleType.GESTION_DE_CONTRATOS) {
      title = customTitle ?? 'Buscar postulante para Contratos';
      description = customDescription ??
          'Ingresa el DNI del candidato para asociarlo a un contrato';
      qr = true;
    } else {
      title = customTitle ?? 'Buscar postulante';
      description = customDescription ?? 'Ingresa el DNI del candidato';
      qr = true;
    }

    return ApplicantSearchConfig(
      searchTitle: title,
      searchDescription: description,
      showQRSection: qr,
      onSearchSuccess: (dni) async {
        await navigator.navigateTo(
          context: context,
          module: module,
          dni: dni,
        );
      },
    );
  }
}
