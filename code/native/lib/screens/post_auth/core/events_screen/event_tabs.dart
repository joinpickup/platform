import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/core/events_screen/event_card.dart';

class EventTabs extends HookWidget {
  const EventTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = useState(
      ["Upcoming", "Organized", "Saved", "Premium"],
    );

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Text(tabs.value[index]),
          );
        },
        shrinkWrap: true,
        itemCount: tabs.value.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }
}
