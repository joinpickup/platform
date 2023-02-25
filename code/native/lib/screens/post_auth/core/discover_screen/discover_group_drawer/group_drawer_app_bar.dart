import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/input/input.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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
              backgroundColor: TW3Colors.gray.shade500,
            ),
          )
        ],
      ),
    );
  }
}
