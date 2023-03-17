import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverSearch extends StatefulWidget {
  const DiscoverSearch({super.key, required this.search});

  final String search;

  @override
  State<DiscoverSearch> createState() => _DiscoverSearchState();
}

class _DiscoverSearchState extends State<DiscoverSearch> {
  final _postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostFeedBloc(_postRepository)..add(LoadPosts()),
      child: _buildScreen(),
    );
  }

  Scaffold _buildScreen() {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      appBar: AppBar(
        title: const Text("Search Posts"),
        backgroundColor: TW3Colors.gray.shade700,
      ),
      body: SafeArea(
        child: Column(
          children: [
            PostFeed(),
          ],
        ),
      ),
    );
  }
}
