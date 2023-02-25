import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/models/group.dart';
import 'package:local/models/post.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_group_drawer/group_card.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_card.dart';

class GroupDrawerFeed extends HookWidget {
  const GroupDrawerFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = useState([1, 2, 3, 4, 5, 6, 7, 8, 9]);
    return Expanded(
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(12),
        itemBuilder: (BuildContext context, int index) {
          return GroupCard(
            group: Group(groupID: index),
          );
        },
        shrinkWrap: true,
        itemCount: posts.value.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }
}
