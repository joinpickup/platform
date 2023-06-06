import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/constants/icons.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/general/general_group.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/bloc/space_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/models/space_row.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showSpaceFilterModal(
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
        value: context.read<SpaceFilterModalBloc>(),
        child: BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
          builder: (context, state) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: SpaceFilterModal(
                selected: state.selectedSpaces,
              ),
            );
          },
        ),
      );
    },
  );
}

class SpaceFilterModal extends StatefulWidget {
  const SpaceFilterModal({
    super.key,
    required this.selected,
  });

  final List<Space> selected;

  @override
  State<SpaceFilterModal> createState() => _SpaceFilterModalState();
}

class _SpaceFilterModalState extends State<SpaceFilterModal> {
  List<Space> selectedSpaces = [];

  @override
  void initState() {
    super.initState();

    selectedSpaces = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
      builder: (context, state) {
        switch (state.status) {
          case SpaceFilterModalStatus.success:
            return _buildSuccess(context);
          default:
            return _buildLogin(context);
        }
      },
    );
  }

  SafeArea _buildLogin(BuildContext context) {
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
                "Space",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TW3Colors.gray.shade400),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _buildSuccess(BuildContext context) {
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
                "Space",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TW3Colors.gray.shade400),
              ),
              _buildFilterGroup(),
              _buildButtons(context),
            ],
          ),
        ),
      ),
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
                  selectedSpaces = [];
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
                context.read<SpaceFilterModalBloc>().add(SaveSpaces(
                      spaces: selectedSpaces,
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

  Widget _buildFilterGroup() {
    return BlocBuilder<SpaceFilterModalBloc, SpaceFilterModalState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  GeneralGroup(
                    items: state.allSpaces!.map((e) {
                      // ignore: unnecessary_cast
                      return SpaceRow(
                        action: () {
                          addOrRemoveSpaceFromSpaceList(e);
                        },
                        icon: mapStringToHeroIcon(e.name),
                        name: e.name,
                        selected: selectedSpaces.contains(e),
                      ) as Widget;
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void addOrRemoveSpaceFromSpaceList(
    Space e,
  ) {
    var spaceExists = selectedSpaces.contains(e);
    List<Space> newSpaces = [];

    if (spaceExists) {
      newSpaces =
          selectedSpaces.where((space) => space.spaceID != e.spaceID).toList();
    } else {
      newSpaces = [...selectedSpaces];
      newSpaces.add(e);
    }

    setState(() {
      selectedSpaces = newSpaces;
    });
  }
}
