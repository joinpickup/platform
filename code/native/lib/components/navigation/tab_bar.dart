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
    required this.includeSettings,
  });

  final ValueNotifier<int> tab;
  final bool includeSettings;

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
          children: [
            CustomTab(
              label: "Posts",
              activeColor: Theme.of(context).colorScheme.secondary,
              active: tab,
              tab: 0,
            ),
            const SizedBox(
              width: 8,
            ),
            CustomTab(
              label: "Events",
              activeColor: Theme.of(context).colorScheme.primary,
              active: tab,
              tab: 1,
            ),
            const SizedBox(
              width: 8,
            ),
            CustomTab(
              activeColor: TW3Colors.gray.shade600,
              label: "Members",
              active: tab,
              tab: 2,
            ),
            includeSettings
                ? Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      CustomTab(
                        activeColor: TW3Colors.gray.shade600,
                        label: "Settings",
                        active: tab,
                        tab: 3,
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class CustomTab extends HookWidget {
  const CustomTab({
    super.key,
    required this.label,
    required this.active,
    required this.activeColor,
    required this.tab,
  });

  final String label;
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
            fontSize: 20,
            color:
                TW3Colors.gray.shade300.withOpacity(selected.value ? .45 : 1),
          ),
        ),
      ),
    );
  }
}
