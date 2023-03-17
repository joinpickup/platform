import 'package:flutter/material.dart';
import 'package:local/screens/post_auth/post/views/comment_card.dart';

class CommentFeed extends StatelessWidget {
  const CommentFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: const [
          CommentCard(),
          Divider(
            height: 8,
            thickness: 1,
          ),
          CommentCard(),
        ],
      ),
    );
  }
}
