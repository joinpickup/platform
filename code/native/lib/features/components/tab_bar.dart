import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:local/features/home_screen.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TabChip(
              text: "Pinned",
              active: true,
            ),
            SizedBox(
              width: 8,
            ),
            TabChip(
              text: "Subscribed",
              active: false,
            ),
            SizedBox(
              width: 8,
            ),
            TabChip(
              text: "Discover",
              active: false,
            ),
            SizedBox(
              width: 8,
            ),
            TabChip(
              text: "Starred",
              active: false,
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class TabChip extends StatelessWidget {
  const TabChip({
    super.key,
    required this.text,
    required this.active,
  });

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
          cornerRadius: 8,
          cornerSmoothing: 0.6,
        )),
        color: active ? fColorRoyal : fColorSand,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? fColorSand : fColorRoyal,
          fontWeight: FontWeight.w900,
          fontSize: 15,
        ),
      ),
    );
  }
}
