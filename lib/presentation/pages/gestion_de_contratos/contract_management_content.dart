import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/contract/contract_item.dart';
import '../../widgets/modules/contracts/contract_card.dart';
import '../../widgets/shared/info_card.dart';
import '../../widgets/shared/styles/card_styles.dart';

class ContractManagementContent extends StatefulWidget {
  final String sede;
  final List<ContractItem> contratos;
  final void Function(ContractItem) onTapEditar;
  final VoidCallback onTapAdd;

  const ContractManagementContent({
    Key? key,
    required this.sede,
    required this.contratos,
    required this.onTapEditar,
    required this.onTapAdd,
  }) : super(key: key);

  @override
  State<ContractManagementContent> createState() => _ContractManagementContentState();
}

class _ContractManagementContentState extends State<ContractManagementContent> {
  final Map<String, bool> _expansionStates = {};
  bool _areAllExpanded = false;

  void _toggleExpansion(String id) {
    setState(() {
      _expansionStates[id] = !(_expansionStates[id] ?? false);
    });
  }

  void _toggleAllExpansion() {
    setState(() {
      _areAllExpanded = !_areAllExpanded;
      for (var contrato in widget.contratos) {
        _expansionStates[contrato.id] = _areAllExpanded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Info Card Section
        Padding(
          padding: const EdgeInsets.all(16),
          child: InfoCard(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF667EEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            items: [
              InfoCardItem(
                label: 'Sede principal',
                value: widget.sede,
              ),
            ],
          ),
        ),
        // Content Section
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Postulantes registrados',
                        style: CardStyles.titleStyle(context, MediaQuery.of(context).size.width),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: _toggleAllExpansion,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF667EEA).withAlpha(20),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF667EEA).withAlpha(51),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedRotation(
                                turns: _areAllExpanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(
                                  Icons.expand_more,
                                  size: 16,
                                  color: Color(0xFF667EEA),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _areAllExpanded ? 'Comprimir' : 'Expandir',
                                style: CardStyles.actionStyle(context, MediaQuery.of(context).size.width),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF667EEA).withAlpha(25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${widget.contratos.length}',
                          style: CardStyles.counterStyle(context, MediaQuery.of(context).size.width),
                        ),
                      ),
                    ],
                  ),
                ),
                // List Section
                Expanded(
                  child: widget.contratos.isEmpty
                      ? Center(
                          child: Text(
                            'No hay postulantes registrados',
                            style: CardStyles.emptyStyle(context, MediaQuery.of(context).size.width),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: widget.contratos.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final contrato = widget.contratos[index];
                            return ContractCard(
                              contract: contrato,
                              isExpanded: _expansionStates[contrato.id] ?? false,
                              onToggleExpansion: () => _toggleExpansion(contrato.id),
                              onTapEditar: () => widget.onTapEditar(contrato),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}