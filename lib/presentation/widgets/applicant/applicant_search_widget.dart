// lib/presentation/widgets/applicant/applicant_search_widget.dart
// Widget Reutilizable para Búsqueda de Postulantes
// Siguiendo principios de Clean Architecture y DDD

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuración para personalizar el comportamiento del widget de búsqueda
/// Principio de Composición: Permite configurar el widget sin modificar su implementación
/// Esta clase actúa como un Value Object del dominio, encapsulando la configuración
class ApplicantSearchConfig {
  /// Título mostrado en la sección de búsqueda
  final String searchTitle;
  
  /// Descripción mostrada debajo del título
  final String searchDescription;
  
  /// Placeholder del campo de entrada
  final String searchPlaceholder;
  
  /// Si debe mostrar la sección de código QR
  final bool showQRSection;
  
  /// Título personalizado para la sección QR
  final String qrTitle;
  
  /// Primera línea de descripción del QR
  final String qrDescription1;
  
  /// Segunda línea de descripción del QR
  final String qrDescription2;
  
  /// Mensaje de separador (ej: "O ESCANEA EL CÓDIGO QR")
  final String separatorText;
  
  /// Callback personalizado para manejar la búsqueda
  /// Este callback permite la inyección de dependencias desde la capa de aplicación
  final Future<void> Function(String dni)? onSearch;
  
  /// Callback para manejar el éxito de la búsqueda
  final void Function(String dni)? onSearchSuccess;
  
  /// Callback para manejar errores de búsqueda
  final void Function(String error)? onSearchError;
  
  /// Validación personalizada del DNI
  /// Permite diferentes reglas de validación según el contexto de uso
  final String? Function(String dni)? customValidation;

  const ApplicantSearchConfig({
    this.searchTitle = 'Buscar postulante',
    this.searchDescription = 'Ingresa el DNI del candidato para ver su perfil',
    this.searchPlaceholder = 'Ej: 12345678',
    this.showQRSection = true,
    this.qrTitle = 'Código QR',
    this.qrDescription1 = 'Permite que el postulante escanee este código',
    this.qrDescription2 = 'para acceder rápidamente al formulario',
    this.separatorText = 'O ESCANEA EL CÓDIGO QR',
    this.onSearch,
    this.onSearchSuccess,
    this.onSearchError,
    this.customValidation,
  });
}

/// Widget reutilizable para búsqueda de postulantes
/// Responsabilidad: Proporcionar una interfaz de búsqueda configurable y reutilizable
/// Principio de Single Responsibility: Se enfoca únicamente en la funcionalidad de búsqueda
/// Este widget sigue el patrón de Presentational Component (UI puro)
class ApplicantSearchWidget extends StatefulWidget {
  /// Configuración del widget - Inyección de dependencias por composición
  final ApplicantSearchConfig config;
  
  /// Si debe aplicar padding interno (útil cuando se usa dentro de páginas)
  final bool applyPadding;
  
  /// Padding personalizado para diferentes contextos de uso
  final EdgeInsets? customPadding;

  const ApplicantSearchWidget({
    super.key,
    this.config = const ApplicantSearchConfig(),
    this.applyPadding = true,
    this.customPadding,
  });

  @override
  State<ApplicantSearchWidget> createState() => _ApplicantSearchWidgetState();
}

/// Estado del widget de búsqueda
/// Maneja toda la lógica interna del componente siguiendo el principio de encapsulación
/// Esta clase es responsable únicamente del estado local y la lógica de presentación
class _ApplicantSearchWidgetState extends State<ApplicantSearchWidget>
    with SingleTickerProviderStateMixin {
  
  // === CONTROLADORES Y ESTADO LOCAL ===
  
  /// Controlador para el campo de entrada de DNI
  /// Responsabilidad: Gestión del input del usuario
  final TextEditingController _dniController = TextEditingController();
  
  /// Controlador de animaciones para efectos visuales suaves
  /// Mejora la experiencia de usuario con transiciones fluidas
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  /// Estado de carga para feedback visual al usuario
  /// Principio de Responsive Design: Proporcionar feedback inmediato
  bool _isSearching = false;
  
  /// Foco del campo de búsqueda para control de teclado
  /// Gestión del estado de focus para mejorar la accesibilidad
  final FocusNode _searchFocusNode = FocusNode();

  // === GETTERS PARA CONFIGURACIÓN ===
  
  /// Acceso rápido a la configuración del widget
  /// Principio DRY: Evita repetir widget.config en todo el código
  ApplicantSearchConfig get config => widget.config;

  // === CICLO DE VIDA DEL WIDGET ===
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Inicialización de animaciones 
  /// Separada para mejorar la legibilidad y mantenimiento del código
  /// Principio de Single Responsibility: Una función, una responsabilidad
  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    // Animación de desvanecimiento para entrada suave de elementos
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    
    // Animación de deslizamiento para elementos principales
    // Crea una sensación de profundidad y entrada natural
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    // Iniciar animaciones al cargar el widget
    _animationController.forward();
  }

  @override
  void dispose() {
    // Principio de Clean Code: Liberación adecuada de recursos para evitar memory leaks
    _dniController.dispose();
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // === LÓGICA DE NEGOCIO Y VALIDACIÓN ===
  
  /// Validación del DNI ingresado
  /// Permite validación personalizada a través de la configuración
  /// Principio de Strategy Pattern: Permite diferentes estrategias de validación
  String? _validateDNI(String dni) {
    final cleanDni = dni.trim();
    
    // Usar validación personalizada si existe (Strategy Pattern)
    if (config.customValidation != null) {
      return config.customValidation!(cleanDni);
    }
    
    // Validación por defecto siguiendo reglas de negocio del dominio
    if (cleanDni.isEmpty) {
      return 'Por favor ingresa un DNI válido';
    }
    
    if (cleanDni.length != 8) {
      return 'El DNI debe tener 8 dígitos';
    }
    
    return null; // No hay errores de validación
  }
  
  /// Manejo de búsqueda de postulantes
  /// Utiliza callbacks de configuración para delegar la lógica específica
  /// Principio de Dependency Injection: La lógica específica se inyecta desde fuera
  Future<void> _onSearch() async {
    final dni = _dniController.text.trim();
    
    // Validación de entrada - Fail Fast Pattern
    final validationError = _validateDNI(dni);
    if (validationError != null) {
      _showValidationError(validationError);
      return;
    }

    // Feedback visual inmediato - UX Pattern para aplicaciones modernas
    setState(() => _isSearching = true);
    
    // Haptic feedback para mejorar la experiencia táctil (como apps nativas)
    HapticFeedback.lightImpact();
    
    try {
      // Ejecutar búsqueda personalizada si existe
      // Si no hay callback personalizado, ejecuta comportamiento por defecto
      if (config.onSearch != null) {
        await config.onSearch!(dni);
      } else {
        // Búsqueda por defecto (simulación para desarrollo)
        await Future.delayed(const Duration(milliseconds: 1500));
      }
      
      // Callback de éxito - Permite manejar el resultado desde el contexto padre
      if (mounted) {
        if (config.onSearchSuccess != null) {
          config.onSearchSuccess!(dni);
        } else {
          _showSuccessMessage('Búsqueda completada');
        }
      }
    } catch (e) {
      // Manejo de errores siguiendo principios de UX
      // El error se propaga al contexto padre o se maneja localmente
      if (mounted) {
        if (config.onSearchError != null) {
          config.onSearchError!(e.toString());
        } else {
          _showErrorMessage('Error en la búsqueda. Intenta nuevamente.');
        }
      }
    } finally {
      // Limpieza del estado de carga - Pattern Finally para cleanup
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  // === MÉTODOS DE UI/UX Y FEEDBACK AL USUARIO ===
  
  /// Muestra mensaje de error de validación
  /// Centraliza el manejo de errores de validación para consistencia
  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFEF4444), // Error red color
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  /// Muestra mensaje de éxito
  /// Proporciona feedback positivo al usuario tras una acción exitosa
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF10B981), // Success green color
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  /// Muestra mensaje de error general
  /// Maneja errores de sistema o red de manera user-friendly
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_outlined, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFF59E0B), // Warning orange color
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // === WIDGETS DE CONSTRUCCIÓN DE LA UI ===
  
  /// Construye la sección de búsqueda principal
  /// Utiliza la configuración para personalizar textos y comportamiento
  /// Este método replica exactamente el diseño de la página original
  Widget _buildSearchSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de sección con línea decorativa - Mantiene el diseño original
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                config.searchTitle, // Configurable desde el exterior
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            config.searchDescription, // Descripción configurable
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          
          // Campo de búsqueda - Replica exacta del diseño original
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _searchFocusNode.hasFocus 
                    ? const Color(0xFF667EEA) 
                    : const Color(0xFFE5E7EB),
                width: _searchFocusNode.hasFocus ? 2 : 1,
              ),
              boxShadow: [
                // Sombra cuando está enfocado - Mejora visual de estado activo
                if (_searchFocusNode.hasFocus)
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                // Sombra base para profundidad
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icono de búsqueda con animación de color - UX mejorada
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.search_rounded,
                      color: _searchFocusNode.hasFocus 
                          ? const Color(0xFF667EEA) 
                          : const Color(0xFF9CA3AF),
                      size: 24,
                    ),
                  ),
                ),
                
                // Campo de texto principal - Configuración idéntica al original
                Expanded(
                  child: TextField(
                    controller: _dniController,
                    focusNode: _searchFocusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Solo números
                    ],
                    decoration: InputDecoration(
                      hintText: config.searchPlaceholder, // Placeholder configurable
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFFB0B4C0),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      counterText: '', // Oculta contador de caracteres
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF111827),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.2, // Espaciado para números del DNI
                    ),
                    onSubmitted: (_) => _onSearch(), // Búsqueda con Enter
                    onChanged: (value) {
                      // Actualizar UI en tiempo real para el botón
                      setState(() {});
                    },
                  ),
                ),
                
                // Botón de búsqueda con estado de carga - Igual al diseño original
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _isSearching
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF667EEA),
                              ),
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: _dniController.text.length == 8 ? _onSearch : null,
                          icon: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _dniController.text.length == 8
                                  ? const Color(0xFF667EEA)
                                  : const Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: _dniController.text.length == 8
                                  ? Colors.white
                                  : const Color(0xFF9CA3AF),
                              size: 20,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Construye la sección del código QR
  /// Solo se muestra si está habilitada en la configuración
  /// Replica exactamente el diseño y funcionalidad de la página original
  Widget _buildQRSection() {
    if (!config.showQRSection) {
      return const SizedBox.shrink(); // No renderiza nada si está deshabilitado
    }
    
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          const SizedBox(height: 32),
          
          // Separador visual elegante - Idéntico al original
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFFE5E7EB).withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  config.separatorText, // Texto configurable
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9CA3AF),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFFE5E7EB).withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Contenedor de QR - Diseño exacto del original
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                // QR Code placeholder con diseño idéntico
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_2_rounded,
                        size: 64,
                        color: const Color(0xFF667EEA).withOpacity(0.7),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        config.qrTitle, // Título configurable
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Instrucciones configurables - Separadas en dos líneas
                Text(
                  config.qrDescription1,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
                Text(
                  config.qrDescription2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // === MÉTODO BUILD PRINCIPAL ===
  
  @override
  Widget build(BuildContext context) {
    // Manejo de padding configurable para diferentes contextos de uso
    final padding = widget.customPadding ?? 
                   (widget.applyPadding 
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                    : EdgeInsets.zero);

    return GestureDetector(
      // Ocultar teclado al tocar fuera del campo - UX mejorada
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            _buildQRSection(),
            
            // Espaciado inferior para mejor UX en dispositivos pequeños
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}