import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            0.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CustomIconButton(
                    icon: kIconBack,
                    size: 30,
                    click: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const SearchBar(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search for a board...",
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
      ),
    );
  }
}
