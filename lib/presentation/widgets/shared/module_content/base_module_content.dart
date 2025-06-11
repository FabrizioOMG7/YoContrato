import 'package:flutter/material.dart';
import '../info_card.dart';

abstract class BaseModuleContent extends StatelessWidget {
  final String sede;
  final VoidCallback? onTapAdd;
  
  const BaseModuleContent({
    super.key,
    required this.sede,
    this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoCard(
            icon: const Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 28,
            ),
            items: [InfoCardItem(label: 'Sede', value: sede)],
            trailing: onTapAdd != null ? IconButton(
              icon: const Icon(
                Icons.add_circle_rounded,
                color: Color(0xFF667EEA),
                size: 24,
              ),
              onPressed: onTapAdd,
            ) : null,
          ),
          const SizedBox(height: 24),
          Expanded(child: buildContent()),
        ],
      ),
    );
  }

  Widget buildContent();
}