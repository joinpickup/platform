import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/mocks/space.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/shared/subscribe/subscription_page.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

extension ExtendedWidgetList on List<Widget> {
  /// Insert [widget] between each member of this list
  List<Widget> insertBetween(Widget widget) {
    if (length > 1) {
      for (var i = length - 1; i > 0; i--) {
        insert(i, widget);
      }
    }

    return this;
  }
}

void showInterestsModal(
  BuildContext context,
  Function onSelect,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const InterestsModal();
    },
  );
}

class InterestsModal extends StatefulWidget {
  const InterestsModal({
    super.key,
  });

  @override
  State<InterestsModal> createState() => _InterestsModalState();
}

class _InterestsModalState extends State<InterestsModal> {
  Space activeSpace = musicSpace;
  Interest? interest;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: TW3Colors.gray.shade500,
                  ),
                  width: 64,
                  height: 4,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Space",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: allSpaces.map((value) {
                          return Row(
                            children: [
                              SpaceChip(
                                label: value.name,
                                tap: () {
                                  setState(() {
                                    activeSpace = value;
                                  });
                                },
                                active: value.spaceID == activeSpace.spaceID,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Interests",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  _buildInterestSearch(context),
                  const SizedBox(
                    height: 16,
                  ),
                  InterestGroup(
                    interests: allInterests,
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  tap: () {},
                  text: "Select",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonType: CustomButtonType.outlined,
                  tap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const SubscriptionPopup();
                      },
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(
                        HeroIcons.star,
                        style: HeroIconStyle.solid,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "New Interest",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestSearch(BuildContext context) {
    return CupertinoTextField(
      controller: _searchController,
      padding: const EdgeInsets.all(12),
      placeholder: "Search for an interest...",
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {},
      decoration: BoxDecoration(
        color: TW3Colors.gray.shade600,
        borderRadius: BorderRadius.circular(8),
      ),
      placeholderStyle: TextStyle(
        color: TW3Colors.gray.shade500,
        fontSize: 16,
        fontFamily: "Nunito",
      ),
      style: TextStyle(
        color: TW3Colors.gray.shade300,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class InterestGroup extends StatelessWidget {
  const InterestGroup({
    super.key,
    required this.interests,
  });

  final List<Interest> interests;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InterestChips(
            interests: interests,
          ),
        ],
      ),
    );
  }
}

class InterestChips extends StatelessWidget {
  const InterestChips({
    super.key,
    required this.interests,
  });

  final List<Interest> interests;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      // ignore: unnecessary_cast
      children: [
        ...interests.map(
          (interest) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  isError: false,
                  selected: false,
                  text: "#${interest.name}",
                  tap: () {},
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            );
          },
        ).toList(),
      ],
    );
  }
}

class Chip extends StatefulWidget {
  const Chip({
    super.key,
    required this.text,
    required this.tap,
    required this.selected,
    required this.isError,
  });

  final String text;
  final Function tap;
  final bool selected;
  final bool isError;

  @override
  State<Chip> createState() => _ChipState();
}

class _ChipState extends State<Chip> {
  bool selected = false;
  Color? color;

  @override
  void initState() {
    selected = widget.selected;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!selected) {
            HapticFeedback.lightImpact();
          }
          selected = !selected;
        });

        widget.tap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isError && selected
              ? TW3Colors.red.shade500
              : selected
                  ? Theme.of(context).colorScheme.primary
                  : TW3Colors.gray.shade600,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.isError && selected
                ? TW3Colors.gray.shade700
                : selected
                    ? TW3Colors.gray.shade700
                    : TW3Colors.gray.shade300,
          ),
        ),
      ),
    );
  }
}

class SpaceChip extends StatefulWidget {
  const SpaceChip({
    required this.label,
    this.active = false,
    required this.tap,
    super.key,
  });

  final String label;
  final Function tap;
  final bool active;

  @override
  State<SpaceChip> createState() => _SpaceChipState();
}

class _SpaceChipState extends State<SpaceChip> {
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
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.active
              ? Theme.of(context).colorScheme.secondary
              : TW3Colors.gray.shade600.withOpacity(selected ? .56 : 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            color: widget.active
                ? TW3Colors.gray.shade700
                : TW3Colors.gray.shade300,
          ),
        ),
      ),
    );
  }
}
