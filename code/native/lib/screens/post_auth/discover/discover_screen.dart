import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/components/skelaton/post_card_skelaton.dart';
import 'package:local/components/snackbar/Snackbar.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/discover/views/discover_app_bar.dart';
import 'package:local/screens/post_auth/discover/views/discover_filter_bar.dart';
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
  final _refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiscoverScreenBloc>.value(
          value: BlocProvider.of(context),
        ),
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: _buildScreen(
        context,
      ),
    );
  }

  Widget _buildScreen(
    BuildContext context,
  ) {
    return BlocConsumer<DiscoverScreenBloc, DiscoverScreenState>(
      listener: (context, state) {
        if (state.feedStatus == DiscoverFeedStatus.error) {
          showSnackBar(context, state.error!.error);
        }
      },
      builder: (context, state) {
        return _buildBody(context, state);
      },
    );
  }

  SafeArea _buildBody(
    BuildContext context,
    DiscoverScreenState state,
  ) {
    return SafeArea(
      child: Container(
        color: TW3Colors.gray.shade600,
        child: Column(
          children: [
            const DiscoverAppBar(),
            state.feedStatus == DiscoverFeedStatus.success
                ? PostFeed(
                    posts: state.screenStatus == DiscoverScreenStatus.searching
                        ? state.postSearch as List<Post>
                        : state.postFeed as List<Post>,
                    refreshController: _refreshController,
                    scrollController: scrollController,
                    canLoad: true,
                    canRefresh:
                        state.screenStatus != DiscoverScreenStatus.searching,
                    onRefresh: () {
                      context.read<DiscoverScreenBloc>().add(HandleRefresh(
                            _refreshController,
                          ));
                    },
                    onLoad: () {
                      context.read<DiscoverScreenBloc>().add(HandleLoadMore(
                            _refreshController,
                          ));
                    },
                  )
                : const PostCardSkelaton(),
          ],
        ),
      ),
    );
  }
}
