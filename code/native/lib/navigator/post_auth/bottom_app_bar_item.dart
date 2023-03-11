import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/navigator/post_auth/post_auth_navigator/post_auth_navigator_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/services.dart';

class CustomBottomAppBarItem extends StatefulWidget {
  const CustomBottomAppBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.index,
  });

  final HeroIcons icon;
  final String label;
  final Color color;
  final int index;

  @override
  State<CustomBottomAppBarItem> createState() => _CustomBottomAppBarItemState();
}

class _CustomBottomAppBarItemState extends State<CustomBottomAppBarItem> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostAuthNavigatorBloc, PostAuthNavigatorState>(
      builder: (context, state) {
        active = state.tab == widget.index;

        return Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              context
                  .read<PostAuthNavigatorBloc>()
                  .add(ChangeTab(tab: widget.index));
              HapticFeedback.lightImpact();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: active ? TW3Colors.gray.shade700 : Colors.transparent,
              ),
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Expanded(
                    child: HeroIcon(
                      widget.icon,
                      color: active ? widget.color : TW3Colors.gray.shade500,
                      size: active ? 28 : 22,
                      style:
                          active ? HeroIconStyle.solid : HeroIconStyle.outline,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: active ? widget.color : TW3Colors.gray.shade500,
                        fontSize: active ? 12 : 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
