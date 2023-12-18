part of 'tab_bar_cubit.dart';

enum TabBarTab {
  pinned(text: "Pinned"),
  following(text: "Following"),
  discover(text: "Discover"),
  starred(text: "Starred"),
  created(text: "Created");

  final String text;

  const TabBarTab({required this.text});
}
