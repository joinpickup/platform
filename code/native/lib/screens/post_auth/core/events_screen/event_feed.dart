import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/event.dart';
import 'package:local/screens/post_auth/core/events_screen/event_card.dart';

enum EventFilter { upcoming, organized, saved, premium }

class EventFeed extends HookWidget {
  const EventFeed({super.key, required this.filter});

  final EventFilter filter;

  @override
  Widget build(BuildContext context) {
    final events = useState([
      climbingSession1,
      climbingSession2,
    ]);

    return Expanded(
      flex: 1,
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return EventCard(
            event: events.value[index],
          );
        },
        shrinkWrap: true,
        itemCount: events.value.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
