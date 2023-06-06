import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SpaceRow extends StatefulWidget {
  const SpaceRow({
    super.key,
    required this.icon,
    required this.name,
    required this.action,
    this.selected = false,
  });

  final HeroIcons icon;
  final String name;
  final Function action;
  final bool selected;

  @override
  State<SpaceRow> createState() => _SpaceRowState();
}

class _SpaceRowState extends State<SpaceRow> {
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
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              selected = false;
            });
          }
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
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
            Icon(
              widget.selected
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 20,
              color: TW3Colors.gray.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
