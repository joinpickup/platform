import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/navigator/post_auth/bottom_app_bar_item.dart';

class CustomBottomAppBar extends HookWidget {
  const CustomBottomAppBar(
      {super.key, required this.currentTab, required this.showBottomBar});

  final ValueNotifier<int> currentTab;
  final ValueNotifier<bool> showBottomBar;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      height: showBottomBar.value ? 100 : 0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -2),
            spreadRadius: -6,
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ],
      ),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          CustomBottomAppBarItem(
            index: 0,
            currentTab: currentTab,
            icon: HeroIcons.magnifyingGlass,
            label: "Discover",
          ),
          CustomBottomAppBarItem(
            index: 1,
            currentTab: currentTab,
            icon: HeroIcons.map,
            label: "Places",
          ),
          CustomBottomAppBarItem(
            index: 2,
            currentTab: currentTab,
            icon: HeroIcons.calendarDays,
            label: "Events",
          ),
          CustomBottomAppBarItem(
            index: 3,
            currentTab: currentTab,
            icon: HeroIcons.user,
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
