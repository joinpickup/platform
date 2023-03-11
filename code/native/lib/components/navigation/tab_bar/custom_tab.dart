import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomTab extends StatefulWidget {
  const CustomTab({
    super.key,
    required this.label,
    this.small = false,
    required this.activeColor,
    required this.tab,
  });

  final String label;
  final bool small;
  final Color activeColor;
  final int tab;

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarBloc, TabBarState>(
      builder: (context, state) {
        final current = state.tab == widget.tab;

        return GestureDetector(
          onTapDown: (details) {
            setState(() {
              selected = true;
            });
          },
          onTapUp: (details) {
            setState(() {
              selected = false;
            });
          },
          onTapCancel: () {
            setState(() {
              selected = false;
            });
          },
          onTap: () {
            context.read<TabBarBloc>().add(ChangeTabBarTab(tab: widget.tab));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: current ? widget.activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: widget.small ? 16 : 20,
                color: TW3Colors.gray.shade300.withOpacity(selected ? .45 : 1),
              ),
            ),
          ),
        );
      },
    );
  }
}
