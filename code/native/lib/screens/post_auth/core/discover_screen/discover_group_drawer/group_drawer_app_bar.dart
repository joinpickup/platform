import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/input.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_group_drawer/add_group.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import '../../../../../components/input/icon_button.dart';

class GroupDrawerAppBar extends HookWidget {
  const GroupDrawerAppBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: CustomInput(
              placeholder: "Search for a group...",
              controller: searchController,
              backgroundColor: TW3Colors.gray.shade600,
              hintColor: TW3Colors.gray.shade500,
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
                    builder: (context) => const AddGroupScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
