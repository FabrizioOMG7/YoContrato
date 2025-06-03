// lib/presentation/widgets/applicant/applicant_search_widget.dart
// Widget Reutilizable para Búsqueda de Postulantes
// Refactorizado siguiendo principios SOLID y Clean Architecture

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ===== VALUE OBJECTS (DDD) =====

/// Value Object que encapsula la configuración del widget
/// Principio: Inmutabilidad y encapsulación de datos relacionados
@immutable
class ApplicantSearchConfig {
  final String searchTitle;
  final String searchDescription;
  final String searchPlaceholder;
  final bool showQRSection;
  final String qrTitle;
  final String qrDescription1;
  final String qrDescription2;
  final String separatorText;
  final Future<void> Function(String dni)? onSearch;
  final void Function(String dni)? onSearchSuccess;
  final void Function(String error)? onSearchError;
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

// ===== SERVICES (Principio SRP) =====

/// Servicio responsable únicamente de validar DNIs
/// Principio SRP: Una sola responsabilidad - validación
class DNIValidationService {
  static String? validate(String dni, String? Function(String)? customValidator) {
    final cleanDni = dni.trim();
    
    if (customValidator != null) {
      return customValidator(cleanDni);
    }
    
    if (cleanDni.isEmpty) return 'Por favor ingresa un DNI válido';
    if (cleanDni.length != 8) return 'El DNI debe tener 8 dígitos';
    
    return null;
  }
}

/// Servicio responsable de mostrar notificaciones
/// Principio SRP: Una sola responsabilidad - feedback al usuario
class NotificationService {
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      Icons.error_outline,
      const Color(0xFFEF4444),
    );
  }
  
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      Icons.check_circle_outline,
      const Color(0xFF10B981),
    );
  }
  
  static void showWarning(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      Icons.warning_outlined,
      const Color(0xFFF59E0B),
    );
  }
  
  static void _showSnackBar(BuildContext context, String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

/// Servicio para manejo de animaciones
/// Principio SRP: Responsable únicamente de configurar animaciones
class AnimationService {
  static void setupAnimations(
    TickerProvider vsync,
    AnimationController controller,
    void Function(Animation<double>, Animation<Offset>) onSetup,
  ) {
    final fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );
    
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    ));
    
    onSetup(fadeAnimation, slideAnimation);
    controller.forward();
  }
}

// ===== COMPONENTES UI (Principio SRP) =====

/// Componente responsable únicamente del campo de búsqueda
/// Principio SRP: Una sola responsabilidad - input de búsqueda
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String placeholder;
  final bool isSearching;
  final VoidCallback? onSearch;
  final VoidCallback? onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.placeholder,
    required this.isSearching,
    this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: focusNode.hasFocus ? const Color(0xFF667EEA) : const Color(0xFFE5E7EB),
          width: focusNode.hasFocus ? 2 : 1,
        ),
        boxShadow: [
          if (focusNode.hasFocus)
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
          _buildSearchIcon(),
          _buildTextField(),
          _buildSearchButton(),
        ],
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.search_rounded,
          color: focusNode.hasFocus ? const Color(0xFF667EEA) : const Color(0xFF9CA3AF),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 8,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: placeholder,
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
        onSubmitted: (_) => onSearch?.call(),
        onChanged: (_) => onChanged?.call(),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: isSearching
          ? const Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
                ),
              ),
            )
          : IconButton(
              onPressed: controller.text.length == 8 ? onSearch : null,
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: controller.text.length == 8
                      ? const Color(0xFF667EEA)
                      : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: controller.text.length == 8
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  size: 20,
                ),
              ),
            ),
    );
  }
}

/// Componente responsable únicamente de la sección QR
/// Principio SRP: Una sola responsabilidad - mostrar QR
class QRSection extends StatelessWidget {
  final String qrTitle;
  final String qrDescription1;
  final String qrDescription2;
  final String separatorText;
  final Animation<Offset> slideAnimation;

  const QRSection({
    super.key,
    required this.qrTitle,
    required this.qrDescription1,
    required this.qrDescription2,
    required this.separatorText,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Column(
        children: [
          const SizedBox(height: 32),
          _buildSeparator(),
          const SizedBox(height: 32),
          _buildQRContainer(),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Row(
      children: [
        Expanded(child: _buildSeparatorLine()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            separatorText,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9CA3AF),
              letterSpacing: 0.8,
            ),
          ),
        ),
        Expanded(child: _buildSeparatorLine()),
      ],
    );
  }

  Widget _buildSeparatorLine() {
    return Container(
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
    );
  }

  Widget _buildQRContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
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
          _buildQRCode(),
          const SizedBox(height: 20),
          _buildQRInstructions(),
        ],
      ),
    );
  }

  Widget _buildQRCode() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
            qrTitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRInstructions() {
    return Column(
      children: [
        Text(
          qrDescription1,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
        Text(
          qrDescription2,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ===== WIDGET PRINCIPAL (Principio OCP - Abierto para extensión) =====

/// Widget principal que orquesta todos los componentes
/// Principio DIP: Depende de abstracciones (callbacks) no de implementaciones concretas
class ApplicantSearchWidget extends StatefulWidget {
  final ApplicantSearchConfig config;
  final bool applyPadding;
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

/// Estado del widget principal - Orquestador de componentes
/// Principio ISP: Interfaz segregada - cada componente tiene su responsabilidad específica
class _ApplicantSearchWidgetState extends State<ApplicantSearchWidget>
    with SingleTickerProviderStateMixin {
  
  // Controladores y estado
  final _dniController = TextEditingController();
  final _searchFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isSearching = false;

  ApplicantSearchConfig get config => widget.config;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    AnimationService.setupAnimations(
      this,
      _animationController,
      (fadeAnimation, slideAnimation) {
        _fadeAnimation = fadeAnimation;
        _slideAnimation = slideAnimation;
      },
    );
  }

  @override
  void dispose() {
    _dniController.dispose();
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Método principal de búsqueda - Orquesta la lógica de negocio
  /// Principio DIP: Delega responsabilidades específicas a servicios
  Future<void> _handleSearch() async {
    final dni = _dniController.text.trim();
    
    // Validación usando servicio especializado
    final validationError = DNIValidationService.validate(dni, config.customValidation);
    if (validationError != null) {
      NotificationService.showError(context, validationError);
      return;
    }

    setState(() => _isSearching = true);
    HapticFeedback.lightImpact();
    
    try {
      if (config.onSearch != null) {
        await config.onSearch!(dni);
      } else {
        await Future.delayed(const Duration(milliseconds: 1500));
      }
      
      if (mounted) {
        if (config.onSearchSuccess != null) {
          config.onSearchSuccess!(dni);
        } else {
          NotificationService.showSuccess(context, 'Búsqueda completada');
        }
      }
    } catch (e) {
      if (mounted) {
        if (config.onSearchError != null) {
          config.onSearchError!(e.toString());
        } else {
          NotificationService.showError(context, 'Error en la búsqueda. Intenta nuevamente.');
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.customPadding ?? 
                   (widget.applyPadding 
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                    : EdgeInsets.zero);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            if (config.showQRSection) _buildQRSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 8),
          _buildDescription(),
          const SizedBox(height: 20),
          SearchField(
            controller: _dniController,
            focusNode: _searchFocusNode,
            placeholder: config.searchPlaceholder,
            isSearching: _isSearching,
            onSearch: _handleSearch,
            onChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
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
          config.searchTitle,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      config.searchDescription,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF6B7280),
        height: 1.4,
      ),
    );
  }

  Widget _buildQRSection() {
    return QRSection(
      qrTitle: config.qrTitle,
      qrDescription1: config.qrDescription1,
      qrDescription2: config.qrDescription2,
      separatorText: config.separatorText,
      slideAnimation: _slideAnimation,
    );
  }
}