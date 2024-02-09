import 'dart:ui';

import 'package:flutter/material.dart';

// backgrounds
final kColorRoyal = createMaterialColor(const Color(0xFF152834));
final kColorMud = createMaterialColor(const Color(0xFF231403));
final kColorSand = createMaterialColor(const Color(0xFFF5E8DA));
final kColorDeepBlood = createMaterialColor(const Color(0xFF864A4E));

// card
final kColorCardCardDark = createMaterialColor(const Color(0xFF352005));
final kColorCardBlue = createMaterialColor(const Color(0xFFB5C1B9));
final kColorCardBlueAccent = createMaterialColor(const Color(0xFF324E5F));

// input
final kColorInput = createMaterialColor(const Color(0xFFEDD3B8));
final kColorInputDark = createMaterialColor(const Color(0xFF442D0F));

// text
final kColorBeige = createMaterialColor(const Color(0xFFBAADA0));

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
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
