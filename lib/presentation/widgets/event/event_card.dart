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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
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
                      Text(widget.event.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('FECHA: ${widget.event.fecha}', style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () => setState(() => expanded = !expanded),
                ),
                IconButton(
                  icon: const Icon(Icons.person_add_alt_1),
                  onPressed: widget.onRegister,
                ),
              ],
            ),
            // Información expandida
            if (expanded) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SEDE: ${widget.event.sede}'),
                    Text('AREA/CARGO: ${widget.event.areaCargo}'),
                    Text('CULTIVO: ${widget.event.cultivo}'),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        Text('T.FIPE: ${widget.event.tipoFipe}'),
                        Text('REQUERIMIENTOS: ${widget.event.requerimientos}'),
                        Text('TOTAL AVANCE: ${widget.event.totalAvance}'),
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