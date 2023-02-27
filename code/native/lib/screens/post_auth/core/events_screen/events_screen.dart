import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    TabModel(
      body: const EventFeed(
        filter: EventFilter.upcoming,
      ),
      name: "Upcoming",
    ),
    TabModel(
      body: const EventFeed(
        filter: EventFilter.organized,
      ),
      name: "Organized",
    ),
    TabModel(
      body: const EventFeed(
        filter: EventFilter.saved,
      ),
      name: "Saved",
    ),
    TabModel(
      body: const EventFeed(
        filter: EventFilter.premium,
      ),
      name: "Premium",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: "");

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: TW3Colors.gray.shade600,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: EventsAppBar(
            searchController: searchController,
          ),
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: tabs
                  .map((tab) => Tab(
                        child: Text(tab.name),
                      ))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: tabs.map((tab) => (tab.body)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
