import 'package:flutter/material.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/discover/views/post_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlaceFeed extends StatefulWidget {
  const PlaceFeed({
    super.key,
    required this.places,
    required this.refreshController,
    required this.scrollController,
    required this.canRefresh,
    required this.canLoad,
    this.onRefresh,
    this.onLoad,
  });

  final List<Post> places;
  final Function? onRefresh;
  final Function? onLoad;
  final bool canRefresh;
  final bool canLoad;

  final RefreshController refreshController;
  final ScrollController scrollController;

  @override
  State<PlaceFeed> createState() => _PlaceFeedState();
}

class _PlaceFeedState extends State<PlaceFeed>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: widget.places.isNotEmpty
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
                      post: widget.places[index],
                    );
                  },
                  shrinkWrap: true,
                  controller: widget.scrollController,
                  itemCount: widget.places.length,
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
