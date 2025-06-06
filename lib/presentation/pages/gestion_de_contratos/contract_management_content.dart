// lib/presentation/pages/gestion_de_contratos/contract_management_content.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/info_card.dart';

/// Modelo de datos para representar un contrato.
class ContractItem {
  final String nombre;
  final String dni;
  final String evento;
  final String fechaHora;

  const ContractItem({
    required this.nombre,
    required this.dni,
    required this.evento,
    required this.fechaHora,
  });
}

/// Cuerpo de la lista de contratos (sin Scaffold ni AppBar).
/// Recibe la lista de contratos, la sede y un callback onTapBuscar.
class ContractManagementContent extends StatelessWidget {
  final String sede;
  final List<ContractItem> contratos;
  final void Function(ContractItem) onTapBuscar;

  const ContractManagementContent({
    Key? key,
    required this.sede,
    required this.contratos,
    required this.onTapBuscar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InfoCard para mostrar la sede
          InfoCard(
            icon: const Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 28,
            ),
            items: [
              InfoCardItem(label: 'Sede', value: sede),
            ],
          ),
          const SizedBox(height: 24),

          // Lista de contratos
          Expanded(
            child: ListView.separated(
              itemCount: contratos.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final contrato = contratos[index];
                return ContractCard(
                  contract: contrato,
                  onTapBuscar: () => onTapBuscar(contrato),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta que muestra cada contrato y un botón para "Buscar Postulante".
/// Al presionar el ícono de búsqueda, invoca onTapBuscar.
class ContractCard extends StatelessWidget {
  final ContractItem contract;
  final VoidCallback onTapBuscar;

  const ContractCard({
    Key? key,
    required this.contract,
    required this.onTapBuscar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Detalles del contrato
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contract.nombre,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color:
                        isDarkMode ? Colors.white : const Color(0xFF111827),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'DNI: ${contract.dni}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'EVENTO: ${contract.evento}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        isDarkMode ? Colors.grey[300] : const Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'FECHA Y HORA: ${contract.fechaHora}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          // Botón "editar Postulante" con ícono de lupa
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF667EEA).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTapBuscar,
                borderRadius: BorderRadius.circular(10),
                child: const Icon(
                  Icons.edit,
                  color: Color(0xFF667EEA),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}