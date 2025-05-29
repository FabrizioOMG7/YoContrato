// lib/presentation/pages/applicant_search_page.dart
// Capa de Presentación - Página de Búsqueda de Postulantes
// Siguiendo principios de Clean Architecture y DDD

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shared/app_topbar.dart';
import '../widgets/shared/app_settings_button.dart';

/// Widget de página para búsqueda de postulantes
/// Responsabilidad: Manejo de la interfaz de usuario para búsqueda de candidatos
/// Principio DDD: Esta clase pertenece al dominio de "Postulante" dentro del contexto de "Reclutamiento"
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

/// Estado privado de la página - Manejo del ciclo de vida y estado local
/// Implementa Single Responsibility Principle separando responsabilidades específicas
class _ApplicantSearchPageState extends State<ApplicantSearchPage> 
    with SingleTickerProviderStateMixin {
  
  // === CONTROLADORES Y ESTADO ===
  /// Controlador para el campo de entrada de DNI
  /// Responsabilidad: Gestión del input del usuario
  final TextEditingController _dniController = TextEditingController();
  
  /// Controlador de animaciones para efectos visuales suaves
  /// Mejora la experiencia del usuario con transiciones profesionales
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  /// Estado de carga para feedback visual al usuario
  /// Principio: Feedback inmediato inspirado en apps como Instagram/WhatsApp
  bool _isSearching = false;
  
  /// Foco del campo de búsqueda para control de teclado
  final FocusNode _searchFocusNode = FocusNode();

  // === CICLO DE VIDA ===
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Inicialización de animaciones siguiendo principios de UX modernos
  /// Inspirado en las transiciones suaves de aplicaciones como Telegram y Discord
  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    // Animación de desvanecimiento para entrada suave
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    
    // Animación de deslizamiento para elementos principales
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    // Iniciar animaciones al cargar la página
    _animationController.forward();
  }

  @override
  void dispose() {
    // Principio de Clean Code: Liberación adecuada de recursos
    _dniController.dispose();
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // === LÓGICA DE NEGOCIO ===
  
  /// Manejo de búsqueda de postulantes
  /// TODO: Integrar con caso de uso de búsqueda (UseCase en Clean Architecture)
  /// Esta función debería delegar a un BLoC o Cubit que maneje la lógica de dominio
  Future<void> _onSearch() async {
    // Validación de entrada - Principio de validación temprana
    if (_dniController.text.trim().isEmpty) {
      _showValidationError('Por favor ingresa un DNI válido');
      return;
    }
    
    if (_dniController.text.trim().length != 8) {
      _showValidationError('El DNI debe tener 8 dígitos');
      return;
    }

    // Feedback visual inmediato - UX Pattern de aplicaciones modernas
    setState(() => _isSearching = true);
    
    // Haptic feedback para mejorar la experiencia táctil (como Instagram)
    HapticFeedback.lightImpact();
    
    try {
      // Simulación de búsqueda - TODO: Reemplazar con caso de uso real
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // TODO: Navegar a página de resultados o mostrar modal de postulante
      if (mounted) {
        _showSuccessMessage('Búsqueda completada');
      }
    } catch (e) {
      // Manejo de errores siguiendo principios de UX
      if (mounted) {
        _showErrorMessage('Error en la búsqueda. Intenta nuevamente.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  // === MÉTODOS DE UI/UX ===
  
  /// Muestra mensaje de error con diseño Material 3
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
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
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
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
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
        backgroundColor: const Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // === WIDGETS DE CONSTRUCCIÓN ===
  
  /// Construye el encabezado de información de sede
  /// Diseño inspirado en LinkedIn y aplicaciones profesionales
  Widget _buildSedeHeader() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAFBFC),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // Indicador visual con animación - Inspirado en Material Design 3
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.business_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              
              // Información de sede con tipografía moderna
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sede de trabajo',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.sede.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        letterSpacing: -0.2,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ACTIVA',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF10B981),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Construye la sección de búsqueda principal
  /// Diseño inspirado en WhatsApp y Telegram para una UX familiar
  Widget _buildSearchSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de sección con línea decorativa
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
                'Buscar postulante',
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
            'Ingresa el DNI del candidato para ver su perfil',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          
          // Campo de búsqueda rediseñado
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
                if (_searchFocusNode.hasFocus)
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icono de búsqueda con animación de color
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
                
                // Campo de texto mejorado
                Expanded(
                  child: TextField(
                    controller: _dniController,
                    focusNode: _searchFocusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: 'Ej: 12345678',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFFB0B4C0),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF111827),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                    onSubmitted: (_) => _onSearch(),
                    onChanged: (value) {
                      // Actualizar UI en tiempo real
                      setState(() {});
                    },
                  ),
                ),
                
                // Botón de búsqueda con estado de carga
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
  /// Diseño inspirado en aplicaciones de mensajería instantánea
  Widget _buildQRSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          const SizedBox(height: 32),
          
          // Separador visual elegante
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
                  'O ESCANEA EL CÓDIGO QR',
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
          
          // Contenedor de QR rediseñado
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
                // QR Code placeholder con diseño mejorado
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
                        'Código QR',
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
                
                // Instrucciones mejoradas
                Text(
                  'Permite que el postulante escanee este código',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
                Text(
                  'para acceder rápidamente al formulario',
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
      
      // Fondo con color suave y profesional
      backgroundColor: const Color(0xFFF8FAFC),
      
      // Cuerpo principal con scroll y padding responsivo
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSedeHeader(),
              _buildSearchSection(),
              _buildQRSection(),
              
              // Espaciado inferior para mejor UX en dispositivos pequeños
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}