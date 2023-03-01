import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/post.dart';
import 'package:local/models/post.dart';
import 'package:local/screens/post_auth/core/discover_screen/post_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostFeed extends HookWidget {
  PostFeed({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _refreshController.refreshCompleted();
  }

  void _onLoading(ValueNotifier<List<Post>> posts) async {
    await Future.delayed(const Duration(milliseconds: 500));
    posts.value = [
      ...posts.value,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
      andrewPost,
    ];
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final posts = useState(allPosts);
    final scrollController = useScrollController();

    return Expanded(
      child: SmartRefresher(
        onRefresh: () => _onRefresh(),
        onLoading: () => _onLoading(posts),
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return PostCard(
                post: posts.value[index],
              );
            },
            shrinkWrap: true,
            controller: scrollController,
            itemCount: posts.value.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}
