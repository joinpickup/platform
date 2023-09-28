import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(),
      textTheme: GoogleFonts.nunitoTextTheme(),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(),
      textTheme: GoogleFonts.nunitoTextTheme(),
    );
  }
}
