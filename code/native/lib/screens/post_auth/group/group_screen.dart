import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/detail_row.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar.dart';
import 'package:local/mocks/event.dart';
import 'package:local/mocks/group.dart';
import 'package:local/models/event.dart';
import 'package:local/models/group.dart';
import 'package:local/screens/post_auth/core/discover_screen/add_post.dart';
import 'package:local/screens/post_auth/core/discover_screen/presentation/discover_group_drawer/group_drawer_feed.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/add_event.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:local/screens/post_auth/event/event_settings.dart';
import 'package:local/screens/post_auth/event/participant_page.dart';
import 'package:local/screens/post_auth/group/group_settings.dart';
import 'package:local/screens/post_auth/group/member_page.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupScreen extends HookWidget {
  const GroupScreen({super.key, required this.groupID});

  final int groupID;

  @override
  Widget build(BuildContext context) {
    final tab = useState(0);
    final group =
        useState(allGroups.firstWhere((group) => group.groupID == groupID));

    return _buildPageWithPostTab(tab, context, group);
    // : _buildPageOther(tab, context, event);
  }

  Scaffold _buildPageWithPostTab(ValueNotifier<int> tab, BuildContext context,
      ValueNotifier<Group> group) {
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
              backgroundColor: tab.value == 1
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              child: const HeroIcon(HeroIcons.plus),
            )
          : null,
      backgroundColor: TW3Colors.gray.shade600,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: TW3Colors.gray.shade700,
              title: const Text("View Group"),
              pinned: true,
              elevation: 0,
              expandedHeight: 347,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildGroupInfo(group.value, context),
                    _buildGroupActions(group.value, context),
                    _buildTabBar(tab),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                )
              ],
            ),
          ];
        },
        body: Column(
          children: [
            _buildEventFeed(group.value, tab, context),
          ],
        ),
      ),
    );
  }

  CustomTabBar _buildTabBar(ValueNotifier<int> tab) {
    return CustomTabBar(
      tab: tab,
      tabs: [
        CustomTabModel(
          activeColor: TW3Colors.gray.shade600,
          label: "Posts",
          tab: 0,
        ),
        CustomTabModel(
          activeColor: TW3Colors.gray.shade600,
          label: "Events",
          tab: 1,
        ),
        CustomTabModel(
          activeColor: TW3Colors.gray.shade600,
          label: "Participants",
          tab: 2,
        ),
        CustomTabModel(
          activeColor: TW3Colors.gray.shade600,
          label: "Settings",
          tab: 3,
        ),
      ],
    );
  }

  Widget _buildGroupInfo(Group group, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: TW3Colors.gray.shade700),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                group.name,
                style: Theme.of(context).textTheme.titleLarge,
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
          DetailRow(icon: HeroIcons.map, text: group.location.commonName),
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

  Widget _buildEventFeed(
    Group group,
    ValueNotifier<int> tab,
    BuildContext context,
  ) {
    switch (tab.value) {
      case 0:
        return PostFeed();
      case 1:
        return EventFeed(
          filter: EventFilter.upcoming,
        );
      case 2:
        return GroupMemberPage(members: group.members);
      case 3:
        return GroupSettings();
      default:
        return Container();
    }
  }
}
