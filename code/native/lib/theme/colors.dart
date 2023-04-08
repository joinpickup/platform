import 'package:flutter/material.dart';

class CustomMaroon {
  static const Color defaultColor = Color(0xFFA66253);
  static const Color color50 = Color(0xFFE5D0CB);
  static const Color color100 = Color(0xFFDEC4BE);
  static const Color color200 = Color(0xFFD1ABA3);
  static const Color color300 = Color(0xFFC39287);
  static const Color color400 = Color(0xFFB6796C);
  static const Color color500 = Color(0xFFA66253);
  static const Color color600 = Color(0xFF814C40);
  static const Color color700 = Color(0xFF5B362E);
  static const Color color800 = Color(0xFF36201B);
  static const Color color900 = Color(0xFF100A08);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
