// lib/presentation/pages/gestion_de_contratos/gestion_de_contratos_search_page.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/presentation/navigation/default_search_navigator.dart';
import 'package:yo_contrato_app/presentation/navigation/search_navigator.dart';
import 'package:yo_contrato_app/presentation/widgets/applicant/applicant_search_config_factory.dart';
import 'package:yo_contrato_app/presentation/widgets/applicant/applicant_search_widget.dart';


/// Pantalla de búsqueda de postulantes para el módulo "Gestión de Contratos".
class GestionDeContratosSearchPage extends StatelessWidget {
  const GestionDeContratosSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Instanciamos el SearchNavigator “por defecto”
    final SearchNavigator navigator = const DefaultSearchNavigator();

    // 2. Obtenemos la configuración inyectando el módulo correspondiente
    final config = ApplicantSearchConfigFactory.forModule(
      context: context,
      module: ModuleType.GESTION_DE_CONTRATOS,
      navigator: navigator,
      // Si deseas personalizar título o descripción, descomenta y modifica:
      // customTitle: 'Título personalizado...',
      // customDescription: 'Descripción personalizada...',
      // showQRSection: true/false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(config.searchTitle),
      ),
      body: ApplicantSearchWidget(config: config),
    );
  }
}
