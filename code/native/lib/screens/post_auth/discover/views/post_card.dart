import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/discover/views/post_options/post_options_screen.dart';
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
                PostScreen(postID: widget.post.postID as int),
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
      onLongPress: () {
        HapticFeedback.heavyImpact();
        showPostOptionsModal(
          context,
        );
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade700,
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
        ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(20),
            child: Image.asset(post.poster.avatar, fit: BoxFit.cover),
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
                Text(post.poster.location.commonName,
                    style: Theme.of(context).textTheme.titleSmall),
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
          post.body.length <= 120
              ? post.body
              : "${post.body.substring(0, 120)}...",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildPostCardFooter(BuildContext context, Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
            children: post.interests.map((e) {
          return Column(
            children: [
              Text(
                "#${post.interests[0].name}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          );
        }).toList()),
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
