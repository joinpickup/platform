import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local/theme/color.dart';

class LocalTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: kColorCardBlue,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: kColorRoyal,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: kColorRoyal,
        ),
        backgroundColor: kColorSand,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kColorRoyal,
        selectionColor: kColorRoyal200,
        selectionHandleColor: kColorRoyal200,
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: kColorRoyal,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kColorDeepBlood,
        shape: CircleBorder(),
      ),
      colorScheme: const ColorScheme.light(
        background: kColorSand,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: kColorSand,
      ),
      textTheme: GoogleFonts.archivoTextTheme(),
      inputDecorationTheme: const InputDecorationTheme(
        focusColor: kColorRoyal,
      ),
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
