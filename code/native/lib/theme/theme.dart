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
        surface: kColorCardBlue,
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
        bodyLarge: TextStyle(
          color: kColorRoyal,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: kColorRoyal,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          color: kColorRoyal,
          fontSize: 14,
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
        fillColor: kColorInput,
      ),
    );
  }

  static ThemeData get dark {
    var baseTextColor = kColorBeige;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: kColorRoyal,
      fontFamily: "Archivo",
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: baseTextColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: baseTextColor,
        ),
        backgroundColor: kColorMud,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: baseTextColor,
        selectionColor: baseTextColor.shade200,
        selectionHandleColor: baseTextColor.shade200,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: kColorRoyal,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kColorDeepBlood,
        shape: const CircleBorder(),
      ),
      colorScheme: ColorScheme.dark(
        background: kColorMud,
        onBackground: kColorBeige,
        surface: kColorCardCardDark,
        onSurface: kColorBeige,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: kColorMud,
      ),
      textTheme: GoogleFonts.archivoTextTheme().copyWith(
        titleLarge: TextStyle(
          color: baseTextColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: baseTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: baseTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          color: baseTextColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          color: baseTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: kColorInputDark,
        focusColor: kColorBeige,
      ),
    );
  }
}
