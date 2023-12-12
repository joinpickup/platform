import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/color.dart';
import 'package:local/views/home/components/tab_bar/cubit/tab_bar_cubit.dart';

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
                      text: tab.name,
                      update: context.read<TabBarCubit>().changeTab,
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
    required this.text,
    required this.active,
    required this.update,
    required this.tab,
  });

  final TabBarTab tab;
  final String text;
  final bool active;
  final Function update;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => update(tab),
      child: Container(
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
            cornerRadius: 8,
            cornerSmoothing: 0.6,
          )),
          color: active ? kColorRoyal : kColorSand,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? kColorSand : kColorRoyal,
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
