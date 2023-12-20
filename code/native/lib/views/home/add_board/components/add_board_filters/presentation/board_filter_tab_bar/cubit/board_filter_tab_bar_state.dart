part of 'board_filter_tab_bar_cubit.dart';

enum BoardFilterTabBarTab {
  tags(text: "Tags"),
  distance(text: "Distance"),
  time(text: "Time");

  final String text;

  const BoardFilterTabBarTab({required this.text});
}
