import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/post_auth/bottom_app_bar.dart';
import 'package:local/navigator/post_auth/post_auth_navigator/post_auth_navigator_bloc.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/discover_screen.dart';
import 'package:local/screens/post_auth/events/events_screen.dart';
import 'package:local/screens/post_auth/places/places_screen.dart';
import 'package:local/screens/post_auth/profile/profile_screen.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';

class PostAuthNavigator extends StatefulWidget {
  const PostAuthNavigator({Key? key}) : super(key: key);

  @override
  State<PostAuthNavigator> createState() => _PostAuthNavigatorState();
}

class _PostAuthNavigatorState extends State<PostAuthNavigator> {
  List<Widget> items = [];
  final _postRepository = PostRepository();

  @override
  void initState() {
    super.initState();

    items = [
      const DiscoverScreen(),
      const PlacesScreen(),
      const EventsScreen(),
      const ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostFeedBloc>(
          create: (context) => PostFeedBloc(_postRepository)..add(LoadPosts()),
        ),
        BlocProvider<PostAuthNavigatorBloc>(
          create: (context) => PostAuthNavigatorBloc()..add(InitializePage()),
        ),
        BlocProvider<EventFeedBloc>(
          create: (context) => EventFeedBloc()..add(LoadEvents()),
        ),
      ],
      child: BlocBuilder<PostAuthNavigatorBloc, PostAuthNavigatorState>(
        builder: (context, state) {
          return Scaffold(
            body: items[state.tab],
            bottomNavigationBar: const CustomBottomAppBar(),
          );
        },
      ),
    );
  }
}
