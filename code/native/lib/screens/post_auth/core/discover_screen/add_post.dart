import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AddPostScreen extends HookWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Add Post",
          ),
          backgroundColor: TW3Colors.gray.shade700,
        ),
        backgroundColor: TW3Colors.gray.shade700,
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return Container(
    height: double.maxFinite,
    padding: const EdgeInsets.all(16),
    child: Stack(
      children: [
        ListView(
          children: [
            Text(
              "Post Information",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            CupertinoTextField(
              placeholder: "Enter a title...",
              placeholderStyle: TextStyle(
                color: TW3Colors.gray.shade400,
                fontFamily: "Nunito",
              ),
              style: TextStyle(
                color: TW3Colors.gray.shade300,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                color: TW3Colors.gray.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CupertinoTextField(
              placeholder: "Enter a description...",
              placeholderStyle: TextStyle(
                color: TW3Colors.gray.shade400,
                fontFamily: "Nunito",
              ),
              style: TextStyle(
                color: TW3Colors.gray.shade300,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                color: TW3Colors.gray.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              maxLines: 6,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomButton(
            tap: () {},
            text: "Create Post",
          ),
        ),
      ],
    ),
  );
}
