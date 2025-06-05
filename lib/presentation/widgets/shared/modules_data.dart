import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';

/// Clase que asocia nombre e ícono para cada módulo.
/// Usada por ModulesPanel para mostrar la lista.
class ModuleData {
  final String name;
  final IconData icon;

  const ModuleData({required this.name, required this.icon});
}

/// Lista de datos para cada módulo, en el mismo orden de ModuleType.values.
final List<ModuleData> appModules = ModuleType.values
    .map((m) => ModuleData(name: m.displayName, icon: m.icon)) // Cambiado iconData por icon
    .toList();