import 'package:flutter/material.dart';

abstract class BaseCard extends StatelessWidget {
  final List<Widget> actions;
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  
  const BaseCard({
    super.key,
    this.actions = const [],
    required this.isExpanded,
    required this.onToggleExpansion,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleExpansion,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context),
                    if (isExpanded) ...[
                      const SizedBox(height: 12),
                      buildExpandedContent(context),
                    ],
                  ],
                ),
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(width: 12),
                ...actions,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context);
  Widget buildExpandedContent(BuildContext context);
}