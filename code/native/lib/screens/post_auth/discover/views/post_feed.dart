import 'package:flutter/material.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/discover/views/post_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({
    super.key,
    required this.posts,
    required this.refreshController,
  });

  final List<Post> posts;

  final RefreshController refreshController;

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: widget.refreshController,
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (BuildContext context, int index) {
              return PostCard(
                post: widget.posts[index],
              );
            },
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: widget.posts.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}
