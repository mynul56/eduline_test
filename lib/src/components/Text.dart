// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynul_test/src/constants/colors.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color? fontColor;
  double? wordSpacing, letterSpacing;
  TextAlign textAlignment;
  bool textOverflow;
  double height;
  TextDecoration textDecoration;
  List<Shadow>? shadows;
  int? maxLines;
  AppText(
    String text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.fontColor,
    this.letterSpacing,
    this.textAlignment = TextAlign.center,
    this.textOverflow = false,
    this.height = 1.2,
    this.textDecoration = TextDecoration.none,
    this.shadows,
    this.maxLines,
  }) : text = text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow ? TextOverflow.ellipsis : null,
      textAlign: textAlignment,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        color: fontColor ?? AppColors.semiDark,
        fontSize: fontSize,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        shadows: shadows,
        fontWeight: fontWeight,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}
