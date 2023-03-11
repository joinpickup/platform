import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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

class CustomTab extends StatefulWidget {
  const CustomTab({
    super.key,
    required this.label,
    this.small = false,
    required this.active,
    required this.activeColor,
    required this.tab,
    required this.setActive,
  });

  final String label;
  final bool small;
  final int active;
  final Color activeColor;
  final int tab;
  final Function(int) setActive;

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final current = widget.active == widget.tab;

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
        widget.setActive(widget.tab);
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
  }
}
