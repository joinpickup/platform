import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/models/event.dart';
import 'package:local/screens/post_auth/core/events_screen/event_card.dart';

class EventFeed extends HookWidget {
  const EventFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final events = useState([1, 2, 3, 4]);
    return Expanded(
      flex: 1,
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        itemBuilder: (BuildContext context, int index) {
          return EventCard(
            event: Event(eventID: index),
          );
        },
        shrinkWrap: true,
        itemCount: events.value.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }
}
