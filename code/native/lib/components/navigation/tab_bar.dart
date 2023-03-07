import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class CustomTabBar extends HookWidget {
  const CustomTabBar({
    super.key,
    required this.tab,
    this.small = false,
    required this.tabs,
  });

  final ValueNotifier<int> tab;
  final bool small;
  final List<CustomTabModel> tabs;

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
      height: 65,
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs
              // ignore: unnecessary_cast
              .map((e) => CustomTab(
                    active: tab,
                    activeColor: e.activeColor,
                    tab: e.tab,
                    label: e.label,
                    small: small,
                  ) as Widget)
              .toList()
              .insertBetween(
                const SizedBox(
                  width: 8,
                ),
              ),
        ),
      ),
    );
  }
}

class CustomTabModel {
  const CustomTabModel({
    required this.label,
    required this.activeColor,
    required this.tab,
  });

  final String label;
  final Color activeColor;
  final int tab;
}

class CustomTab extends HookWidget {
  const CustomTab({
    super.key,
    required this.label,
    this.small = false,
    required this.active,
    required this.activeColor,
    required this.tab,
  });

  final String label;
  final bool small;
  final ValueNotifier<int> active;
  final Color activeColor;
  final int tab;

  @override
  Widget build(BuildContext context) {
    final current = active.value == tab;

    final selected = useState(false);

    return GestureDetector(
      onTapDown: (details) {
        selected.value = true;
      },
      onTapUp: (details) {
        selected.value = false;
      },
      onTapCancel: () {
        selected.value = false;
      },
      onTap: () {
        active.value = tab;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: current ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: small ? 16 : 20,
            color:
                TW3Colors.gray.shade300.withOpacity(selected.value ? .45 : 1),
          ),
        ),
      ),
    );
  }
}
