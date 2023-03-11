import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/screens/post_auth/discover/views/discover_search/discover_search.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.controller,
      required this.placeholder,
      this.onSearch,
      this.focus,
      this.hintColor,
      this.backgroundColor});

  final TextEditingController controller;
  final FocusNode? focus;
  final Color? backgroundColor;
  final String placeholder;
  final Color? hintColor;
  final Function? onSearch;

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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiscoverSearch(
                search: value,
              ),
            ));
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
