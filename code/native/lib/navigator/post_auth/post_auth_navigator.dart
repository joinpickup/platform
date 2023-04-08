import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/post_auth/bottom_app_bar.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/discover/discover_screen.dart';
import 'package:local/screens/post_auth/events/events_screen.dart';
import 'package:local/screens/post_auth/places/places_screen.dart';
import 'package:local/screens/post_auth/profile/profile_screen.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PostAuthNavigator extends StatefulWidget {
  const PostAuthNavigator({Key? key}) : super(key: key);

  @override
  State<PostAuthNavigator> createState() => _PostAuthNavigatorState();
}

class _PostAuthNavigatorState extends State<PostAuthNavigator> {
  List<Widget> items = [];
  int currentIndex = 0;
  final _postRepository = PostRepository();
  final _pageController = PageController();

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
        BlocProvider(
          create: (context) =>
              DiscoverScreenBloc(_postRepository)..add(LoadPosts()),
        ),
        BlocProvider(
          create: (context) => EventFeedBloc()..add(LoadEvents()),
        ),
      ],
      child: Scaffold(
        backgroundColor: TW3Colors.gray.shade700,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: items,
        ),
        bottomNavigationBar: CustomBottomAppBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
            _pageController.jumpToPage(value);
          },
        ),
      ),
    );
  }
}
