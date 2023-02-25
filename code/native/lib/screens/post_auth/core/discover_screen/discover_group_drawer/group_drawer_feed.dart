import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_card.dart';

class GroupDrawerFeed extends HookWidget {
  const GroupDrawerFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = useState([1, 2, 3, 4, 5, 6, 7, 8, 9]);
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (BuildContext context, int index) {
          return const PostCard();
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
