import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/person.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import '../../../components/navigation/tab_bar.dart';

class PersonScreen extends HookWidget {
  const PersonScreen({super.key, required this.personID});

  final int personID;

  @override
  Widget build(BuildContext context) {
    final tab = useState(0);
    final group = useState(
        allPersons.firstWhere((person) => person.personID == personID));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Person"),
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
      backgroundColor: TW3Colors.gray.shade600,
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomTabBar(
            tab: tab,
            includeSettings: false,
          ),
          _buildPersonFeed(tab, context),
        ],
      ),
    );
  }
}

Widget _buildPersonFeed(ValueNotifier<int> tab, BuildContext context) {
  switch (tab.value) {
    case 0:
      return PostFeed();
    case 1:
      return EventFeed(
        filter: EventFilter.upcoming,
      );
    default:
      return Container();
  }
}
