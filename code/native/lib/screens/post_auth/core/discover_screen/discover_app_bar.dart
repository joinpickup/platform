import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/input/input.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverAppBar extends HookWidget {
  const DiscoverAppBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            spreadRadius: -6,
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(children: [
          Expanded(
            flex: 0,
            child: CustomIconButton(
              size: 28,
              icon: HeroIcons.userGroup,
              tap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomInput(
              controller: searchController,
            ),
          ),
          Expanded(
            flex: 0,
            child: CustomIconButton(
              size: 28,
              icon: HeroIcons.plus,
              tap: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
