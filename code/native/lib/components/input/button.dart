import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomButton extends HookWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      color: TW3Colors.cyan.shade300,
    );
  }
}
