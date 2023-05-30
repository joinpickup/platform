import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/navigator/post_auth/bottom_app_bar_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final Function onTap;
  final int currentIndex;

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  var hasMessage = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(
            color: TW3Colors.gray.shade500.withOpacity(.25),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          CustomBottomAppBarItem(
            onTap: (index) {
              widget.onTap(index);
              setState(() {
                hasMessage = true;
              });
            },
            index: 0,
            currentIndex: widget.currentIndex,
            color: TW3Colors.gray.shade300,
            icon: HeroIcons.magnifyingGlass,
            label: "Discover",
          ),
          CustomBottomAppBarItem(
            onTap: (index) {
              widget.onTap(index);
              setState(() {
                hasMessage = false;
              });
            },
            currentIndex: widget.currentIndex,
            index: 1,
            color: TW3Colors.gray.shade300,
            icon: HeroIcons.chatBubbleBottomCenter,
            label: "Messages",
            hasBadge: hasMessage,
          ),
          CustomBottomAppBarItem(
            onTap: widget.onTap,
            currentIndex: widget.currentIndex,
            index: 2,
            color: TW3Colors.gray.shade300,
            icon: HeroIcons.user,
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
