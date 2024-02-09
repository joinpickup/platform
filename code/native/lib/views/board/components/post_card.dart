import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/theme/color.dart';
import 'package:local/views/post/post_screen.dart';

class Post {
  final String author;
  final String body;
  final String createdAt;

  Post({
    required this.author,
    required this.body,
    required this.createdAt,
  });
}

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          selected = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          selected = false;
        });
      },
      onTapCancel: () {
        setState(() {
          selected = false;
        });
      },
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return PostScreen(
              post: widget.post,
            );
          },
        ));
      },
      child: Container(
        decoration: ShapeDecoration(
          color: selected ? kColorCardBlue.shade600 : kColorCardBlue,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 24,
              cornerSmoothing: 0.6,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        // left and right
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: kColorDeepBlood,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.post.author),
                const Spacer(),
                Text(
                  widget.post.createdAt,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(widget.post.body),
          ],
        ),
      ),
    );
  }
}
