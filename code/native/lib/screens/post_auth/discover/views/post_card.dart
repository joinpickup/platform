import 'package:flutter/material.dart';
import 'package:local/repos/data/models/post.dart';
import 'package:local/screens/post_auth/post/post_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

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
            builder: (BuildContext context) =>
                PostScreen(postID: widget.post.postID),
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
              _buildPostCardHeader(context, widget.post),
              const SizedBox(
                height: 8,
              ),
              _buildPostCardContent(context, widget.post),
              const SizedBox(
                height: 8,
              ),
              _buildPostCardFooter(context, widget.post),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCardHeader(BuildContext context, Post post) {
    return Row(
      children: [
        // avatar
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
        // poster information
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name
            Text(
              post.poster.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // location / visbility
            Row(
              children: [
                Text(
                  "East Rock",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  post.visibility.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildPostCardContent(BuildContext context, Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          post.body,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildPostCardFooter(BuildContext context, Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "#${post.interest.name}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          format(post.createdAt),
          style: TextStyle(
            fontSize: 12,
            color: TW3Colors.gray.shade500,
          ),
        ),
      ],
    );
  }
}
