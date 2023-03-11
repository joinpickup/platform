import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({super.key});

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: SmartRefresher(
          scrollController: _scrollController,
          enablePullDown: false,
          enablePullUp: false,
          controller: _refreshController,
          child: ListView(
            children: [
              _buildGroupSettings(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildGroupSettings(BuildContext context) {
  return Column(
    children: [
      SettingsGroup(
        includeName: false,
        name: "Group Settings",
        settings: [
          SettingsItem(
            icon: HeroIcons.pencil,
            name: "Group Details",
            action: () {},
            hasArrow: true,
          ),
          SettingsItem(
            icon: HeroIcons.user,
            name: "Edit Members",
            action: () {},
            hasArrow: true,
          ),
        ],
      ),
      SizedBox.fromSize(
        size: const Size.fromHeight(8),
      ),
      SettingsGroup(
        includeName: false,
        name: "",
        settings: [
          SettingsItem(
            icon: HeroIcons.eye,
            name: "Visibility",
            action: () {},
          ),
        ],
      ),
      SizedBox.fromSize(
        size: const Size.fromHeight(8),
      ),
      SettingsGroup(
        includeName: false,
        name: "Disaster Settings",
        settings: [
          SettingsItem(
            icon: HeroIcons.archiveBox,
            name: "Archive Group",
            action: () {},
          ),
          SettingsItem(
            icon: HeroIcons.xMark,
            name: "Delete Group",
            action: () {},
          ),
        ],
      ),
    ],
  );
}
