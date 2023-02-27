import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomButton extends HookWidget {
  const CustomButton({super.key, required this.tap, required this.text});

  final Function tap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tap(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8,
          ),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
