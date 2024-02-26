import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/local.dart';

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
        primary: kColorDeepBlood,
        secondary: kColorRoyal,
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
      extensions: <ThemeExtension<LocalColors>>[
        LocalColors(
          postCard: createMaterialColor(const Color(0xFFEDD3B8)),
          boardCard: createMaterialColor(const Color(0xFFB5C1B9)),
          onBoardCard: createMaterialColor(const Color(0xFF152834)),
          dialogBackground: createMaterialColor(const Color(0xFFF5E8DA)),
          onDialogBackground: createMaterialColor(const Color(0xFF152834)),
          dialogBackgroundHover: createMaterialColor(const Color(0xFFEDD3B8)),
        ),
      ],
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
        primary: kColorDust,
        onPrimary: kColorMud,
        secondary: kColorDust,
        background: kColorMud,
        onBackground: kColorDust,
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
      extensions: <ThemeExtension<LocalColors>>[
        LocalColors(
          postCard: createMaterialColor(const Color(0xFF352005)),
          boardCard: createMaterialColor(const Color(0xFF38474D)),
          onBoardCard: createMaterialColor(const Color(0xFFE6DCD2)),
          dialogBackground: createMaterialColor(const Color(0xFF352005)),
          onDialogBackground: createMaterialColor(const Color(0xFFC9B69F)),
          dialogBackgroundHover: createMaterialColor(const Color(0xFF442D0F)),
        ),
      ],
    );
  }
}
