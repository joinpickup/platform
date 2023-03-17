import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Module extends StatefulWidget {
  const Module({
    super.key,
    required this.icon,
    required this.text,
    required this.action,
  });

  final HeroIcons icon;
  final String text;
  final Function action;

  @override
  State<Module> createState() => _ModuleState();
}

class _ModuleState extends State<Module> {
  bool selected = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
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
            color: selected ? TW3Colors.gray.shade600 : TW3Colors.gray.shade700,
            border: Border.all(
              color: TW3Colors.gray.shade500.withOpacity(.25),
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(widget.text)
            ],
          ),
        ),
      ),
    );
  }
}
