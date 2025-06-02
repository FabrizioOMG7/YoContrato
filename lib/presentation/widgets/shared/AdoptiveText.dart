import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final double minFontSize;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;

  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.minFontSize = 12,
    this.textAlign,
    this.softWrap,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines,
      minFontSize: minFontSize,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap ?? true,
    );
  }
}