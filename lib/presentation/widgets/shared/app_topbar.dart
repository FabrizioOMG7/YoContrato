import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? titleFontSize;
  final double? subtitleFontSize;

  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.textColor, 
    this.titleFontSize,
    this.subtitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.primaryColor;
    final fgColor = textColor ?? theme.colorScheme.onPrimary;

    return AppBar(
      elevation: 0,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      leading: leading,
      actions: actions,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: fgColor,
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize ?? 20,
              letterSpacing: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),

          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.montserrat(
                color: fgColor.withOpacity(0.7),
                fontWeight: FontWeight.w600,
                fontSize: subtitleFontSize ?? 13,
                letterSpacing: 1.1,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);
}