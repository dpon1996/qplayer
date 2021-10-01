import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QText extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const QText(
    this.title, {
    Key? key,
    this.style,
    this.color,
    this.fontSize = 14,
    this.fontWeight,
    this.maxLines,
    this.letterSpacing,
    this.height,
    this.textDecoration,
    this.textAlign,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style ??
          GoogleFonts.poppins(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            textStyle: TextStyle(
              letterSpacing: letterSpacing,
              height: height,
              decoration: textDecoration,
            ),
          ),
    );
  }
}
