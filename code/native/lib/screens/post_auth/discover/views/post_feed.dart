import 'package:flutter/material.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/discover/views/post_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({
    super.key,
    required this.posts,
    required this.refreshController,
    required this.scrollController,
    required this.canRefresh,
    required this.canLoad,
    this.onRefresh,
    this.onLoad,
  });

  final List<Post> posts;
  final Function? onRefresh;
  final Function? onLoad;
  final bool canRefresh;
  final bool canLoad;

  final RefreshController refreshController;
  final ScrollController scrollController;

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: widget.posts.isNotEmpty
          ? SmartRefresher(
              enablePullDown: widget.canRefresh,
              enablePullUp: widget.canLoad,
              onLoading: () {
                if (widget.canLoad && widget.onLoad != null) {
                  widget.onLoad!();
                }
              },
              onRefresh: () {
                if (widget.canRefresh && widget.onRefresh != null) {
                  widget.onRefresh!();
                }
              },
              controller: widget.refreshController,
              child: Scrollbar(
                thumbVisibility: true,
                controller: widget.scrollController,
                child: ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (BuildContext context, int index) {
                    return PostCard(
                      post: widget.posts[index],
                    );
                  },
                  shrinkWrap: true,
                  controller: widget.scrollController,
                  itemCount: widget.posts.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("No results",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
