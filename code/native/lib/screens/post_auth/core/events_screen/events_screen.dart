import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/navigation/tab_bar.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/events_app_bar.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class TabModel {
  final String name;
  final Widget body;

  TabModel({required this.name, required this.body});
}

class EventsScreen extends HookWidget {
  EventsScreen({super.key});

  final tabs = [
    EventFeed(
      filter: EventFilter.upcoming,
    ),
    EventFeed(
      filter: EventFilter.organized,
    ),
    EventFeed(
      filter: EventFilter.saved,
    ),
    EventFeed(
      filter: EventFilter.premium,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: "");
    final tab = useState(0);

    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: EventsAppBar(
          searchController: searchController,
        ),
      ),
      body: Column(
        children: [
          CustomTabBar(
            tab: tab,
            small: true,
            tabs: [
              CustomTabModel(
                activeColor: TW3Colors.gray.shade600,
                label: "Upcoming",
                tab: 0,
              ),
              CustomTabModel(
                activeColor: TW3Colors.gray.shade600,
                label: "Saved",
                tab: 1,
              ),
              CustomTabModel(
                activeColor: TW3Colors.gray.shade600,
                label: "Organized",
                tab: 2,
              ),
              CustomTabModel(
                activeColor: TW3Colors.gray.shade600,
                label: "Premium",
                tab: 3,
              ),
            ],
          ),
          tabs[tab.value],
        ],
      ),
    );
  }
}
