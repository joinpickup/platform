import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/skelaton/post_card_skelaton.dart';
import 'package:local/screens/post_auth/discover/views/post_card.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostFeed extends StatefulWidget {
  PostFeed({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostFeedBloc, PostFeedState>(
      builder: (context, state) {
        switch (state.status) {
          case PostFeedStatus.success:
            return Expanded(
              child: SmartRefresher(
                onRefresh: () => context.read<PostFeedBloc>().add(
                    RefreshPosts(refreshController: widget._refreshController)),
                onLoading: () => context.read<PostFeedBloc>().add(
                    LoadPosts(refreshController: widget._refreshController)),
                enablePullDown: true,
                enablePullUp: true,
                controller: widget._refreshController,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return PostCard(
                        post: state.posts[index],
                      );
                    },
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: state.posts.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                  ),
                ),
              ),
            );
          case PostFeedStatus.loading:
            return const PostCardSkelaton();
          case PostFeedStatus.failure:
            return Container();
          default:
            return Container();
        }
      },
    );
  }
}
