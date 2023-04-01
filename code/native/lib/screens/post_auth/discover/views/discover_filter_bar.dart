import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/modals/age_modal.dart';
import 'package:local/components/modals/location_modal.dart';
import 'package:local/components/modals/sort_modal.dart';
import 'package:local/components/modals/space_modal/space_modal.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:local/shared/subscribe/subscription_page.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverFilterBar extends StatelessWidget {
  const DiscoverFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocConsumer<DiscoverScreenBloc, DiscoverScreenState>(
          listener: (context, state) {},
          builder: (context, discoverState) {
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
                    FilterItem(
                      tap: () {
                        showSpaceModal(
                          context,
                          (space) {
                            Navigator.of(context).pop();
                            context
                                .read<DiscoverScreenBloc>()
                                .add(FilterBySpace(space));
                          },
                          () {
                            Navigator.of(context).pop();
                            context
                                .read<DiscoverScreenBloc>()
                                .add(ResetSpaceFilterForPosts());
                          },
                          discoverState.spaceFilter.space,
                        );
                      },
                      active: discoverState.spaceFilter.enabled,
                      child: Row(
                        children: [
                          Text(discoverState.spaceFilter.enabled
                              ? discoverState.spaceFilter.space!.name
                              : "Space"),
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
                    FilterItem(
                      tap: () {
                        showSortModal(
                          context,
                          (SortOption sort) {
                            if (authState.user!.hasSubscription) {
                              context
                                  .read<DiscoverScreenBloc>()
                                  .add(SortPosts(sort));
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return const SubscriptionPopup();
                                },
                              ));
                            }
                          },
                          () {
                            context
                                .read<DiscoverScreenBloc>()
                                .add(ResetSortForPosts());
                          },
                          discoverState.sortState.sort,
                        );
                      },
                      active: discoverState.sortState.enabled,
                      child: Row(
                        children: [
                          const HeroIcon(
                            HeroIcons.star,
                            style: HeroIconStyle.solid,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(discoverState.sortState.enabled
                              ? discoverState.sortState.sort.title
                              : "Sort"),
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
                    FilterItem(
                      active: discoverState.locationFilter.enabled,
                      tap: () {
                        showLocationModal(
                          context,
                          (int start, int end) {
                            if (authState.user!.hasSubscription) {
                              context
                                  .read<DiscoverScreenBloc>()
                                  .add(FilterPostsByLocation(start, end));
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return const SubscriptionPopup();
                                },
                              ));
                            }
                          },
                          () {
                            context
                                .read<DiscoverScreenBloc>()
                                .add(ResetLocationFilterForPosts());
                          },
                          discoverState.locationFilter.start,
                          discoverState.locationFilter.end,
                        );
                      },
                      child: Row(
                        children: [
                          const HeroIcon(
                            HeroIcons.star,
                            style: HeroIconStyle.solid,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(discoverState.locationFilter.enabled
                              ? "${discoverState.locationFilter.start} mi - ${discoverState.locationFilter.end} mi"
                              : "Location"),
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
                    FilterItem(
                      active: discoverState.ageFilter.enabled,
                      tap: () {
                        showAgeModal(
                          context,
                          (int start, int end) {
                            if (authState.user!.hasSubscription) {
                              context
                                  .read<DiscoverScreenBloc>()
                                  .add(FilterPostsByAge(start, end));
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return const SubscriptionPopup();
                                  },
                                ),
                              );
                            }
                          },
                          () {
                            context
                                .read<DiscoverScreenBloc>()
                                .add(ResetAgeFilterForPosts());
                          },
                          discoverState.ageFilter.start,
                          discoverState.ageFilter.end,
                        );
                      },
                      child: Row(
                        children: [
                          const HeroIcon(
                            HeroIcons.star,
                            style: HeroIconStyle.solid,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(discoverState.ageFilter.enabled
                              ? "${discoverState.ageFilter.start}-${discoverState.ageFilter.end}"
                              : "Age"),
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
                    FilterItem(
                      tap: () {
                        context
                            .read<DiscoverScreenBloc>()
                            .add(ResetAllFilters());
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
  }
}

class FilterItem extends StatefulWidget {
  const FilterItem({
    super.key,
    required this.child,
    this.active = false,
    required this.tap,
  });

  final Widget child;
  final bool active;
  final Function tap;

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
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
