import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/components/skelaton/event_card_skelaton.dart';
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
  final _searchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventFeedBloc()..add(LoadEvents()),
        ),
        BlocProvider(
          create: (context) => TabBarBloc()..add(InitializeTabBar()),
        ),
      ],
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    return BlocListener<TabBarBloc, TabBarState>(
      listener: (context, state) {
        switch (state.tab) {
          case 0:
            context.read<EventFeedBloc>().add(
                  FilterEvents(
                    filter: EventFilter.upcoming,
                  ),
                );
            return;
          case 1:
            context.read<EventFeedBloc>().add(
                  FilterEvents(
                    filter: EventFilter.saved,
                  ),
                );
            return;
          case 2:
            context.read<EventFeedBloc>().add(
                  FilterEvents(
                    filter: EventFilter.organized,
                  ),
                );
            return;
          case 4:
            context.read<EventFeedBloc>().add(
                  FilterEvents(
                    filter: EventFilter.premium,
                  ),
                );
            return;
          default:
            Container();
        }
      },
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
              small: true,
              tabs: [
                CustomTab(
                  activeColor: TW3Colors.gray.shade600,
                  label: "Upcoming",
                  tab: 0,
                  small: true,
                ),
                CustomTab(
                  activeColor: TW3Colors.gray.shade600,
                  label: "Saved",
                  tab: 1,
                  small: true,
                ),
                CustomTab(
                  activeColor: TW3Colors.gray.shade600,
                  label: "Organized",
                  tab: 2,
                  small: true,
                ),
                CustomTab(
                  activeColor: TW3Colors.gray.shade600,
                  label: "Premium",
                  tab: 3,
                  small: true,
                ),
              ],
            ),
            const EventFeed(),
          ],
        ),
      ),
    );
  }
}
