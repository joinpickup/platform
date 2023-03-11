import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/screens/post_auth/events/views/event_feed.dart';
import 'package:local/screens/post_auth/events/views/events_app_bar.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class TabModel {
  final String name;
  final Widget body;

  TabModel({required this.name, required this.body});
}

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int tab = 0;
  final _searchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventFeedBloc>.value(
      value: BlocProvider.of(context),
      child: Scaffold(
        backgroundColor: TW3Colors.gray.shade600,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: EventsAppBar(
            searchController: _searchController,
          ),
        ),
        body: Column(
          children: [
            CustomTabBar(
              tab: tab,
              setTab: (newTab) {
                setState(() {
                  tab = newTab;
                });
              },
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
            EventFeed(),
          ],
        ),
      ),
    );
  }
}
