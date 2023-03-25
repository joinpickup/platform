import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum CustomButtonType { outlined, contained }

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.tap,
    required this.text,
    this.color,
    this.buttonType = CustomButtonType.contained,
  });

  final Function tap;
  final String text;
  late Color? color;
  final CustomButtonType buttonType;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool selected = false;
  Color? color;

  @override
  Widget build(BuildContext context) {
    if (widget.color == null) {
      color = Theme.of(context).colorScheme.secondary;
    }

    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          selected = true;
        });
        HapticFeedback.lightImpact();
      },
      onTapUp: (details) {
        setState(() {
          selected = false;
        });
      },
      onTapCancel: () {
        setState(() {
          selected = false;
        });
      },
      onTap: () => widget.tap(),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: widget.buttonType == CustomButtonType.contained
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                color: (widget.color ?? color)!.withOpacity(
                  selected ? 0.75 : 1,
                ),
              )
            : BoxDecoration(
                border: Border.all(width: 2, color: TW3Colors.gray.shade600),
                borderRadius: BorderRadius.circular(
                  8,
                ),
                color: selected ? TW3Colors.gray.shade600 : Colors.transparent,
              ),
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
