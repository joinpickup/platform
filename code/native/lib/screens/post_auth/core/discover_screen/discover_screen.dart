import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_app_bar.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_group_drawer/discover_group_drawer.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverScreen extends HookWidget {
  const DiscoverScreen({super.key, required this.showBottomBar});

  final ValueNotifier<bool> showBottomBar;

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: "");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DiscoverAppBar(
          searchController: searchController,
        ),
      ),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          showBottomBar.value = false;
        } else {
          showBottomBar.value = true;
        }
      },
      drawer: const Drawer(
        child: GroupDrawer(),
      ),
      backgroundColor: TW3Colors.gray.shade700,
      body: SafeArea(
        child: Column(
          children: [
            PostFeed(),
          ],
        ),
      ),
    );
  }
}
