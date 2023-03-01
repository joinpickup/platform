import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/post.dart';
import 'package:local/models/post.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class PostScreen extends HookWidget {
  const PostScreen({
    super.key,
    required this.postID,
  });

  final int postID;

  @override
  Widget build(BuildContext context) {
    final post = useState(allPosts.firstWhere(
      (post) => post.postID == postID,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade600,
        title: const Text("View Post"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          )
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPost(context, post.value),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Threads",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return _buildThread(context, post.value);
                  },
                  shrinkWrap: true,
                  itemCount: 5,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container _buildPost(BuildContext context, Post post) {
  return Container(
    decoration: BoxDecoration(
      color: TW3Colors.gray.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
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
          style: Theme.of(context).textTheme.bodyLarge,
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

Container _buildThread(BuildContext context, Post post) {
  return Container(
    decoration: BoxDecoration(
      color: TW3Colors.gray.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Thread Title",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    ),
  );
}
