import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventScreen extends HookWidget {
  const EventScreen({super.key, required this.eventID});

  final int eventID;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade700,
    );
  }
}
