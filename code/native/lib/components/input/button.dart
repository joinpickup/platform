import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum CustomButtonType { outlined, contained }

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.tap,
    this.text,
    this.child,
    this.hasError = false,
    this.color,
    this.buttonType = CustomButtonType.contained,
  });

  final Function tap;
  final String? text;
  final Widget? child;
  final bool hasError;
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
            milliseconds: 100,
          ),
          transform: Matrix4.identity()..scale(selected ? .95 : 1.0),
          padding: const EdgeInsets.all(8),
          decoration: widget.buttonType == CustomButtonType.contained
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  border: widget.hasError
                      ? Border.all(
                          color: TW3Colors.red.shade500,
                          width: 2,
                        )
                      : null,
                  color: (widget.color ?? color)!.withOpacity(
                    selected ? 0.75 : 1,
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  border: widget.hasError
                      ? Border.all(
                          color: TW3Colors.red.shade500,
                          width: 2,
                        )
                      : Border.all(
                          width: 2,
                          color: TW3Colors.gray.shade600,
                        ),
                  color:
                      selected ? TW3Colors.gray.shade600 : Colors.transparent,
                ),
          child: widget.text != null
              ? Text(
                  widget.text as String,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                )
              : widget.child ?? Container()),
    );
  }
}
