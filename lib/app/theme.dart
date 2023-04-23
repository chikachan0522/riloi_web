import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData whiteTheme() {
  return ThemeData.light().copyWith(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFFdbdbdb),
      textTheme: GoogleFonts.kosugiTextTheme(ThemeData.light().textTheme),
      colorScheme: const ColorScheme.light()
          .copyWith(background: const Color(0xFFFFFFFF)));
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF242424),
      textTheme: GoogleFonts.kosugiTextTheme(ThemeData.dark().textTheme),
      colorScheme: const ColorScheme.dark()
          .copyWith(background: const Color(0xFF000000)));
}
