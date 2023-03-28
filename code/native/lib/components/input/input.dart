import 'package:flutter/cupertino.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.placeholder,
    this.onSearch,
    this.onChanged,
    this.focus,
    this.hintColor,
    this.backgroundColor,
  });

  final TextEditingController controller;
  final FocusNode? focus;
  final Color? backgroundColor;
  final String placeholder;
  final Color? hintColor;
  final Function? onSearch;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: CupertinoSearchTextField(
        backgroundColor: backgroundColor ?? TW3Colors.gray.shade600,
        focusNode: focus,
        controller: controller,
        onSubmitted: (value) {
          if (onSearch != null) {
            onSearch!(value);
          }
        },
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
