import 'package:flutter/material.dart';

enum ModuleType {
  GESTION_DE_POSTULACIONES,
  FICHA_MEDICA,
  BBS,
  FOTOGRAFIA,
  GESTION_DE_CONTRATOS,
  FIRMA_DE_DOCUMENTOS,
  VALIDACION_Y_FOTOCHECK,
  DESISTIMIENTO,
}

extension ModuleTypeExtension on ModuleType {
  String get displayName {
    switch (this) {
      case ModuleType.GESTION_DE_POSTULACIONES:
        return 'Gestión de Postulaciones';
      case ModuleType.FICHA_MEDICA:
        return 'Ficha Médica';
      case ModuleType.BBS:
        return 'BBS';
      case ModuleType.FOTOGRAFIA:
        return 'Fotografía';
      case ModuleType.GESTION_DE_CONTRATOS:
        return 'Gestión de Contratos';
      case ModuleType.FIRMA_DE_DOCUMENTOS:
        return 'Firma de Documentos';
      case ModuleType.VALIDACION_Y_FOTOCHECK:
        return 'Validación y Fotocheck';
      case ModuleType.DESISTIMIENTO:
        return 'Desistimiento';
    }
  }

  IconData get icon {
    switch (this) {
      case ModuleType.GESTION_DE_POSTULACIONES:
        return Icons.assignment_ind;
      case ModuleType.FICHA_MEDICA:
        return Icons.local_hospital;
      case ModuleType.BBS:
        return Icons.security;
      case ModuleType.FOTOGRAFIA:
        return Icons.photo_camera;
      case ModuleType.GESTION_DE_CONTRATOS:
        return Icons.description;
      case ModuleType.FIRMA_DE_DOCUMENTOS:
        return Icons.draw;
      case ModuleType.VALIDACION_Y_FOTOCHECK:
        return Icons.badge;
      case ModuleType.DESISTIMIENTO:
        return Icons.person_off;
    }
  }
}