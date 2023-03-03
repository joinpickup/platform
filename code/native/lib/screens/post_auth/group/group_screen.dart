import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/group.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import '../../../components/navigation/tab_bar.dart';
import '../../../models/group.dart';

class GroupScreen extends HookWidget {
  const GroupScreen({super.key, required this.groupID});

  final int groupID;

  @override
  Widget build(BuildContext context) {
    final tab = useState(0);
    final group =
        useState(allGroups.firstWhere((group) => group.groupID == groupID));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Group"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          )
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: Column(
        children: [
          _buildGroupInfo(group.value, context),
          const SizedBox(
            height: 16,
          ),
          CustomTabBar(
            tab: tab,
            includeSettings: true,
          ),
          _buildGroupFeed(tab, context),
        ],
      ),
    );
  }
}

Widget _buildGroupInfo(Group group, BuildContext context) {
  return Container();
}

Widget _buildGroupFeed(ValueNotifier<int> tab, BuildContext context) {
  switch (tab.value) {
    case 0:
      return PostFeed();
    case 1:
      return EventFeed(
        filter: EventFilter.upcoming,
      );
    default:
      return Container();
  }
}
