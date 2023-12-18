import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/color.dart';
import 'package:local/views/home/home_screen/components/tab_bar/cubit/tab_bar_cubit.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, TabBarTab>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: TabBarTab.values.map((tab) {
                return Row(
                  children: [
                    TabChip(
                      tab: tab,
                      active: tab == state,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class TabChip extends StatelessWidget {
  const TabChip({
    super.key,
    required this.active,
    required this.tab,
    this.disabled = false,
  });

  final TabBarTab tab;
  final bool active;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {if (!disabled) context.read<TabBarCubit>().changeTab(tab)},
      child: Container(
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
            cornerRadius: 8,
            cornerSmoothing: 0.6,
          )),
          color: disabled
              ? kColorSand
              : active
                  ? kColorRoyal
                  : kColorSand,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Text(
          tab.text,
          style: TextStyle(
            color: disabled
                ? kColorSand
                : active
                    ? kColorSand
                    : kColorRoyal,
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
