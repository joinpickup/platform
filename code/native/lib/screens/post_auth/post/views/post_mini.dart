import 'package:flutter/material.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PostMini extends StatefulWidget {
  const PostMini({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostMini> createState() => _PostMiniState();
}

class _PostMiniState extends State<PostMini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: TW3Colors.gray.shade600,
        ),
        borderRadius: BorderRadius.circular(8),
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
        ],
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
        ),
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
}
