import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/screens/post_auth/core/discover_screen/data/post.dart';
import 'package:local/screens/post_auth/post/post_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class PostCard extends HookWidget {
  const PostCard({super.key, required this.post});

  final Post post;

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
            builder: (BuildContext context) => PostScreen(postID: post.postID),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostCardHeader(context, post),
              const SizedBox(
                height: 8,
              ),
              _buildPostCardContent(context, post),
              const SizedBox(
                height: 8,
              ),
              _buildPostCardFooter(context, post),
            ],
          ),
        ),
      ),
    );
  }
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
