import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/core/discover_screen/discover_screen.dart';
import 'package:local/screens/post_auth/core/events_screen/events_screen.dart';
import 'package:local/screens/post_auth/core/places_screen/places_screen.dart';
import 'package:local/screens/post_auth/core/profile_screen/profile_screen.dart';

class PostAuthNavigator extends HookWidget {
  const PostAuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tab = useState(0);
    final items = useState([
      const DiscoverScreen(),
      const PlacesScreen(),
      const EventsScreen(),
      const ProfileScreen()
    ]);

    return Scaffold(
      body: items.value[tab.value],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: tab.value,
        onTap: (value) {
          tab.value = value;
        },
        items: const [
          BottomNavigationBarItem(
            label: "Discover",
            icon: HeroIcon(
              HeroIcons.magnifyingGlass,
            ),
            activeIcon: HeroIcon(
              HeroIcons.magnifyingGlass,
              style: HeroIconStyle.solid,
            ),
          ),
          BottomNavigationBarItem(
            label: "Places",
            icon: HeroIcon(
              HeroIcons.map,
            ),
            activeIcon: HeroIcon(
              HeroIcons.map,
              style: HeroIconStyle.solid,
            ),
          ),
          BottomNavigationBarItem(
            label: "Events",
            icon: HeroIcon(
              HeroIcons.calendarDays,
            ),
            activeIcon: HeroIcon(
              HeroIcons.calendarDays,
              style: HeroIconStyle.solid,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: HeroIcon(
              HeroIcons.user,
            ),
            activeIcon: HeroIcon(
              HeroIcons.user,
              style: HeroIconStyle.solid,
            ),
          ),
        ],
      ),
    );
  }
}
