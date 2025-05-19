import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/event.dart';
import '../widgets/event/event_card.dart';

class RegisterApplicantPage extends StatefulWidget {
  const RegisterApplicantPage({super.key});

  @override
  State<RegisterApplicantPage> createState() => _RegisterApplicantPageState();
}

class _RegisterApplicantPageState extends State<RegisterApplicantPage> {
  final List<Event> eventos = [
    Event(
      nombre: 'EVENTO PRUEBA FIN',
      fecha: '01/04/2025 - 30/04/2025',
      sede: 'C5 NORTE',
      areaCargo: 'AUXILIAR DE INVESTIGACION Y DESARROLLO',
      cultivo: 'CULTIVO',
      tipoFipe: 'interno',
      requerimientos: 5,
      totalAvance: 2,
    ),
    // Puedes agregar más eventos aquí...
  ];

  void _onRegisterPressed(Event evento) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registrar postulante para "${evento.nombre}"')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de postulantes',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 1.1,
          ),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF161F49) : Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Acción de configuración
            },
          ),
        ],
      ),
      backgroundColor: isDarkMode ? const Color(0xFF030F0F) : const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera de sede
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF161F49) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'C5 NORTE',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Texto de eventos disponibles
            Text(
              'EVENTOS DISPONIBLES',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            // Lista de eventos
            Expanded(
              child: ListView.builder(
                itemCount: eventos.length,
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