import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.handjet().fontFamily,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFEEEEEE),
    secondary: Color(0XFF627254),
    inverseSurface: Color(0XFF040D12),
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.handjet().fontFamily,
  colorScheme: const ColorScheme.dark(
    surface: Color(0XFF040D12),
    secondary: Color(0xFF183D3D),
    inverseSurface: Color(0xFFEEEEEE),
  ),
);
