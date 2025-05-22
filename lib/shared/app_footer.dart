import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

@override
Widget build(BuildContext context) {
  final primary = Theme.of(context).primaryColor;
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Fondo claro, no color principal
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: primary.withOpacity(0.55),
      showUnselectedLabels: false,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menú',
          backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
          backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
          backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Agregar',
          backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync),
          label: 'Sincronizar',
          backgroundColor: Colors.white
        ),
      ],
    ),
  );
}
}