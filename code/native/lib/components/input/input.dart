import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomInput extends HookWidget {
  const CustomInput(
      {super.key,
      required this.controller,
      required this.placeholder,
      this.hintColor,
      this.backgroundColor});

  final TextEditingController controller;
  final Color? backgroundColor;
  final String placeholder;
  final Color? hintColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: CupertinoSearchTextField(
        backgroundColor: backgroundColor ?? TW3Colors.gray.shade600,
        controller: controller,
        placeholder: placeholder,
        placeholderStyle: TextStyle(
          color: hintColor ?? TW3Colors.gray.shade500,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        style: TextStyle(
          color: TW3Colors.gray.shade300,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
