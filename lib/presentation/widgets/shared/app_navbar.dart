import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/navigation/nav_item.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isInModule;

  const AppNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.isInModule = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: isInModule ? NavItem.MENU.index : currentIndex,
        // Simplificamos onTap para permitir siempre la navegación
        onTap: onTap,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        selectedItemColor: primary,
        unselectedItemColor: primary.withOpacity(0.55),
        showUnselectedLabels: false,
        elevation: 0,
        items: NavItem.values.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
            backgroundColor: Colors.white,
          );
        }).toList(),
      ),
    );
  }
}