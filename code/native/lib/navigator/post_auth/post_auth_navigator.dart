import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/post_auth/bottom_app_bar.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/discover/discover_screen.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/screens/post_auth/messages/messages_screen.dart';
import 'package:local/screens/post_auth/profile/profile_screen.dart';
import 'package:local/screens/post_auth/searches/searches_screen.dart';
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
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();

    items = [
      const DiscoverScreen(),
      const SearchesScreen(),
      const MessagesScreen(),
      const ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DiscoverScreenBloc(
            context.read<AddPostBloc>().state.postRepository,
          )..add(
              LoadPosts(
                query: "",
                interests: const [],
                spaces: const [],
              ),
            ),
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
