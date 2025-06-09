// lib/presentation/pages/main_navigation_page.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';
import 'package:yo_contrato_app/domain/navigation/nav_item.dart';
import 'package:yo_contrato_app/presentation/pages/dashboard_page.dart';
import 'package:yo_contrato_app/presentation/pages/register_applicant_page.dart';
import 'package:yo_contrato_app/presentation/pages/gestion_de_contratos/contract_management_page.dart';
// Si agregas nuevos módulos, importa aquí sus páginas, por ejemplo:
// import 'package:yo_contrato_app/presentation/pages/reclutamiento/reclutamiento_page.dart';
// import 'package:yo_contrato_app/presentation/pages/ficha_medica/ficha_medica_page.dart';

import 'package:yo_contrato_app/presentation/widgets/shared/app_navbar.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/modules_panel.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // Índice de la pestaña normal seleccionada (HOME, SEARCH, etc.).
  int _currentIndex = NavItem.HOME.index;

  // Si está en un módulo específico, almacena qué ModuleType está activo.
  // Si es null → no estamos dentro de ningún módulo (mostramos IndexedStack).
  ModuleType? _activeModule;

  /// Listado de pantallas “normales” (índices 0 a 4). Corresponde a NavItem.values.
  final List<Widget> _screensNormal = [
    Container(),                   // 0: MENU (solo abre panel)
    Container(),                   // 1: SEARCH placeholder
    const DashboardPage(),         // 2: HOME
    const RegisterApplicantPage(), // 3: ADD_PERSON
    Container(),                   // 4: SYNC placeholder
  ];

  /// Mapeo de cada ModuleType a la pantalla correspondiente.
  /// Agrega aquí cada módulo que desees escalar:
  late final Map<ModuleType, Widget> _moduleScreens = {
    ModuleType.GESTION_DE_CONTRATOS:
        ContractManagementPage(onBack: _exitModule),
    // Ejemplos de cómo quedaría si tuviera más módulos:
    // ModuleType.RECLUTAMIENTO: ReclutamientoPage(onBack: _exitModule),
    // ModuleType.FICHA_MEDICA: FichaMedicaPage(onBack: _exitModule),
    // ModuleType.BBS: BbsPage(onBack: _exitModule),
    // ModuleType.FOTOGRAFIA: FotografiaPage(onBack: _exitModule),
    // ModuleType.FIRMA_DE_DOCUMENTOS: FirmaDocumentosPage(onBack: _exitModule),
    // ModuleType.VALIDACION_Y_FOTOCHECK: ValidacionFotocheckPage(onBack: _exitModule),
    // ModuleType.DESISTIMIENTO: DesistimientoPage(onBack: _exitModule),
    // ModuleType.GESTION_DE_POSTULACIONES: GestionDePostulacionesPage(onBack: _exitModule),
    // ModuleType.RECLUTAMIENTO: ReclutamientoPage(onBack: _exitModule),
    // etc.
  };

  /// Llamado al pulsar un ícono de BottomNavBar.
  void _onNavBarTap(int index) {
    // 1) Si NO hay módulo activo, comportamiento normal:
    if (_activeModule == null) {
      if (index == NavItem.MENU.index) {
        _showModulesPanel();
      } else {
        setState(() {
          _currentIndex = index;
        });
      }
      return;
    }

    // 2) Si SÍ hay módulo activo:
    //    - Si tocan “Menú” (índice 0), NO SALIMOS del módulo (ignoramos).
    if (index == NavItem.MENU.index) {
      return;
    }

    //    - Si tocan cualquier otro (SEARCH=1, HOME=2, ADD_PERSON=3, SYNC=4),
    //      entonces SALIMOS del módulo y vamos a la pestaña normal correspondiente:
    setState(() {
      _activeModule = null;
      _currentIndex = index;
    });
  }

  /// Muestra el BottomSheet con la grilla de módulos.
  void _showModulesPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModulesPanel(
        isDarkMode: Theme.of(context).brightness == Brightness.dark,
        onModuleTap: (moduleIndex) => _onModuleSelected(moduleIndex),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Cuando el usuario elige un módulo en ModulesPanel:
  void _onModuleSelected(int moduleIndex) {
    final chosen = ModuleType.values[moduleIndex];
    Navigator.pop(context); // cerramos el panel

    if (_moduleScreens.containsKey(chosen)) {
      setState(() {
        _activeModule = chosen;
        // Al entrar en un módulo, forzamos que el ícono de MENÚ quede marcado:
        _currentIndex = NavItem.MENU.index;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${chosen.displayName} no implementado aún'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Callback que pasamos a cada página de módulo. Cuando el módulo
  /// llama onBack(), salimos al flujo normal y mostramos HOME.
  void _exitModule() {
    setState(() {
      _activeModule = null;
      _currentIndex = NavItem.HOME.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Interceptamos la flecha atrás del sistema:
      onWillPop: () async {
        if (_activeModule != null) {
          // Si hay módulo activo, lo cerramos (no salimos de la app).
          _exitModule();
          return false;
        }
        return true; // Si no hay módulo, permitimos el pop normal.
      },
      child: Scaffold(
        // Si hay módulo activo, mostramos su página concreta; si no, el IndexedStack.
        body: _activeModule != null
            ? _moduleScreens[_activeModule]!
            : IndexedStack(
                index: _currentIndex,
                children: _screensNormal,
              ),

        bottomNavigationBar: AppNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          isInModule: _activeModule != null,
        ),
      ),
    );
  }
}
