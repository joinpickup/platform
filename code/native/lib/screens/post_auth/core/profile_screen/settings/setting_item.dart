import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SettingsItem extends HookWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.name,
    required this.action,
    this.hasArrow = false,
  });

  final HeroIcons icon;
  final String name;
  final Function action;
  final bool hasArrow;

  @override
  Widget build(BuildContext context) {
    final selected = useState(false);

    return GestureDetector(
      onTapDown: (details) {
        selected.value = true;
      },
      onTap: () {
        selected.value = true;
        Future.delayed(const Duration(milliseconds: 50), () {
          action();
        });
      },
      onTapUp: (details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          selected.value = false;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          selected.value = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected.value ? TW3Colors.gray.shade600 : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: selected.value
                    ? TW3Colors.gray.shade500
                    : TW3Colors.gray.shade600,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: HeroIcon(
                icon,
                style: HeroIconStyle.solid,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                name,
              ),
            ),
            Container(
              child: hasArrow
                  ? const HeroIcon(
                      HeroIcons.chevronRight,
                      style: HeroIconStyle.solid,
                      size: 20,
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
