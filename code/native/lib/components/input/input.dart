import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomInput extends HookWidget {
  const CustomInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        prefixIcon: const HeroIcon(
          HeroIcons.magnifyingGlass,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: TW3Colors.gray.shade600,
      ),
    );
  }
}
