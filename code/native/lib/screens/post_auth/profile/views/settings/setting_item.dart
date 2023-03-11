import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SettingsItem extends StatefulWidget {
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
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool selected = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (mounted) {
          setState(() {
            selected = true;
          });
        }
      },
      onTap: () {
        if (mounted) {
          setState(() {
            selected = true;
          });
        }
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.action();
        });
      },
      onTapUp: (details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              selected = false;
            });
          }
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              selected = false;
            });
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? TW3Colors.gray.shade600 : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: selected
                    ? TW3Colors.gray.shade500
                    : TW3Colors.gray.shade600,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: HeroIcon(
                widget.icon,
                style: HeroIconStyle.solid,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                widget.name,
              ),
            ),
            Container(
              child: widget.hasArrow
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
