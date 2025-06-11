import '../base/base_item.dart';

class ContractItem extends BaseItem {
  final String nombre;
  final String dni;
  final String evento;
  final String fechaHora;

  const ContractItem({
    required super.id,
    required this.nombre,
    required this.dni,
    required this.evento,
    required this.fechaHora,
  });
}