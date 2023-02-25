import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/post.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_card.dart';

class PostFeed extends HookWidget {
  const PostFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = useState([andrewPost, brianPost]);
    return Expanded(
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return PostCard(
            post: posts.value[index],
          );
        },
        shrinkWrap: true,
        itemCount: posts.value.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
