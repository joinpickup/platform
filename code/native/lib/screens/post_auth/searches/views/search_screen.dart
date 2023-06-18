import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/searches/views/options/search_options.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    required this.search,
  }) : super(key: key);

  final Search search;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _refreshController = RefreshController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: Text(widget.search.name),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              showSearchOptionsModal(
                context,
                widget.search,
              );
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: PostFeed(
          posts: widget.search.posts,
          refreshController: _refreshController,
          scrollController: _scrollController,
          canLoad: true,
          canRefresh: false,
          onRefresh: () {},
          onLoad: () {},
        ),
      ),
    );
  }
}
