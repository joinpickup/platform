import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/models/group.dart';
import 'package:local/screens/post_auth/group/group_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupCard extends HookWidget {
  const GroupCard({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    final opacity = useState(1.0);

    return GestureDetector(
      onTapDown: (details) {
        opacity.value = 0.6;
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                GroupScreen(groupID: group.groupID),
          ),
        );
      },
      onTapUp: (details) {
        opacity.value = 1;
      },
      onTapCancel: () {
        opacity.value = 1;
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity.value,
        child: Container(
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade700,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          height: 100,
        ),
      ),
    );
  }
}
