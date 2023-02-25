import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/event_tabs.dart';
import 'package:local/screens/post_auth/core/events_screen/events_app_bar.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EventsScreen extends HookWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: "");

    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: EventsAppBar(
          searchController: searchController,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            EventTabs(),
            EventFeed(),
          ],
        ),
      ),
    );
  }
}
