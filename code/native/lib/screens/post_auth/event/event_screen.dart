import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/detail_row.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/data/mocks/event.dart';
import 'package:local/repos/data/models/event.dart';
import 'package:local/screens/post_auth/add_post/add_post_screen.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/event/views/event_settings.dart';
import 'package:local/screens/post_auth/event/views/participant_page.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.eventID});

  final int eventID;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Event? event;

  @override
  void initState() {
    super.initState();
    event = allEvents.firstWhere((event) => event.eventID == widget.eventID);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostFeedBloc>.value(
          value: PostFeedBloc()..add(LoadPosts()),
        ),
        BlocProvider<TabBarBloc>.value(
          value: TabBarBloc()..add(InitializeTabBar()),
        ),
      ],
      child: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, state) {
          return _buildPageWithPostTab(state.tab, context, event as Event);
        },
      ),
    );
  }

  Scaffold _buildPageWithPostTab(int tab, BuildContext context, Event event) {
    return Scaffold(
      floatingActionButton: tab == 0 || tab == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    switch (tab) {
                      case 0:
                        return const AddPostScreen();
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
              title: const Text("View Event"),
              pinned: true,
              elevation: 0,
              expandedHeight: 347,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildEventInfo(event, context),
                    _buildEventActions(event, context),
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
            _buildEventFeed(event, tab, context),
          ],
        ),
      ),
    );
  }

  CustomTabBar _buildTabBar(int tab) {
    return CustomTabBar(
      tabs: [
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Posts",
          tab: 0,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Participants",
          tab: 1,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Settings",
          tab: 2,
        ),
      ],
    );
  }

  Widget _buildEventInfo(Event event, BuildContext context) {
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
                event.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Text(
            event.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          DetailRow(icon: HeroIcons.map, text: event.location.commonName),
          const SizedBox(
            height: 8,
          ),
          const DetailRow(icon: HeroIcons.eye, text: "Public"),
          const SizedBox(
            height: 8,
          ),
          Text(
            "#${event.interest.name}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventActions(Event event, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: TW3Colors.gray.shade700),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          CustomButton(
            text: "RSVP",
            tap: () {},
          )
        ],
      ),
    );
  }

  Widget _buildEventFeed(
    Event event,
    int tab,
    BuildContext context,
  ) {
    switch (tab) {
      case 0:
        return PostFeed();
      case 1:
        return EventParticipantPage(participants: event.participants);
      case 2:
        return EventSettings();
      default:
        return Container();
    }
  }
}
