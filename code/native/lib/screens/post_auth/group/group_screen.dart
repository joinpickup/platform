import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/mocks/group.dart';
import 'package:local/screens/post_auth/core/discover_screen/add_post.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/add_event.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:local/screens/post_auth/group/group_settings.dart';
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
      floatingActionButton: tab.value == 0 || tab.value == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    switch (tab.value) {
                      case 0:
                        return const AddPostScreen();
                      case 1:
                        return const AddEventScreen();
                      default:
                        return const AddPostScreen();
                    }
                  },
                ));
              },
              child: const HeroIcon(HeroIcons.plus),
            )
          : null,
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
      backgroundColor: TW3Colors.gray.shade700,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGroupInfo(group.value, context),
          _buildGroupActions(group.value, context),
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
  return Container(
    decoration: BoxDecoration(color: TW3Colors.gray.shade700),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue.shade400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              group.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "(${group.slug})",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        Text(
          group.description,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        const DetailRow(icon: HeroIcons.map, text: "New Haven"),
        const SizedBox(
          height: 8,
        ),
        const DetailRow(icon: HeroIcons.eye, text: "Public"),
        const SizedBox(
          height: 8,
        ),
        Text(
          "#${group.interest.name}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}

class DetailRow extends HookWidget {
  const DetailRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final HeroIcons icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade600,
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: HeroIcon(
            icon,
            style: HeroIconStyle.solid,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            text,
          ),
        ),
      ],
    );
  }
}

Widget _buildGroupActions(Group group, BuildContext context) {
  return Container(
    decoration: BoxDecoration(color: TW3Colors.gray.shade700),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        CustomButton(
          text: "Join",
          tap: () {},
        )
      ],
    ),
  );
}

Widget _buildGroupFeed(ValueNotifier<int> tab, BuildContext context) {
  switch (tab.value) {
    case 0:
      return PostFeed();
    case 1:
      return EventFeed(
        filter: EventFilter.upcoming,
      );
    case 3:
      return const GroupSettings();
    default:
      return Container();
  }
}
