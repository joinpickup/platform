import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/repos/data/models/group.dart';
import 'package:local/screens/post_auth/group/views/group_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupCard extends StatefulWidget {
  const GroupCard({super.key, required this.group});

  final Group group;

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          opacity = 0.6;
        });
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => GroupScreen(
              groupID: widget.group.groupID,
            ),
          ),
        );
      },
      onTapUp: (details) {
        setState(() {
          opacity = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          opacity = 1;
        });
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade700,
            border: Border.all(
              color: TW3Colors.gray.shade500.withOpacity(.25),
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGroupCardHeader(context, widget.group),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildGroupCardHeader(BuildContext context, Group group) {
  return Row(
    children: [
      // avatar
      ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(14),
          child: SvgPicture.asset(
            group.icon,
            color: TW3Colors.gray.shade400,
          ),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      // poster information
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name
          Text(
            group.name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // location / visbility
          Text(
            "#${group.interest.name}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      )
    ],
  );
}
