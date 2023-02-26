import 'package:flutter/material.dart';
import 'package:local/theme/colors.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme(
    background: TW3Colors.gray.shade700,
    brightness: Brightness.dark,
    primary: createMaterialColor(
      const Color(0xFFD3733C),
    ),
    onPrimary: createMaterialColor(TW3Colors.gray.shade300),
    secondary: createMaterialColor(
      const Color(0xFF6B7954),
    ),
    onSecondary: createMaterialColor(TW3Colors.gray.shade300),
    error: createMaterialColor(TW3Colors.red),
    onError: createMaterialColor(Colors.white),
    onBackground: createMaterialColor(TW3Colors.gray.shade300),
    surface: createMaterialColor(TW3Colors.gray.shade600),
    onSurface: createMaterialColor(TW3Colors.gray.shade300),
  ),
  fontFamily: "Nunito",
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: TW3Colors.gray.shade300,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: TW3Colors.gray.shade300,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: TW3Colors.gray.shade300,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: TW3Colors.gray.shade400,
      fontSize: 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: TW3Colors.gray.shade400,
      fontStyle: FontStyle.italic,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      color: TW3Colors.gray.shade300,
      fontWeight: FontWeight.bold,
    ),
  ),
);
