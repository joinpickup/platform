import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/repos/data/models/post/comment.dart';
import 'package:local/screens/post_auth/comment/comment_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                // avatar
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(18),
                    child: Image.asset(widget.comment.poster.avatar),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    widget.comment.poster.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.comment.body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  format(widget.comment.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: TW3Colors.gray.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
