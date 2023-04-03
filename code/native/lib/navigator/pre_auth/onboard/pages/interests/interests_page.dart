import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/interests/interests_page_bloc.dart';
import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/models/space/interest.dart';
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

class SelectInterestPage extends StatefulWidget {
  const SelectInterestPage({Key? key}) : super(key: key);

  @override
  State<SelectInterestPage> createState() => _SelectInterestPageState();
}

class _SelectInterestPageState extends State<SelectInterestPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InterestsPageBloc, InterestsPageState>(
      listener: (context, state) {
        if (state.status == InterestsPageStatus.success) {
          context.read<InterestsPageBloc>().add(ResetValidation());
          context.read<OnboardBloc>().add(HandleNextPage());
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Please select 5 interests",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Don't worry you'll be able to choose more later, this is just to get us started.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [],
                  ),
                ],
              ),
            ),
            state.status != InterestsPageStatus.error
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          tap: () {
                            context.read<InterestsPageBloc>().add(
                                  SubmitInterests(),
                                );
                          },
                          text: "Continue",
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        );
      },
    );
  }
}

class InterestGroup extends StatelessWidget {
  const InterestGroup({
    super.key,
    required this.name,
    required this.interests,
  });

  final String name;
  final List<Interest> interests;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
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
    return BlocBuilder<InterestsPageBloc, InterestsPageState>(
      builder: (context, state) {
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
                      isError: state.status == InterestsPageStatus.error,
                      selected: state.interests.contains(interest),
                      text: "#${interest.name}",
                      tap: () {
                        context
                            .read<InterestsPageBloc>()
                            .add(ToggleInterest(interest));
                      },
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
      },
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
    return BlocBuilder<InterestsPageBloc, InterestsPageState>(
      builder: (context, state) {
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
      },
    );
  }
}
