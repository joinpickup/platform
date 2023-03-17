import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/post.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:local/screens/post_auth/post/post_bloc.dart';
import 'package:local/screens/post_auth/post/views/comment_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    super.key,
    required this.commentID,
  });

  final int commentID;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(_postRepository)..add(LoadPost(postID: widget.commentID)),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.success:
              return _buildSuccess(state);
            case PostStatus.loading:
              return _buildLoading();
            default:
              return _buildError();
          }
        },
      ),
    );
  }

  Scaffold _buildLoading() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Comment"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.maxFinite,
          height: 175,
          color: TW3Colors.gray.shade700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.maxFinite,
                height: 100,
                decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold _buildError() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Comment"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Center(
          child: Text(
            "Error loading comment",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  Scaffold _buildSuccess(PostState state) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: TW3Colors.gray.shade700,
              title: const Text("View Comment"),
              elevation: 0,
              pinned: true,
              expandedHeight: state.post!.body.length >= 100 ? 276 : 224,
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
                      _buildPost(context, state.post as Post),
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
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                  child: CustomButton(
                    text: "Comment",
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomButton(
                    text: "Message",
                    tap: () {},
                  ),
                ),
              ]),
            ),
            const CommentFeed(),
          ],
        ),
      ),
    );
  }

  Container _buildPost(BuildContext context, Post post) {
    return Container(
      padding: const EdgeInsets.all(8),
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
                personID: post.poster!.personID,
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
                child: Image.asset(post.poster!.avatar, fit: BoxFit.cover),
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
                  post.poster!.name,
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
          "#${post.interest!.name}",
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
