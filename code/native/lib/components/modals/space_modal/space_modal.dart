import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/modals/space_modal/space_bloc.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/repos/space_repository.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showSpaceModal(
  BuildContext context,
  Function onFilter,
  Function onClear,
  Space? space,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    builder: (context) {
      return SpaceModal(
        onFilter: onFilter,
        onClear: onClear,
        space: space,
      );
    },
  );
}

class SpaceModal extends StatefulWidget {
  const SpaceModal({
    super.key,
    required this.onFilter,
    required this.onClear,
    required this.space,
  });

  final Function onFilter;
  final Function onClear;
  final Space? space;

  @override
  State<SpaceModal> createState() => _SpaceModalState();
}

class _SpaceModalState extends State<SpaceModal> {
  Space? space;

  FixedExtentScrollController _startPicker =
      FixedExtentScrollController(initialItem: 0);

  @override
  void initState() {
    super.initState();

    space = widget.space;
    if (widget.space != null) {
      _startPicker =
          FixedExtentScrollController(initialItem: widget.space!.spaceID - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpaceBloc(SpaceRepository())..add(LoadSpaces()),
      child: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(8),
          width: double.infinity,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Space",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 26,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocConsumer<SpaceBloc, SpaceState>(
                listener: (context, state) {
                  if (state.spaceStatus == SpaceStatus.success) {
                    setState(() {
                      space = state.spaces![0];
                    });
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        state.spaceStatus != SpaceStatus.success
                            ? const CupertinoActivityIndicator()
                            : Expanded(
                                child: CupertinoPicker(
                                  scrollController: _startPicker,
                                  itemExtent: 32,
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  onSelectedItemChanged: (value) {
                                    // need to do this to account for min
                                    setState(() {
                                      space = state.spaces?[value];
                                    });
                                  },
                                  children: state.spaces!.map((e) {
                                    return Text(e.name);
                                  }).toList(),
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomButton(
                    buttonType: CustomButtonType.outlined,
                    tap: () {
                      widget.onClear();
                    },
                    text: "Clear",
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomButton(
                      tap: () {
                        if (space != null) {
                          // TODO: handle error state
                          widget.onFilter(space);
                        }
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
                            "Filter",
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
