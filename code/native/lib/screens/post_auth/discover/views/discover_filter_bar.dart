import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/repos/interest_repository.dart';
import 'package:local/repos/space_repository.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/bloc/interest_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/interest_filter_modal.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/bloc/space_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/space_filter_modal.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverFilterBar extends StatefulWidget {
  const DiscoverFilterBar({Key? key}) : super(key: key);

  @override
  State<DiscoverFilterBar> createState() => _DiscoverFilterBarState();
}

class _DiscoverFilterBarState extends State<DiscoverFilterBar> {
  var hasBadge = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SpaceFilterModalBloc(
            SpaceRepository(),
          )..add(LoadSpaces()),
        ),
        BlocProvider(
          create: (context) => InterestFilterModalBloc(
            InterestRepository(),
          )..add(LoadIntersts()),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<DiscoverScreenBloc, DiscoverScreenState>(
            builder: (context, discoverState) {
              return BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
                builder: (context, spaceFilterModalState) {
                  return BlocBuilder<InterestFilterModalBloc,
                      InterestFilterModalState>(
                    builder: (context, interestFilterModalState) {
                      return Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FilterChip(
                                tap: () {
                                  showSpaceFilterModal(context);
                                },
                                active: spaceFilterModalState
                                    .selectedSpaces.isNotEmpty,
                                child: Row(
                                  children: const [
                                    Text("Space"),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    HeroIcon(
                                      HeroIcons.chevronDown,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              FilterChip(
                                tap: () {
                                  showInterestFilterModal(context);
                                },
                                active: interestFilterModalState
                                    .selectedInterests.isNotEmpty,
                                child: Row(
                                  children: const [
                                    Text("Interests"),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    HeroIcon(
                                      HeroIcons.chevronDown,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              FilterChip(
                                tap: () {
                                  context
                                      .read<InterestFilterModalBloc>()
                                      .add(ClearInterests());

                                  context
                                      .read<SpaceFilterModalBloc>()
                                      .add(ClearSpaces());
                                },
                                child: const Text("Clear Filters"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class FilterChip extends StatefulWidget {
  const FilterChip({
    super.key,
    required this.child,
    this.active = false,
    required this.tap,
  });

  final Widget child;
  final bool active;
  final Function tap;

  @override
  State<FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<FilterChip> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
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
        HapticFeedback.lightImpact();
        widget.tap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: widget.active
              ? Theme.of(context).colorScheme.secondary
              : TW3Colors.gray.shade600.withOpacity(selected ? 0.5 : 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            widget.child,
          ],
        ),
      ),
    );
  }
}
