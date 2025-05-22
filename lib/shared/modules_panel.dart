import 'package:flutter/material.dart';
import 'modules_data.dart';

class ModulesPanel extends StatelessWidget {
  final bool isDarkMode;
  final void Function(int index)? onModuleTap;

  const ModulesPanel({
    super.key,
    required this.isDarkMode,
    this.onModuleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF030F0F) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.8,
            ),
            itemCount: appModules.length,
            itemBuilder: (context, index) {
              final module = appModules[index];
              return GestureDetector(
                onTap: () {
                  if (onModuleTap != null) onModuleTap!(index);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0x33161F49)
                        : Theme.of(context).primaryColor.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        module.icon,
                        color: isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          module.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}