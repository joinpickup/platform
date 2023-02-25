import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/input/button.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_group_drawer/group_drawer_app_bar.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_group_drawer/group_drawer_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupDrawer extends HookWidget {
  const GroupDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TW3Colors.gray.shade600,
      child: SafeArea(
        child: Column(
          children: [
            const GroupDrawerAppBar(),
            const GroupDrawerFeed(),
            Container(
              padding: const EdgeInsets.all(32),
              child: const CustomButton(),
            ),
          ],
        ),
      ),
    );
  }
}
