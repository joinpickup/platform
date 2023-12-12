import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';

class AddBoard extends StatelessWidget {
  const AddBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: kColorSand,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "New Board",
                style: TextStyle(
                  color: kColorRoyal,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomIconButton(
                icon: kIconClose,
                click: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomInput(),
          const SizedBox(
            height: 8,
          ),
          const CustomDescriptionInput(),
        ],
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Enter a name...",
        hintStyle: const TextStyle(
          color: kColorRoyal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kColorRoyal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class CustomDescriptionInput extends StatelessWidget {
  const CustomDescriptionInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Enter a description...",
        hintStyle: const TextStyle(
          color: kColorRoyal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kColorRoyal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
