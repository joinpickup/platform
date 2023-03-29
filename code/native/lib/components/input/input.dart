import 'package:flutter/cupertino.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.placeholder,
    this.onSearch,
    this.onChanged,
    this.onSuffixTap,
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
  final Function? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: CupertinoSearchTextField(
        backgroundColor: backgroundColor ?? TW3Colors.gray.shade600,
        focusNode: focus,
        controller: controller,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        onSubmitted: (value) {
          if (onSearch != null) {
            onSearch!(value);
          }
        },
        onSuffixTap: () {
          if (onSuffixTap != null) {
            onSuffixTap!();
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
