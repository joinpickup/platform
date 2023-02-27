import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/group.dart';
import 'package:local/models/group.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_group_drawer/group_card.dart';

class GroupSectionModel {
  final String name;
  final List<Group> groups;

  GroupSectionModel({required this.name, required this.groups});
}

class GroupDrawerFeed extends HookWidget {
  const GroupDrawerFeed({super.key});

  @override
  Widget build(BuildContext context) {
    // group sections
    final recentGroups = useState(GroupSectionModel(
      groups: [climbingGroup, climbingGroup],
      name: "Recent Groups",
    ));
    final recommendedGroups = useState(GroupSectionModel(
      groups: [climbingGroup],
      name: "Recommended Groups",
    ));
    final yourGroups = useState(GroupSectionModel(
      groups: [],
      name: "Your Groups",
    ));

    final groupSections = useState([
      recentGroups,
      recommendedGroups,
      yourGroups,
    ]);

    return Expanded(
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return GroupSection(
            section: groupSections.value[index].value,
          );
        },
        shrinkWrap: true,
        itemCount: groupSections.value.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
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
