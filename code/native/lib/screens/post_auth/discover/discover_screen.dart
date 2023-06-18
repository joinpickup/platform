import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/components/skelaton/post_card_skelaton.dart';
import 'package:local/components/snackbar/Snackbar.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/interest_repository.dart';
import 'package:local/repos/space_repository.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/discover/views/discover_app_bar.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/bloc/interest_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/bloc/space_filter_modal_bloc.dart';
import 'package:local/shared/service_bloc/service_bloc.dart';
import 'package:local/util/middleware/middleware.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'views/add_post/add_post_bloc.dart';

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
        BlocProvider(
          create: (context) => SpaceFilterModalBloc(
            SpaceRepository(),
          )..add(LoadSpaces()),
        ),
        BlocProvider(
          create: (context) {
            // we need to get the platform service from the state
            final platformService =
                (context.read<ServiceBloc>().state as PlatformServiceState?)
                    ?.platformService as ServiceInstance;

            return InterestFilterModalBloc(
              InterestRepository(
                platformService: platformService,
              ),
            )..add(LoadInterests());
          },
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
        return BlocListener<AddPostBloc, AddPostState>(
          listener: (context, addPostState) {
            if (addPostState.status == AddPostStatus.success) {
              context.read<DiscoverScreenBloc>().add(
                    LoadPosts(
                      query: "",
                      interests: const [],
                      spaces: const [],
                    ),
                  );
            }
          },
          child: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    DiscoverScreenState state,
  ) {
    return BlocBuilder<InterestFilterModalBloc, InterestFilterModalState>(
      builder: (context, interestFilterModalBlocState) {
        return BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
          builder: (context, spaceFilterModalBlocState) {
            return SafeArea(
              child: Container(
                color: TW3Colors.gray.shade600,
                child: Column(
                  children: [
                    const DiscoverAppBar(),
                    state.feedStatus == DiscoverFeedStatus.success
                        ? PostFeed(
                            posts: state.screenStatus ==
                                    DiscoverScreenStatus.searching
                                ? state.postSearch as List<Post>
                                : state.postFeed as List<Post>,
                            refreshController: _refreshController,
                            scrollController: scrollController,
                            canLoad: true,
                            canRefresh: state.screenStatus !=
                                DiscoverScreenStatus.searching,
                            onRefresh: () {
                              context.read<DiscoverScreenBloc>().add(
                                    HandleRefresh(
                                      refreshController: _refreshController,
                                      query: state.searchQuery,
                                      interests: interestFilterModalBlocState
                                          .selectedInterests,
                                      spaces: spaceFilterModalBlocState
                                          .selectedSpaces,
                                    ),
                                  );
                            },
                            onLoad: () {
                              context
                                  .read<DiscoverScreenBloc>()
                                  .add(HandleLoadMore(
                                    refreshController: _refreshController,
                                    query: state.searchQuery,
                                    interests: interestFilterModalBlocState
                                        .selectedInterests,
                                    spaces: spaceFilterModalBlocState
                                        .selectedSpaces,
                                  ));
                            },
                          )
                        : const PostCardSkelaton(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
