import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/navigator/post_auth/bottom_app_bar.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_screen.dart';
import 'package:local/screens/post_auth/core/events_screen/events_screen.dart';
import 'package:local/screens/post_auth/core/places_screen/places_screen.dart';
import 'package:local/screens/post_auth/core/profile_screen/profile_screen.dart';

class PostAuthNavigator extends HookWidget {
  const PostAuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showBottomBar = useState(true);
    final tab = useState(0);
    final items = useState([
      DiscoverScreen(
        showBottomBar: showBottomBar,
      ),
      const PlacesScreen(),
      EventsScreen(),
      const ProfileScreen()
    ]);

    return Scaffold(
      body: items.value[tab.value],
      bottomNavigationBar: CustomBottomAppBar(
        currentTab: tab,
        showBottomBar: showBottomBar,
      ),
    );
  }
}
