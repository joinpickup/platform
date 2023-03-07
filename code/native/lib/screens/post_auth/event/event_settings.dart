import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/setting_item.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/settings_group.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventSettings extends HookWidget {
  EventSettings({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: SmartRefresher(
          scrollController: scrollController,
          enablePullDown: false,
          enablePullUp: false,
          controller: _refreshController,
          child: ListView(
            children: [
              _buildEventSettings(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildEventSettings(BuildContext context) {
  return Column(
    children: [
      SettingsGroup(
        includeName: false,
        name: "Event Settings",
        settings: [
          SettingsItem(
            icon: HeroIcons.pencil,
            name: "Event Details",
            action: () {},
            hasArrow: true,
          ),
          SettingsItem(
            icon: HeroIcons.user,
            name: "Edit Participants",
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
            name: "Archive Event",
            action: () {},
          ),
          SettingsItem(
            icon: HeroIcons.xMark,
            name: "Delete Event",
            action: () {},
          ),
        ],
      ),
    ],
  );
}
