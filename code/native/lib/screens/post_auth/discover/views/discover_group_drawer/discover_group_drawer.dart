import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/screens/post_auth/discover/views/discover_group_drawer/group_drawer_app_bar.dart';
import 'package:local/screens/post_auth/discover/views/discover_group_drawer/group_drawer_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupDrawer extends StatefulWidget {
  const GroupDrawer({super.key});

  @override
  State<GroupDrawer> createState() => _GroupDrawerState();
}

class _GroupDrawerState extends State<GroupDrawer> {
  final _searchController = TextEditingController(text: "");

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TW3Colors.gray.shade700,
      child: SafeArea(
        child: Column(
          children: [
            GroupDrawerAppBar(
              searchController: _searchController,
            ),
            Expanded(
              child: Container(
                color: TW3Colors.gray.shade600,
                child: const GroupDrawerFeed(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
