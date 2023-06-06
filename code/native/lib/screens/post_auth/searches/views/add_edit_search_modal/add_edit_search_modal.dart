import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/interest_repository.dart';
import 'package:local/repos/space_repository.dart';
import 'package:local/screens/post_auth/searches/views/filter/filter.dart';
import 'package:local/screens/post_auth/searches/views/filter/filter_item.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/age_filter_modal/age_filter_modal.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/general/general_group.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/bloc/interest_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/interest_filter_modal.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/bloc/space_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/space_filter_modal.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum SearchModalType { add, edit }

void showAddEditSearchModal(
  BuildContext context,
  Search? search,
  SearchModalType modalType,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: AddEditSearchModal(
          search: search,
          modalType: modalType,
        ),
      );
    },
  );
}

class AddEditSearchModal extends StatefulWidget {
  const AddEditSearchModal({
    super.key,
    this.search,
    required this.modalType,
  });

  final Search? search;
  final SearchModalType modalType;

  @override
  State<AddEditSearchModal> createState() => _AddEditSearchModalState();
}

class _AddEditSearchModalState extends State<AddEditSearchModal> {
  // controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // description
  String titleText = "Create New Search";
  String buttonText = "Create";

  List<Interest>? interests;
  List<Filter> filters = [
    Filter(
      value: "",
      icon: HeroIcons.rectangleGroup,
      name: "Space",
      type: FilterType.space,
    ),
    Filter(
      icon: HeroIcons.tag,
      name: "Interests",
      value: "",
      type: FilterType.interests,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // set the values from the search
    if (widget.modalType == SearchModalType.edit) {
      _nameController.text = widget.search!.name;
      _descriptionController.text = widget.search!.description;
      titleText = "Edit Search";
      buttonText = "Edit";
    }
  }

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
      child: BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          titleText,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 22,
                                  ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMetadata(context),
                                const SizedBox(
                                  height: 16,
                                ),
                                _buildFilterGroups(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      tap: () {},
                      text: buttonText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildMetadata(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildName(context),
        const SizedBox(
          height: 16,
        ),
        _buildDescription(context),
      ],
    );
  }

  Widget _buildFilterGroups(BuildContext context) {
    return BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
      builder: (context, spaceState) {
        return BlocBuilder<InterestFilterModalBloc, InterestFilterModalState>(
          builder: (context, interestState) {
            return Column(
              children: [
                GeneralGroup(
                  name: "Active Filters",
                  // only get the active filters
                  items: filters.where(
                    (element) {
                      // TODO: refactor this its ugly
                      switch (element.name) {
                        case "Space":
                          return spaceState.selectedSpaces.isNotEmpty;
                        case "Interests":
                          return interestState.selectedInterests.isNotEmpty;
                        default:
                      }
                      return element.isActive;
                    },
                  ).map((e) {
                    // lets get the specific filter
                    Function modalAction = mapFilterTypeToModal(e);

                    // ignore: unnecessary_cast
                    return FilterItem(
                      icon: e.icon,
                      name: e.name,
                      action: () {
                        modalAction(context);
                      },
                    ) as Widget;
                  }).toList(),
                ),
                const SizedBox(
                  height: 16,
                ),
                GeneralGroup(
                  name: "Posible Filters",
                  items: filters.where(
                    (element) {
                      // TODO: refactor this its ugly
                      switch (element.name) {
                        case "Space":
                          return spaceState.selectedSpaces.isEmpty;
                        case "Interests":
                          return interestState.selectedInterests.isEmpty;
                        default:
                      }
                      return element.isActive;
                    },
                  ).map((e) {
                    Function modalAction = mapFilterTypeToModal(e);

                    // ignore: unnecessary_cast
                    return FilterItem(
                      icon: e.icon,
                      name: e.name,
                      action: () {
                        modalAction(context);
                      },
                    ) as Widget;
                  }).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Function mapFilterTypeToModal(
    Filter e,
  ) {
    switch (e.type) {
      case FilterType.space:
        return showSpaceFilterModal;
      case FilterType.interests:
        return showInterestFilterModal;
      case FilterType.age:
        return showAgeFilterModal;
      default:
        return showSpaceFilterModal;
    }
  }

  Column _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TW3Colors.gray.shade400),
        ),
        const SizedBox(
          height: 4,
        ),
        CupertinoTextField(
          controller: _descriptionController,
          padding: const EdgeInsets.all(12),
          onChanged: (value) {},
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          placeholder: "All posts related to tennis.",
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
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade600,
            borderRadius: BorderRadius.circular(8),
            border: null,
          ),
          maxLines: 4,
          minLines: 2,
        ),
      ],
    );
  }

  Column _buildName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TW3Colors.gray.shade400),
        ),
        const SizedBox(
          height: 4,
        ),
        CupertinoTextField(
          controller: _nameController,
          padding: const EdgeInsets.all(12),
          placeholder: "Tennis Posts",
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
        ),
      ],
    );
  }
}
