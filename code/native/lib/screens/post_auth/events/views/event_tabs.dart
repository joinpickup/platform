import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventTabs extends StatefulWidget {
  const EventTabs({super.key});

  @override
  State<EventTabs> createState() => _EventTabsState();
}

class _EventTabsState extends State<EventTabs> {
  final tabs = ["Upcoming", "Organized", "Saved", "Premium"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Text(tabs[index]);
        },
        shrinkWrap: true,
        itemCount: tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }
}
