import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/modals/age_modal.dart';
import 'package:local/components/modals/all_filters_modal.dart';
import 'package:local/components/modals/location_modal.dart';
import 'package:local/components/modals/sort_modal.dart';
import 'package:local/components/modals/space_modal.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:local/shared/subscribe/subscription_page.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverFilterBar extends StatelessWidget {
  const DiscoverFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
                    showAllFiltersModal(context);
                  },
                  active: false,
                  child: const HeroIcon(HeroIcons.adjustmentsHorizontal),
                ),
                const SizedBox(
                  width: 8,
                ),
                FilterItem(
                  tap: () {
                    showSortModal(context);
                  },
                  active: false,
                  child: Row(
                    children: const [
                      Text("Sort"),
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
                FilterItem(
                  tap: () {
                    showSpaceModal(context);
                  },
                  active: false,
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
                FilterItem(
                  tap: () {
                    if (state.user!.hasSubscription) {
                      showLocationModal(context);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return const SubscriptionPopup();
                        },
                      ));
                    }
                  },
                  active: false,
                  child: Row(
                    children: const [
                      HeroIcon(
                        HeroIcons.star,
                        style: HeroIconStyle.solid,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Location"),
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
                FilterItem(
                  tap: () {
                    showAgeModal(context);
                  },
                  active: false,
                  child: Row(
                    children: const [
                      HeroIcon(
                        HeroIcons.star,
                        style: HeroIconStyle.solid,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Age"),
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class FilterItem extends StatefulWidget {
  const FilterItem({
    super.key,
    required this.child,
    required this.active,
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
