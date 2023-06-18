import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<DiscoverScreenBloc, DiscoverScreenState>(
          builder: (context, discoverState) {
            return BlocConsumer<SpaceFilterModalBloc, SpaceFilterModalState>(
              listener: (context, spaceFilterModalState) {
                // this is the logic around saving filters from a search perspective
                if (spaceFilterModalState.saveStatus ==
                    SpaceFilterModalSaveStatus.save) {
                  context.read<DiscoverScreenBloc>().add(
                        SearchPosts(
                          query: discoverState.searchQuery,
                          interests: discoverState.interestsFilter,
                          spaces: spaceFilterModalState.selectedSpaces,
                        ),
                      );
                }
              },
              builder: (context, spaceFilterModalState) {
                return BlocConsumer<InterestFilterModalBloc,
                    InterestFilterModalState>(
                  listener: (context, interestFilterState) {
                    // this is the logic around saving filters from a search perspective
                    if (interestFilterState.saveStatus ==
                        InterestsFilterModalSaveStatus.save) {
                      context.read<DiscoverScreenBloc>().add(
                            SearchPosts(
                              query: discoverState.searchQuery,
                              interests: interestFilterState.selectedInterests,
                              spaces: discoverState.spacesFilter,
                            ),
                          );
                    }
                  },
                  builder: (context, interestFilterState) {
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
                                children: [
                                  Text(
                                    spaceFilterModalState.selectedSpaces.isEmpty
                                        ? "Space"
                                        : spaceFilterModalState
                                                    .selectedSpaces.length >
                                                2
                                            ? "Selected ${spaceFilterModalState.selectedSpaces.length} spaces"
                                            : spaceFilterModalState
                                                .selectedSpaces
                                                .map((e) {
                                                  return e.name;
                                                })
                                                .toList()
                                                .join(", "),
                                    style: TextStyle(
                                      color: interestFilterState
                                              .selectedInterests.isEmpty
                                          ? TW3Colors.gray.shade200
                                          : TW3Colors.gray.shade300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const HeroIcon(
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
                              active: interestFilterState
                                  .selectedInterests.isNotEmpty,
                              child: Row(
                                children: [
                                  Text(
                                    interestFilterState
                                            .selectedInterests.isEmpty
                                        ? "Interests"
                                        : interestFilterState
                                                    .selectedInterests.length >
                                                2
                                            ? "Selected ${interestFilterState.selectedInterests.length} interests"
                                            : interestFilterState
                                                .selectedInterests
                                                .map((e) {
                                                  return "#${e.name}";
                                                })
                                                .toList()
                                                .join(", "),
                                    style: TextStyle(
                                      color: interestFilterState
                                              .selectedInterests.isEmpty
                                          ? TW3Colors.gray.shade200
                                          : TW3Colors.gray.shade300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const HeroIcon(
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
