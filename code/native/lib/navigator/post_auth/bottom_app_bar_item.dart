import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/services.dart';

class CustomBottomAppBarItem extends HookWidget {
  const CustomBottomAppBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentTab,
  });

  final HeroIcons icon;
  final String label;
  final ValueNotifier<int> currentTab;
  final int index;

  @override
  Widget build(BuildContext context) {
    final active = currentTab.value == index;

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          currentTab.value = index;
          HapticFeedback.lightImpact();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: active ? TW3Colors.gray.shade700 : Colors.transparent,
          ),
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                child: HeroIcon(
                  icon,
                  color: active
                      ? TW3Colors.gray.shade300
                      : TW3Colors.gray.shade500,
                  size: active ? 28 : 22,
                  style: active ? HeroIconStyle.solid : HeroIconStyle.outline,
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: active
                        ? TW3Colors.gray.shade300
                        : TW3Colors.gray.shade500,
                    fontSize: active ? 12 : 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
