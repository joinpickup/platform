import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/core/events_screen/event_card.dart';

class EventFeed extends HookWidget {
  const EventFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final events = useState([1, 2, 3, 4]);
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (BuildContext context, int index) {
          return const EventCard();
        },
        shrinkWrap: true,
        itemCount: events.value.length,
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
