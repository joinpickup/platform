import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.click,
    this.size = 36,
  });

  final String icon;
  final Function click;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: SvgPicture.string(
        icon,
        width: size,
        height: size,
        theme: SvgTheme(
          currentColor: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
