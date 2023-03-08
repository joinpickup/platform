import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/input/input.dart';
import 'package:local/screens/post_auth/core/discover_screen/presentation/add_post.dart';
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
        border: Border(
          bottom: BorderSide(
            color: TW3Colors.gray.shade500.withOpacity(.25),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(children: [
          Expanded(
            flex: 0,
            child: CustomIconButton(
              size: 24,
              icon: HeroIcons.userGroup,
              tap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomInput(
              placeholder: "Search for a post...",
              controller: searchController,
            ),
          ),
          Expanded(
            flex: 0,
            child: CustomIconButton(
              size: 24,
              icon: HeroIcons.plus,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPostScreen(),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
