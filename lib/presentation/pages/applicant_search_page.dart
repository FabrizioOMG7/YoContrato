// lib/presentation/pages/applicant_search_page.dart
// Página de Búsqueda de Postulantes - REFACTORIZADA
// Siguiendo Clean Architecture y eliminando redundancias

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/info_Card.dart';
import '../widgets/shared/app_topbar.dart';
import '../widgets/shared/app_settings_button.dart';
import '../widgets/applicant/applicant_search_widget.dart';

/// Página especializada para búsqueda de postulantes
class ApplicantSearchPage extends StatefulWidget {
  /// Value Object del dominio - Representa la sede de trabajo
  final String sede;
  
  const ApplicantSearchPage({
    super.key, 
    required this.sede,
  });

  @override
  State<ApplicantSearchPage> createState() => _ApplicantSearchPageState();
}

/// Solo maneja aspectos específicos de ESTA página
class _ApplicantSearchPageState extends State<ApplicantSearchPage> {

  // ===== LÓGICA DE NEGOCIO ESPECÍFICA DEL CONTEXTO =====
  
  /// **Caso de Uso**: Búsqueda de postulante en contexto específico
  /// 
  /// Esta función representa la integración con el dominio:
  /// - En implementación real, aquí se llamaría a un UseCase del dominio
  /// - El UseCase coordinaría con repositorios y servicios
  /// - Se aplicarían reglas de negocio específicas del contexto
  Future<void> _searchApplicantInContext(String dni) async {
    // 
    // Ejemplo de integración correcta:
    // final result = await _searchApplicantUseCase.execute(
    //   SearchApplicantRequest(
    //     dni: dni,
    //     sede: widget.sede,
    //     context: SearchContext.preApplication, // Contexto específico
    //   )
    // );
    // 
    // if (result.isFailure) {
    //   throw DomainException(result.error);
    // }
    
    // SIMULACIÓN TEMPORAL - Reemplazar con integración real
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Simulación de reglas de negocio específicas del contexto
    if (dni == '12345678') {
      throw Exception('Postulante no encontrado en la sede ${widget.sede}');
    }
    
    if (dni == '87654321') {
      throw Exception('Postulante ya tiene proceso activo en esta sede');
    }
  }

  /// **Manejo de Éxito**: Navegación específica del contexto
  /// 
  /// Esta función maneja QUÉ hacer después de una búsqueda exitosa
  /// En este contexto específico: navegar al formulario de postulación
  void _onApplicantFound(String dni) {
    // TODO: Integrar con sistema de navegación del dominio
    // Navigator.pushNamed(
    //   context, 
    //   '/applicant-form',
    //   arguments: ApplicantFormArguments(
    //     dni: dni,
    //     sede: widget.sede,
    //     context: FormContext.newApplication,
    //   ),
    // );
    
    // Feedback temporal mientras se implementa la navegación real
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.person_search, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Postulante encontrado. Redirigiendo al formulario...'),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// **Validaciones del Contexto**: Reglas específicas del dominio
  /// 
  /// Aquí se implementan validaciones que son específicas del contexto
  /// de búsqueda para postulación (no validaciones generales de DNI)
  String? _validateForApplicationContext(String dni) {
    // Las validaciones básicas de formato las maneja el widget reutilizable
    // Aquí solo validaciones específicas del contexto de postulación
    
    // Ejemplo: Lista negra específica para postulaciones
    final blacklistedForApplications = ['00000000', '11111111', '99999999'];
    if (blacklistedForApplications.contains(dni)) {
      return 'Este DNI no está habilitado para postulaciones';
    }
    
    // Ejemplo: Validación específica por sede
    if (widget.sede == 'LIMA' && dni.startsWith('0')) {
      return 'DNIs que inician con 0 no son válidos para sede Lima';
    }
    
    return null; // Validación exitosa
  }

  // ===== CONSTRUCCIÓN DE UI ESPECÍFICA =====
  
  /// Construye el header informativo específico de esta página
  /// Este es el único elemento visual que NO está en el widget reutilizable
  Widget _buildPageHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InfoCard(
        icon: const Icon(
          Icons.location_on_rounded, 
          color: Colors.white, 
          size: 28
        ),
        items: [
          InfoCardItem(
            label: 'Sede de postulación', 
            value: widget.sede.toUpperCase()
          ),
        ],
      ),
    );
  }

  /// **Configuración del Widget Reutilizable**
  /// 
  /// Este es el patrón clave: la página solo CONFIGURA el widget,
  /// no duplica su funcionalidad
  ApplicantSearchConfig _createSearchConfiguration() {
    return ApplicantSearchConfig(
      // Textos específicos del contexto de postulación
      searchTitle: 'Buscar postulante',
      searchDescription: 'Ingresa el DNI del candidato para iniciar el proceso de postulación',
      searchPlaceholder: 'Ej: 12345678',
      
      // Configuración específica para el contexto de postulación
      showQRSection: true,
      qrTitle: 'Código QR para Postulantes',
      qrDescription1: 'El postulante puede escanear este código',
      qrDescription2: 'para acceder directamente al formulario',
      separatorText: 'O ESCANEA EL CÓDIGO QR',
      
      // **INYECCIÓN DE DEPENDENCIAS** (Principio DIP):
      // La página inyecta sus comportamientos específicos al widget
      onSearch: _searchApplicantInContext,        // Lógica específica
      onSearchSuccess: _onApplicantFound,         // Navegación específica  
      customValidation: _validateForApplicationContext, // Validaciones específicas
      
      // El widget maneja sus propios errores internos,
      // no necesitamos inyectar onSearchError aquí
    );
  }

  // ===== BUILD PRINCIPAL - SIMPLIFICADO =====
  
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // AppBar específica del contexto (esto SÍ varía entre módulos)
      appBar: AppTopBar(
        title: 'POSTULANTES',
        actions: [
          SettingsButton(
            isDarkMode: isDarkMode,
            sede: widget.sede,
            onSedeChanged: (_) {
              // TODO: Implementar cambio de sede
            },
            onLogout: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      
      backgroundColor: const Color(0xFFF8FAFC),
      
      // **CUERPO SIMPLIFICADO**:
      // Solo elementos específicos + widget reutilizable configurado
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header específico de esta página (varía entre contextos)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: _buildPageHeader(),
            ),
            
            // **WIDGET REUTILIZABLE CON CONFIGURACIÓN ESPECÍFICA**
            // Todo el comportamiento complejo está encapsulado aquí
            ApplicantSearchWidget(
              config: _createSearchConfiguration(),
              applyPadding: true,
            ),
          ],
        ),
      ),
    );
  }
}

// ===== PATRÓN PARA OTROS MÓDULOS =====

/// **EJEMPLO**: Cómo sería para el módulo de "Gestión de Contratos"
/// 
/// class ContractManagementSearchPage extends StatefulWidget {
///   final String sede;
///   
///   // Mismo patrón, diferente configuración:
///   ApplicantSearchConfig _createConfig() {
///     return ApplicantSearchConfig(
///       searchTitle: 'Buscar empleado contratado',
///       searchDescription: 'Ingresa el DNI para gestionar su contrato',
///       onSearch: _searchEmployeeForContract,     // Diferente lógica
///       onSearchSuccess: _navigateToContractForm, // Diferente navegación
///       customValidation: _validateForContracts,  // Diferentes reglas
///       showQRSection: false, // Sin QR para contratos
///     );
///   }
/// }