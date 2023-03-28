import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/components/skelaton/post_card_skelaton.dart';
import 'package:local/components/snackbar/Snackbar.dart';
import 'package:local/navigator/post_auth/post_auth_navigator/post_auth_navigator_bloc.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/discover/views/discover_app_bar.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    super.key,
  });

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _searchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostAuthNavigatorBloc>.value(
          value: BlocProvider.of(context),
        ),
        BlocProvider(
          create: (context) => DiscoverScreenBloc(
            PostRepository(),
          )..add(LoadPosts()),
        ),
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: _buildScreen(context, _searchController),
    );
  }

  Widget _buildScreen(
    BuildContext context,
    TextEditingController searchController,
  ) {
    return BlocConsumer<DiscoverScreenBloc, DiscoverScreenState>(
      listener: (context, state) {
        if (state.feedStatus == DiscoverFeedStatus.error) {
          showSnackBar(context, state.error!.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: DiscoverAppBar(),
            ),
            backgroundColor: TW3Colors.gray.shade600,
            body: state.screenStatus == DiscoverScreenStatus.searching
                ? SafeArea(
                    child: Column(
                      children: const [
                        PostCardSkelaton(),
                      ],
                    ),
                  )
                : _buildNotSearching(state));
      },
    );
  }

  SafeArea _buildNotSearching(DiscoverScreenState state) {
    return SafeArea(
      child: Column(
        children: [
          state.feedStatus == DiscoverFeedStatus.success
              ? PostFeed(
                  posts: state.posts as List<Post>,
                  refreshController: RefreshController(
                    initialRefresh: false,
                  ),
                )
              : const PostCardSkelaton(),
        ],
      ),
    );
  }
}
