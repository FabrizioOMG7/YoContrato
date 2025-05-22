import 'package:flutter/material.dart';

class ModuleData {
  final String name;
  final IconData icon;

  const ModuleData({required this.name, required this.icon});
}

const List<ModuleData> appModules = [
  ModuleData(name: 'Gestión de Postulaciones', icon: Icons.event),
  ModuleData(name: 'Reclutamiento', icon: Icons.person_search),
  ModuleData(name: 'Ficha Médica', icon: Icons.topic),
  ModuleData(name: 'BBS', icon: Icons.analytics),
  ModuleData(name: 'Fotografía', icon: Icons.camera_alt),
  ModuleData(name: 'Gestión de Contratos', icon: Icons.assignment),
  ModuleData(name: 'Firma de Documentos', icon: Icons.edit_document),
  ModuleData(name: 'Validación y Fotocheck', icon: Icons.badge),
  ModuleData(name: 'Desistimiento', icon: Icons.cancel),
];