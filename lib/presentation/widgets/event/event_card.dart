import 'package:flutter/material.dart';
import '../../../domain/entities/event.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final VoidCallback onRegister;
  
  // Nuevos parámetros opcionales para control externo
  final bool? isExpanded;
  final VoidCallback? onToggleExpansion;

  const EventCard({
    super.key, 
    required this.event, 
    required this.onRegister,
    this.isExpanded,
    this.onToggleExpansion,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _internalExpanded = false;

  /// Determina si la card está expandida basándose en control externo o interno
  bool get _isExpanded {
    return widget.isExpanded ?? _internalExpanded;
  }

  /// Maneja el toggle de expansión considerando control externo o interno
  void _handleToggleExpansion() {
    if (widget.onToggleExpansion != null) {
      // Si hay control externo, usar ese callback
      widget.onToggleExpansion!();
    } else {
      // Si no hay control externo, usar estado interno
      setState(() {
        _internalExpanded = !_internalExpanded;
      });
    }
  }

  /// Detecta cambios en el control externo y sincroniza si es necesario
  @override
  void didUpdateWidget(EventCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Si cambió de control externo a interno o viceversa, resetear estado interno
    if ((oldWidget.isExpanded == null) != (widget.isExpanded == null)) {
      _internalExpanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryColor = isDarkMode ? Colors.white70 : Colors.black54;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
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
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.event.fecha,
                              style: TextStyle(
                                fontSize: 13,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Botón de expansión con animación mejorada
                  IconButton(
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more, // Usar siempre expand_more para consistencia
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: _handleToggleExpansion,
                    tooltip: _isExpanded ? 'Ocultar detalles' : 'Ver detalles',
                  ),
                  // Botón de registro
                  IconButton(
                    icon: Icon(
                      Icons.person_add_alt_1,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: widget.onRegister,
                    tooltip: 'Registrar postulante',
                  ),
                ],
              ),
              
              // Información expandida con animación suave
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Column(
                  children: [
                    const Divider(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sede
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.event.sede,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Área/Cargo
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'AREA/CARGO: ${widget.event.areaCargo}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Cultivo: ${widget.event.cultivo}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'T.YoContrato: ${widget.event.tipoYoContrato.toUpperCase()}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Requerimientos: ${widget.event.requerimientos}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Avance: ${widget.event.totalAvance}',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                crossFadeState: _isExpanded 
                    ? CrossFadeState.showSecond 
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}