import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/theme/color.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton ({
    super.key,
    required this.icon,
    required this.click,
    this.background,
    this.iconColor,
    this.size = 32,
  });

  final String icon;
  final Function click;
  final Color? background;
  final Color? iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: Container(
        decoration: BoxDecoration(
          color: background ?? kColorInput.shade600,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: SvgPicture.string(
          icon,
          width: size,
          height: size,
          theme: SvgTheme(
            currentColor: iconColor ?? kColorRoyal,
          ),
        ),
      ),
    );
  }
}