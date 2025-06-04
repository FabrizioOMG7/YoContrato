// lib/presentation/widgets/module_shell.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/presentation/pages/gestion_de_contratos/gestion_de_contratos_list_page.dart';
import 'package:yo_contrato_app/presentation/pages/gestion_de_contratos/gestion_de_contratos_search_page.dart';
import 'package:yo_contrato_app/presentation/pages/gestion_de_contratos_detail_page.dart';


/// Widget que provee un Navigator interno para un módulo específico.
/// Tiene rutas locales:
///  - '/': ListPage
///  - 'search': SearchPage
///  - 'detail': DetailPage (recibe DNI)
class ModuleShell extends StatelessWidget {
  final ModuleType module;

  const ModuleShell({Key? key, required this.module}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        late WidgetBuilder builder;
        final routeName = settings.name ?? '/';

        if (module == ModuleType.GESTION_DE_CONTRATOS) {
          // Módulo “Gestión de Contratos”
          if (routeName == '/' || routeName == null) {
            builder = (_) => const GestionDeContratosListPage();
          } else if (routeName == 'search') {
            builder = (_) => const GestionDeContratosSearchPage();
          } else if (routeName == 'detail') {
            final dni = settings.arguments as String?;
            builder = (_) => GestionDeContratosDetailPage(dni: dni);
          } else {
            // Cualquier otra ruta, volvemos a la lista
            builder = (_) => const GestionDeContratosListPage();
          }
        } else {
          // Si quisieras soportar otros módulos, añádelos aquí
          builder = (_) => const SizedBox.shrink(); 
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
