import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yo_contrato_app/presentation/pages/applicant_search_page.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import '../../domain/entities/event.dart';
import '../widgets/event/event_card.dart';
import '../widgets/shared/info_card.dart';

class RegisterApplicantPage extends StatefulWidget {
  const RegisterApplicantPage({super.key});

  @override
  State<RegisterApplicantPage> createState() => _RegisterApplicantPageState();
}

class _RegisterApplicantPageState extends State<RegisterApplicantPage> {
  String sede = 'Chiclayo';
  
  // Estado para controlar la expansión masiva
  bool _areAllExpanded = false;
  
  // GlobalKey para comunicarse con las EventCards
  final GlobalKey<_EventListState> _eventListKey = GlobalKey<_EventListState>();
  
  final List<Event> eventos = [
    Event(
      nombre: 'EVENTO PRUEBA FIN',
      fecha: '01/04/2025 - 30/04/2025',
      sede: 'CHICLAYO',
      areaCargo: 'AUXILIAR DE INVESTIGACION Y DESARROLLO',
      cultivo: 'CULTIVO',
      tipoYoContrato: 'INTERNO',
      requerimientos: 5,
      totalAvance: 2,
    ),
    Event(
      nombre: 'EVENTO PRUEBA FIN 2',
      fecha: '01/05/2025 - 30/05/2025',
      sede: 'TRUJILLO',
      areaCargo: 'GESTIÓN DE CALIDAD',
      cultivo: 'CULTIVO',
      tipoYoContrato: 'INTERNO',
      requerimientos: 3,
      totalAvance: 1,
    ),
    Event(
      nombre: 'EVENTO PRUEBA FIN 3',
      fecha: '01/06/2025 - 30/06/2025',
      sede: 'AREQUIPA',
      areaCargo: 'GESTIÓN DE INVENTARIO',
      cultivo: 'CULTIVO',
      tipoYoContrato: 'INTERNO',
      requerimientos: 2,
      totalAvance: 1,
    ),
  ];

  void _onRegisterPressed(Event evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicantSearchPage(sede: sede),
      ),
    );
  }

  /// Alterna el estado de expansión de todas las cards
  void _toggleAllEvents() {
    setState(() {
      _areAllExpanded = !_areAllExpanded;
    });
    _eventListKey.currentState?.toggleAllEvents(_areAllExpanded);
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
            // InfoCard reutilizable para sede principal
            InfoCard(
              icon: const Icon(Icons.location_on_rounded, color: Colors.white, size: 28),
              items: [
                InfoCardItem(label: 'Sede principal', value: sede.toUpperCase()),
              ],
            ),
            const SizedBox(height: 24),

            // Sección de eventos con header mejorado y control masivo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  // Línea decorativa
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
                  // Título de sección
                  Text(
                    'Eventos disponibles',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Botón de expansión/compresión masiva
                  _MassToggleButton(
                    isExpanded: _areAllExpanded,
                    onToggle: _toggleAllEvents,
                    eventCount: eventos.length,
                  ),
                  
                  const Spacer(),
                  // Contador de eventos
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

            // Lista de eventos
            Expanded(
              child: EventList(
                key: _eventListKey,
                eventos: eventos,
                onRegisterPressed: _onRegisterPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget especializado para el botón de expansión/compresión masiva
class _MassToggleButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final int eventCount;

  const _MassToggleButton({
    required this.isExpanded,
    required this.onToggle,
    required this.eventCount,
  });

  @override
  Widget build(BuildContext context) {
    // Solo mostrar el botón si hay eventos para expandir
    if (eventCount == 0) return const SizedBox.shrink();

    return Tooltip(
      message: isExpanded ? 'Comprimir todos' : 'Expandir todos',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF667EEA).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.expand_more,
                    size: 16,
                    color: const Color(0xFF667EEA),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isExpanded ? 'Comprimir' : 'Expandir',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF667EEA),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget separado para manejar la lista de eventos y su estado
class EventList extends StatefulWidget {
  final List<Event> eventos;
  final Function(Event) onRegisterPressed;

  const EventList({
    super.key,
    required this.eventos,
    required this.onRegisterPressed,
  });

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  // Mapa para rastrear el estado de expansión de cada evento
  final Map<int, bool> _expansionStates = {};

  @override
  void initState() {
    super.initState();
    // Inicializar todos los eventos como comprimidos
    for (int i = 0; i < widget.eventos.length; i++) {
      _expansionStates[i] = false;
    }
  }

  /// Método para alternar el estado de todos los eventos
  void toggleAllEvents(bool shouldExpand) {
    setState(() {
      for (int i = 0; i < widget.eventos.length; i++) {
        _expansionStates[i] = shouldExpand;
      } 
    });
  }

  /// Método para alternar un evento individual
  void _toggleSingleEvent(int index) {
    setState(() {
      _expansionStates[index] = !(_expansionStates[index] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.eventos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 2),
      itemBuilder: (context, index) {
        final evento = widget.eventos[index];
        final isExpanded = _expansionStates[index] ?? false;

        return EventCard(
          event: evento,
          onRegister: () => widget.onRegisterPressed(evento),
          isExpanded: isExpanded,
          onToggleExpansion: () => _toggleSingleEvent(index),
        );
      },
    );
  }
}

/// Extensión para EventCard que soporte expansión controlada
/// (Esto requeriría modificar el EventCard existente para aceptar estos parámetros)
extension EventCardExpansion on EventCard {
  // Esta extensión documenta los parámetros que EventCard necesitaría:
  // - isExpanded: bool - estado de expansión actual
  // - onToggleExpansion: VoidCallback - callback para alternar expansión
  // - onRegister: VoidCallback - callback existente para registro
}