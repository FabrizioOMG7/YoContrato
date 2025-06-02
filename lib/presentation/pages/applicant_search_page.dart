// lib/presentation/pages/applicant_search_page.dart
// Capa de Presentación - Página de Búsqueda de Postulantes
// Siguiendo principios de Clean Architecture y DDD
// REFACTORIZADA para usar ApplicantSearchWidget reutilizable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/info_Card.dart';
import '../widgets/shared/app_topbar.dart';
import '../widgets/shared/app_settings_button.dart';
import '../widgets/applicant/applicant_search_widget.dart';

/// Widget de página para búsqueda de postulantes
/// Responsabilidad: Orquestar la UI y coordinar con casos de uso del dominio
/// Principio DDD: Esta clase pertenece al contexto acotado de "Reclutamiento"
/// Clean Architecture: Capa de Presentación que delega lógica específica al widget reutilizable
class ApplicantSearchPage extends StatefulWidget {
  /// Sede donde se realizará la búsqueda - Value Object del dominio
  final String sede;
  
  const ApplicantSearchPage({
    super.key, 
    required this.sede,
  });

  @override
  State<ApplicantSearchPage> createState() => _ApplicantSearchPageState();
}

/// Estado de la página - Solo maneja aspectos específicos de esta página
/// Principio Single Responsibility: Se enfoca en la coordinación de la página completa
class _ApplicantSearchPageState extends State<ApplicantSearchPage> 
    with SingleTickerProviderStateMixin {
  
  // === ANIMACIONES ESPECÍFICAS DE LA PÁGINA ===
  /// Controlador de animaciones para elementos específicos de la página (header)
  /// El widget reutilizable maneja sus propias animaciones
  late AnimationController _pageAnimationController;
  late Animation<Offset> _headerSlideAnimation;

  // === CICLO DE VIDA ===
  
  @override
  void initState() {
    super.initState();
    _initializePageAnimations();
  }

  /// Inicialización de animaciones específicas de la página
  /// Separadas de las animaciones del widget reutilizable
  void _initializePageAnimations() {
    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _pageAnimationController,
      curve: Curves.easeOutBack,
    ));
    
    _pageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  // === LÓGICA DE NEGOCIO ESPECÍFICA DE LA PÁGINA ===
  
  /// Manejo de búsqueda exitosa - Callback del widget reutilizable
  /// TODO: Integrar con caso de uso de navegación (UseCase en Clean Architecture)
  /// Esta función debería delegar a un BLoC que maneje la navegación del dominio
  void _onSearchSuccess(String dni) {
    // TODO: Navegar a página de detalles del postulante
    // Navigator.pushNamed(context, '/applicant-details', arguments: dni);
    
    // Por ahora mostramos mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text('Postulante encontrado: DNI $dni')),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Manejo de errores de búsqueda - Callback del widget reutilizable
  /// Centraliza el manejo de errores específicos del contexto de la página
  void _onSearchError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_outlined, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text('Error: $error')),
          ],
        ),
        backgroundColor: const Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Lógica de búsqueda personalizada - Inyectada al widget reutilizable
  /// TODO: Aquí se integraría con el caso de uso real de búsqueda
  /// Principio Dependency Injection: La lógica específica se inyecta desde esta capa
  Future<void> _performSearch(String dni) async {
    // TODO: Integrar con UseCase de búsqueda de postulantes
    // final result = await searchApplicantUseCase.execute(dni, widget.sede);
    
    // Simulación temporal - Reemplazar con lógica real
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Simulación de diferentes casos
    if (dni == '12345678') {
      throw Exception('Postulante no encontrado en la sede ${widget.sede}');
    }
    
    // Si llega aquí, la búsqueda fue exitosa
    // El callback onSearchSuccess se ejecutará automáticamente
  }

  /// Validación personalizada del DNI específica para esta página
  /// Permite agregar reglas de negocio específicas del contexto
  String? _customDNIValidation(String dni) {
    // Validación básica ya está en el widget reutilizable
    // Aquí agregamos validaciones específicas del contexto de la página
    
    // Ejemplo: Validar que el DNI no esté en una lista negra
    final blacklistedDNIs = ['00000000', '11111111', '99999999'];
    if (blacklistedDNIs.contains(dni)) {
      return 'Este DNI no está permitido para postulaciones';
    }
    
    return null; // Validación exitosa
  }

  // === WIDGETS DE CONSTRUCCIÓN ===
  
  /// Construye el encabezado de información de sede
  /// Elemento específico de esta página que no forma parte del widget reutilizable
  Widget _buildSedeHeader() {
    return SlideTransition(
      position: _headerSlideAnimation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: InfoCard(
          icon: const Icon(Icons.location_on_rounded, color: Colors.white, size: 28),
          items: [
            InfoCardItem(
              label: 'Sede principal', 
              value: widget.sede.toUpperCase()
            ),
          ],
        ),
      ),
    );
  }

  /// Crea la configuración para el widget reutilizable
  /// Principio de Composición: Configura el comportamiento sin modificar la implementación
  /// Inyección de Dependencias: Proporciona callbacks específicos del contexto
  ApplicantSearchConfig _createSearchConfig() {
    return ApplicantSearchConfig(
      // Textos personalizados para el contexto de la página
      searchTitle: 'Buscar postulante',
      searchDescription: 'Ingresa el DNI del candidato para ver su perfil',
      searchPlaceholder: 'Ej: 12345678',
      
      // Configuración de la sección QR
      showQRSection: true,
      qrTitle: 'Código QR',
      qrDescription1: 'Permite que el postulante escanee este código',
      qrDescription2: 'para acceder rápidamente al formulario',
      separatorText: 'O ESCANEA EL CÓDIGO QR',
      
      // Inyección de lógica específica de esta página
      onSearch: _performSearch,           // Lógica de búsqueda personalizada
      onSearchSuccess: _onSearchSuccess,  // Manejo de éxito específico
      onSearchError: _onSearchError,      // Manejo de errores específico
      customValidation: _customDNIValidation, // Validación específica del contexto
    );
  }

  // === MÉTODO BUILD PRINCIPAL ===
  
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // AppBar personalizada manteniendo consistencia con el diseño existente
      appBar: AppTopBar(
        title: 'POSTULANTES',
        actions: [
          SettingsButton(
            isDarkMode: isDarkMode,
            sede: widget.sede,
            onSedeChanged: (_) {}, // TODO: Implementar cambio de sede
            onLogout: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      
      // Fondo con color suave 
      backgroundColor: const Color(0xFFF8FAFC),
      
      // Cuerpo principal usando el widget reutilizable
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header específico de la página (no reutilizable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: _buildSedeHeader(),
            ),
            
            // Widget reutilizable con configuración específica
            // Principio de Composición: Reutilización sin duplicación de código
            // Clean Architecture: Separación clara entre lógica de página y widget reutilizable
            ApplicantSearchWidget(
              config: _createSearchConfig(),
              applyPadding: true, // Usa el padding por defecto del widget
            ),
          ],
        ),
      ),
    );
  }
}