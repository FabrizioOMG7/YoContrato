import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yo_contrato_app/presentation/pages/applicant_search_page.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import '../../domain/entities/event.dart';
import '../widgets/event/event_card.dart';

class RegisterApplicantPage extends StatefulWidget {
  const RegisterApplicantPage({super.key});

  @override
  State<RegisterApplicantPage> createState() => _RegisterApplicantPageState();
}

class _RegisterApplicantPageState extends State<RegisterApplicantPage> {
  String sede = 'Chiclayo'; // Sede inicial, puedes cambiarla según tu lógica
  final List<Event> eventos = [
    Event(
      nombre: 'EVENTO PRUEBA FIN',
      fecha: '01/04/2025 - 30/04/2025',
      sede: 'CHICLAYO',
      areaCargo: 'AUXILIAR DE INVESTIGACION Y DESARROLLO',
      cultivo: 'CULTIVO',
      tipoYoContrato: 'interno',
      requerimientos: 5,
      totalAvance: 2,
    ),
    Event(
      nombre: 'EVENTO PRUEBA FIN 2',
      fecha: '01/05/2025 - 30/05/2025',
      sede: 'TRUJILLO',
      areaCargo: 'GESTIÓN DE CALIDAD',
      cultivo: 'CULTIVO',
      tipoYoContrato: 'interno',
      requerimientos: 3,
      totalAvance: 1,
    ),
    Event(
      nombre: 'EVENTO PRUEBA FIN 3',
      fecha: '01/06/2025 - 30/06/2025',
      sede: 'AREQUIPA',
      areaCargo: 'GESTIÓN DE INVENTARIO',
      cultivo: 'CULTIVO',
      tipoYoContrato: 'interno',
      requerimientos: 2,
      totalAvance: 1,
    ),
    // Puedes agregar más eventos aquí...
  ];

  void _onRegisterPressed(Event evento) {
   Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ApplicantSearchPage(sede: sede),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppTopBar(
        title: 'INSCRIPCIÓN DE POSTULANTES',
        actions: [
          SettingsButton(
            isDarkMode: isDarkMode,
            sede: sede,
            onSedeChanged: (newSede) {
              setState(() {
                sede = newSede;
              });
            },
            onLogout: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      backgroundColor:
          isDarkMode ? const Color(0xFF030F0F) : const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header de sede completamente rediseñado con estética moderna tipo Instagram/Threads
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // Bordes más redondeados tipo iOS
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04), // Sombra muy sutil
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02), // Segunda sombra para profundidad
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24), // Padding generoso tipo Instagram
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Indicador visual minimalista inspirado en Material 3 y apps modernas
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        // Gradiente sofisticado inspirado en Instagram
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF667EEA), // Azul suave
                            Color(0xFF764BA2), // Púrpura elegante
                          ],
                          stops: [0.0, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(16), // Bordes suaves
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.location_on_rounded, // Ícono más moderno y redondeado
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Espaciado generoso
                    
                    // Información de sede con tipografía refinada
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Label superior con estilo moderno
                          Text(
                            'Sede principal',
                            style: GoogleFonts.inter( // Cambiado a Inter por su modernidad
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280), // Gris moderno
                              letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Nombre de sede con tipografía premium
                          Text(
                            sede.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700, // Bold pero no excesivo
                              color: const Color(0xFF111827), // Negro profundo pero no puro
                              letterSpacing: 0.3,
                              height: 1.1, // Line height optimizado
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Elemento decorativo sutil (inspirado en badges de Instagram)
                    /*Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6), // Gris muy claro
                        borderRadius: BorderRadius.circular(20), // Completamente redondeado
                        border: Border.all(
                          color: const Color(0xFFE5E7EB), // Borde sutil
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981), // Verde moderno
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Online',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ],
                      ), 
                    ), */
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24), // Espaciado aumentado para mejor respiración
            
            // Sección de eventos con header mejorado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  // Línea decorativa inspirada en apps modernas
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF667EEA),
                          Color(0xFF764BA2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Título de sección con tipografía premium
                  Text(
                    'Eventos disponibles',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                      letterSpacing: -0.2, // Tracking negativo para títulos
                    ),
                  ),
                  const Spacer(),
                  // Contador de eventos (detalle premium)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${eventos.length}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF667EEA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Lista de eventos con separación optimizada
            Expanded(
              child: ListView.separated(
                itemCount: eventos.length,
                separatorBuilder: (context, index) => const SizedBox(height: 2), // Separación consistente
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return EventCard(
                    event: evento,
                    onRegister: () => _onRegisterPressed(evento),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}