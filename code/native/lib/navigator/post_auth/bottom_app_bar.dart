import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/navigator/post_auth/bottom_app_bar_item.dart';
import 'package:local/navigator/post_auth/post_auth_navigator/post_auth_navigator_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostAuthNavigatorBloc, PostAuthNavigatorState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          height: state.showBottomAppBar ? 100 : 0,
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
                index: 0,
                color: Theme.of(context).colorScheme.secondary,
                icon: HeroIcons.magnifyingGlass,
                label: "Discover",
              ),
              CustomBottomAppBarItem(
                index: 1,
                color: TW3Colors.red.shade400,
                icon: HeroIcons.map,
                label: "Places",
              ),
              CustomBottomAppBarItem(
                index: 2,
                color: Theme.of(context).colorScheme.primary,
                icon: HeroIcons.calendarDays,
                label: "Events",
              ),
              const CustomBottomAppBarItem(
                index: 3,
                color: TW3Colors.cyan,
                icon: HeroIcons.user,
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
