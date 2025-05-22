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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menú',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Agregar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync),
          label: 'Sincronizar',
        ),
      ],
    );
  }
}