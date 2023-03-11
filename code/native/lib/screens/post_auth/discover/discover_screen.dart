import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/post_auth/post_auth_navigator/post_auth_navigator_bloc.dart';
import 'package:local/screens/post_auth/discover/views/discover_app_bar.dart';
import 'package:local/screens/post_auth/discover/views/discover_group_drawer/discover_group_drawer.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
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
        BlocProvider<PostFeedBloc>.value(
          value: BlocProvider.of(context),
        ),
        BlocProvider<PostAuthNavigatorBloc>.value(
          value: BlocProvider.of(context),
        ),
      ],
      child: _buildScreen(context, _searchController),
    );
  }

  Scaffold _buildScreen(
    BuildContext context,
    TextEditingController searchController,
  ) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DiscoverAppBar(
          onSearch: (value) {},
          searchController: searchController,
        ),
      ),
      onDrawerChanged: (isOpened) {
        context
            .read<PostAuthNavigatorBloc>()
            .add(UpdateBottomAppBar(showBottomAppBar: !isOpened));
      },
      drawer: const Drawer(
        child: GroupDrawer(),
      ),
      backgroundColor: TW3Colors.gray.shade600,
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
