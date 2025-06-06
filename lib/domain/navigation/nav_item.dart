import 'package:flutter/material.dart';

/// Define los items de navegación de la barra inferior
enum NavItem {
  MENU(
    icon: Icons.menu,
    label: 'Menú',
  ),
  SEARCH(
    icon: Icons.search,
    label: 'Buscar',
  ),
  HOME(
    icon: Icons.home,
    label: 'Inicio',
  ),
  ADD_PERSON(
    icon: Icons.person_add,
    label: 'Agregar',
  ),
  SYNC(
    icon: Icons.sync,
    label: 'Sincronizar',
  );

  final IconData icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}