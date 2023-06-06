import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class InterestChip extends StatefulWidget {
  const InterestChip({
    super.key,
    required this.text,
    required this.tap,
    required this.selected,
    required this.isError,
    this.hasDelete = false,
  });

  final String text;
  final Function tap;
  final bool selected;
  final bool isError;
  final bool hasDelete;

  @override
  State<InterestChip> createState() => _InterestChipState();
}

class _InterestChipState extends State<InterestChip> {
  bool selected = false;
  Color? color;

  @override
  void initState() {
    selected = widget.selected;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!selected) {
            HapticFeedback.lightImpact();
          }
          selected = !selected;
        });

        widget.tap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isError && selected
              ? TW3Colors.red.shade500
              : selected
                  ? Theme.of(context).colorScheme.primary
                  : TW3Colors.gray.shade600,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.isError && selected
                    ? TW3Colors.gray.shade700
                    : selected
                        ? TW3Colors.gray.shade700
                        : TW3Colors.gray.shade300,
              ),
            ),
            widget.hasDelete
                ? Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      HeroIcon(
                        HeroIcons.xMark,
                        color: TW3Colors.gray.shade800,
                        size: 20,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
