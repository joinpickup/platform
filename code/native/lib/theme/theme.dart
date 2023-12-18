import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local/theme/color.dart';

class LocalTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: kColorRoyal,
      fontFamily: "Archivo",
      appBarTheme: AppBarTheme(
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
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kColorRoyal,
        selectionColor: kColorRoyal.shade200,
        selectionHandleColor: kColorRoyal.shade200,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: kColorRoyal,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kColorDeepBlood,
        shape: const CircleBorder(),
      ),
      colorScheme: ColorScheme.light(
        background: kColorSand,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: kColorSand,
      ),
      textTheme: GoogleFonts.archivoTextTheme().copyWith(
        titleLarge: TextStyle(
          color: kColorRoyal,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displayLarge: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          color: kColorRoyal,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
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
