import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

extension ExtendedWidgetList on List<Widget> {
  /// Insert [widget] between each member of this list
  List<Widget> insertBetween(Widget widget) {
    if (length > 1) {
      for (var i = length - 1; i > 0; i--) {
        insert(i, widget);
      }
    }

    return this;
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    this.small = false,
    required this.tabs,
  });

  final bool small;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          bottom: BorderSide(
            color: TW3Colors.gray.shade500.withOpacity(.25),
            width: 1.0,
          ),
        ),
      ),
      height: small ? 50 : 65,
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.insertBetween(
            const SizedBox(
              width: 8,
            ),
          ),
        ),
      ),
    );
  }
}