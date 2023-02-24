import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventCard extends HookWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      height: 100,
    );
  }
}
