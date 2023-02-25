import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomIconButton extends HookWidget {
  const CustomIconButton(
      {super.key, required this.icon, required this.size, required this.tap});
  final HeroIcons icon;
  final Function tap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final selected = useState(false);

    return GestureDetector(
      onTapDown: (details) {
        selected.value = true;
      },
      onTap: () {
        tap();
      },
      onTapUp: (details) {
        selected.value = false;
      },
      onTapCancel: () {
        selected.value = false;
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: HeroIcon(
          icon,
          size: size,
          style: selected.value ? HeroIconStyle.solid : HeroIconStyle.outline,
        ),
      ),
    );
  }
}
