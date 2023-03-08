import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/group.dart';
import 'package:local/models/group.dart';
import 'package:local/screens/post_auth/core/discover_screen/views/discover_group_drawer/group_card.dart';

class GroupSectionModel {
  final String name;
  final List<Group> groups;

  GroupSectionModel({required this.name, required this.groups});
}

class GroupDrawerFeed extends HookWidget {
  GroupDrawerFeed({super.key});

  final groupSections = [
    GroupSectionModel(
      groups: [climbingGroup, climbingGroup2],
      name: "Recent Groups",
    ),
    GroupSectionModel(
      groups: [climbingGroup, soccerGroup1, soccerGroup2],
      name: "Recommended Groups",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // group sections
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      children: groupSections.asMap().entries.map((entry) {
        return Column(
          key: ValueKey(entry.key),
          children: [
            GroupSection(
              section: entry.value,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class GroupSection extends HookWidget {
  const GroupSection({super.key, required this.section});

  final GroupSectionModel section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(8),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (BuildContext context, int index) {
            return GroupCard(
              group: section.groups[index],
            );
          },
          shrinkWrap: true,
          itemCount: section.groups.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
        )
      ],
    );
  }
}
