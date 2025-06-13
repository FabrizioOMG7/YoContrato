import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/event.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final VoidCallback onRegister;
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

  bool get _isExpanded => widget.isExpanded ?? _internalExpanded;

  void _handleToggleExpansion() {
    if (widget.onToggleExpansion != null) {
      widget.onToggleExpansion!();
    } else {
      setState(() => _internalExpanded = !_internalExpanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF111827);
    final secondaryColor = isDarkMode ? Colors.white70 : const Color(0xFF6B7280);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        color: isDarkMode ? const Color(0xFF1B254B) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.nombre,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.event.fecha,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    onPressed: _handleToggleExpansion,
                    tooltip: _isExpanded ? 'Ocultar detalles' : 'Ver detalles',
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_add_alt_1,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    onPressed: widget.onRegister,
                    tooltip: 'Registrar postulante',
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const Divider(height: 16),
                _buildExpandedContent(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : const Color(0xFF4B5563);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRowNoIcon(
          context,
          label: 'SEDE',
          value: widget.event.sede,
          textColor: textColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRowNoIcon(
          context,
          label: 'AREA/CARGO',
          value: widget.event.areaCargo,
          textColor: textColor,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildInfoRowNoIcon(
                context,
                label: 'CULTIVO',
                value: widget.event.cultivo,
                textColor: textColor,
              ),
            ),
            Expanded(
              child: _buildInfoRowNoIcon(
                context,
                label: 'T.YOCONTRATO',
                value: widget.event.tipoYoContrato.toUpperCase(),
                textColor: textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildInfoRowNoIcon(
                context,
                label: 'REQUERIMIENTOS',
                value: widget.event.requerimientos.toString(),
                textColor: textColor,
              ),
            ),
            Expanded(
              child: _buildInfoRowNoIcon(
                context,
                label: 'AVANCE',
                value: widget.event.totalAvance.toString(),
                textColor: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRowNoIcon(
    BuildContext context, {
    required String label,
    required String value,
    required Color textColor,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}