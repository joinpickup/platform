import 'package:flutter/material.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/post.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:local/screens/post_auth/post/views/thread_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
    required this.postID,
  });

  final int postID;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Post? post;

  @override
  void initState() {
    post = allPosts.firstWhere(
      (post) => post.postID == widget.postID,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: TW3Colors.gray.shade700,
              title: const Text("View Post"),
              elevation: 0,
              pinned: true,
              expandedHeight: 250,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildPost(context, post as Post),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ThreadFeed(
              postID: widget.postID,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPost(BuildContext context, Post post) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(context, post),
          const SizedBox(
            height: 8,
          ),
          Text(
            post.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            post.body,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          _buildPostFooter(context, post),
        ],
      ),
    );
  }

  Widget _buildPostHeader(
    BuildContext context,
    Post post,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PersonScreen(
                personID: post.poster.personID,
              );
            },
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // avatar
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24),
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
        ),
      ),
    );
  }

  Widget _buildPostFooter(BuildContext context, Post post) {
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
