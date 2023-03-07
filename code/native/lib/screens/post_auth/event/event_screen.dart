import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/detail_row.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar.dart';
import 'package:local/mocks/event.dart';
import 'package:local/models/event.dart';
import 'package:local/screens/post_auth/core/discover_screen/add_post.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/add_event.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:local/screens/post_auth/event/event_settings.dart';
import 'package:local/screens/post_auth/event/participant_page.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EventScreen extends HookWidget {
  const EventScreen({super.key, required this.eventID});

  final int eventID;

  @override
  Widget build(BuildContext context) {
    final tab = useState(0);
    final event =
        useState(allEvents.firstWhere((event) => event.eventID == eventID));

    return _buildPageWithPostTab(tab, context, event);
    // : _buildPageOther(tab, context, event);
  }

  Scaffold _buildPageWithPostTab(ValueNotifier<int> tab, BuildContext context,
      ValueNotifier<Event> event) {
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
              title: const Text("View Event"),
              pinned: true,
              elevation: 0,
              expandedHeight: 347,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildEventInfo(event.value, context),
                    _buildEventActions(event.value, context),
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
            _buildEventFeed(event.value, tab, context),
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
        return EventParticipantPage(participants: event.participants);
      case 3:
        return EventSettings();
      default:
        return Container();
    }
  }
}
