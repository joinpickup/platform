import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/detail_row.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/repos/data/mocks/group.dart';
import 'package:local/repos/data/models/group.dart';
import 'package:local/screens/post_auth/add_event/add_event_screen.dart';
import 'package:local/screens/post_auth/add_post/add_post_screen.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/events/views/event_feed.dart';
import 'package:local/screens/post_auth/group/member_page.dart';
import 'package:local/screens/post_auth/group/views/group_settings.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key, required this.groupID});

  final int groupID;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  Group? group;
  int tab = 0;

  @override
  void initState() {
    super.initState();
    group = allGroups.firstWhere((group) => group.groupID == widget.groupID);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: PostFeedBloc()..add(LoadPosts()),
        ),
        BlocProvider.value(
          value: EventFeedBloc()..add(LoadEvents()),
        ),
      ],
      child: _buildPageWithPostTab(tab, context, group as Group),
    );
  }

  Scaffold _buildPageWithPostTab(int tab, BuildContext context, Group group) {
    return Scaffold(
      floatingActionButton: tab == 0 || tab == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    switch (tab) {
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
              backgroundColor: tab == 1
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
                    _buildGroupInfo(group, context),
                    _buildGroupActions(group, context),
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
            _buildEventFeed(group, tab, context),
          ],
        ),
      ),
    );
  }

  CustomTabBar _buildTabBar(int tab) {
    return CustomTabBar(
      setTab: (newTab) {
        tab = newTab;
      },
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
    int tab,
    BuildContext context,
  ) {
    switch (tab) {
      case 0:
        return PostFeed();
      case 1:
        return const EventFeed();
      case 2:
        return GroupMemberPage(members: group.members);
      case 3:
        return GroupSettings();
      default:
        return Container();
    }
  }
}
