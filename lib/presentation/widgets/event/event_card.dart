import 'package:flutter/material.dart';
import '../../../domain/entities/event.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final VoidCallback onRegister;

  const EventCard({super.key, required this.event, required this.onRegister});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: isDarkMode ? const Color(0xFF1B254B) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera principal
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.blueAccent),
                          const SizedBox(width: 4),
                          Text(
                            widget.event.fecha,
                            style: TextStyle(fontSize: 13, color: secondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more, color: Colors.blueAccent),
                  onPressed: () => setState(() => expanded = !expanded),
                  tooltip: expanded ? 'Ocultar detalles' : 'Ver detalles',
                ),
                IconButton(
                  icon: const Icon(Icons.person_add_alt_1, color: Colors.green),
                  onPressed: widget.onRegister,
                  tooltip: 'Registrar postulante',
                ),
              ],
            ),
            // Información expandida
            if (expanded) ...[
              const Divider(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sede y área/cargo
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.blueAccent),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.event.sede,
                            style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.work_outline, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.event.areaCargo,
                            style: TextStyle(color: secondaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Datos en dos columnas
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.grass, size: 16, color: Colors.teal),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Cultivo: ',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.event.cultivo,
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.assignment_turned_in, size: 16, color: Colors.purple),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'T.FIPE: ',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.event.tipoFipe.toUpperCase(),
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.people, size: 16, color: Colors.indigo),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Requerimientos: ',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '${widget.event.requerimientos}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.trending_up, size: 16, color: Colors.redAccent),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Avance: ',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '${widget.event.totalAvance}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}