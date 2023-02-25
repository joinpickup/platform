import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GroupScreen extends HookWidget {
  const GroupScreen({super.key, required this.groupID});

  final int groupID;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade400,
    );
  }
}
