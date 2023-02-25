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
      const Color(0xFF5A6943),
    ),
    onSecondary: createMaterialColor(TW3Colors.gray.shade300),
    error: createMaterialColor(TW3Colors.red),
    onError: createMaterialColor(Colors.white),
    onBackground: createMaterialColor(TW3Colors.gray.shade300),
    surface: createMaterialColor(TW3Colors.gray.shade600),
    onSurface: createMaterialColor(TW3Colors.gray.shade300),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Nunito",
    ),
  ),
);
