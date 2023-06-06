import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/bloc/interest_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/interest_chip.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showInterestFilterModal(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<InterestFilterModalBloc>(),
        child: BlocBuilder<InterestFilterModalBloc, InterestFilterModalState>(
          builder: (context, state) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: InterestFilterModal(
                selected: state.selectedInterests,
              ),
            );
          },
        ),
      );
    },
  );
}

class InterestFilterModal extends StatefulWidget {
  const InterestFilterModal({
    super.key,
    required this.selected,
  });

  final List<Interest> selected;

  @override
  State<InterestFilterModal> createState() => _InterestFilterModalState();
}

class _InterestFilterModalState extends State<InterestFilterModal> {
  final _searchController = TextEditingController();
  List<Interest> selectedInterests = [];

  @override
  void initState() {
    super.initState();

    selectedInterests = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterestFilterModalBloc, InterestFilterModalState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
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
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Interests",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: TW3Colors.gray.shade400),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: selectedInterests.map((interest) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedInterests = selectedInterests.where(
                                  (i) {
                                    return interest.interestID != i.interestID;
                                  },
                                ).toList();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Text(
                                "#${interest.name}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: TW3Colors.gray.shade300,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildSearchBar(context),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildInterests(),
                  _buildButtons(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              buttonType: CustomButtonType.outlined,
              tap: () {
                setState(() {
                  selectedInterests = [];
                });
              },
              text: "Clear",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              tap: () {
                context.read<InterestFilterModalBloc>().add(SaveInterests(
                      interests: selectedInterests,
                    ));

                Navigator.of(context).pop();
              },
              text: "Save",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    return BlocBuilder<InterestFilterModalBloc, InterestFilterModalState>(
      builder: (context, state) {
        switch (state.status) {
          case InterestsFilterModalStatus.loading:
            return _buildLoading(state);
          default:
            return _buildSuccess(state);
        }
      },
    );
  }

  Expanded _buildLoading(InterestFilterModalState state) {
    return Expanded(
      child: ListView(
        children: const [
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Expanded _buildSuccess(InterestFilterModalState state) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: state.allInterests!.where((interest) {
                      return !selectedInterests.contains(interest);
                    }).map((interest) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedInterests = [
                              ...selectedInterests,
                              interest
                            ];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: TW3Colors.gray.shade600,
                          ),
                          child: Text(
                            "#${interest.name}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: TW3Colors.gray.shade300,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  CupertinoTextField _buildSearchBar(BuildContext context) {
    return CupertinoTextField(
      controller: _searchController,
      padding: const EdgeInsets.all(12),
      placeholder: "Search for an #interest...",
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
