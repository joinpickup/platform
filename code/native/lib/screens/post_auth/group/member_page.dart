import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/badge.dart';
import 'package:local/repos/data/models/person.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupMemberPage extends HookWidget {
  GroupMemberPage({super.key, required this.members});

  final List<Person> members;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    return Expanded(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: members.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  MemberCard(
                    member: members[index],
                  ),
                ],
              );
            },
            controller: scrollController,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}

class MemberCard extends HookWidget {
  const MemberCard({super.key, required this.member});

  final Person member;

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
                PersonScreen(personID: member.personID),
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
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue.shade400,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      member.username,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const CustomBadge(
                text: "Admin",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
