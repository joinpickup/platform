import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/constants/filters.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

List<int> availableAges =
    List.generate(kAgeFilterEnd - kAgeFilterStart + 1, (index) {
  return index + kAgeFilterStart;
});

void showAgeModal(
  BuildContext context,
  Function onFilter,
  Function onClear,
  int start,
  int end,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    builder: (context) {
      return AgeModal(
        onFilter: onFilter,
        onClear: onClear,
        start: start,
        end: end,
      );
    },
  );
}

class AgeModal extends StatefulWidget {
  const AgeModal({
    super.key,
    required this.onFilter,
    required this.onClear,
    required this.start,
    required this.end,
  });

  final Function onFilter;
  final Function onClear;
  final int start;
  final int end;

  @override
  State<AgeModal> createState() => _AgeModalState();
}

class _AgeModalState extends State<AgeModal> {
  int start = kAgeFilterStart;
  int end = kAgeFilterEnd;

  FixedExtentScrollController _startPicker =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _endPicker =
      FixedExtentScrollController(initialItem: kAgeFilterEnd - kAgeFilterStart);

  @override
  void initState() {
    super.initState();

    start = widget.start;
    end = widget.end;
    _startPicker =
        FixedExtentScrollController(initialItem: start - kAgeFilterStart);
    _endPicker =
        FixedExtentScrollController(initialItem: end - kAgeFilterStart);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    "Age",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$start-$end",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: _startPicker,
                      itemExtent: 32,
                      magnification: 1.22,
                      squeeze: 1.2,
                      onSelectedItemChanged: (value) {
                        // need to do this to account for min
                        int valueWithOffset = value + kAgeFilterStart;

                        if (valueWithOffset >= end) {
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // need to check if the component is still mounted
                            if (mounted) {
                              setState(() {
                                // update current state and picker state
                                start = end - 1;

                                // need to account for the min offset with the picker
                                _startPicker
                                    .jumpToItem(end - kAgeFilterStart - 1);
                              });
                            }
                          });
                        } else {
                          setState(() {
                            start = valueWithOffset;
                          });
                        }
                      },
                      children: availableAges.map((e) {
                        return Text(e.toString());
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController: _endPicker,
                      magnification: 1.22,
                      squeeze: 1.2,
                      onSelectedItemChanged: (value) {
                        // need to do this to account for min
                        int valueWithOffset = value + kAgeFilterStart;

                        if (valueWithOffset <= start) {
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // need to check if the component is still mounted
                            if (mounted) {
                              setState(() {
                                // update current state and picker state
                                end = start + 1;

                                // need to account for the min offset with the picker
                                _endPicker
                                    .jumpToItem(start - kAgeFilterStart + 1);
                              });
                            }
                          });
                        } else {
                          setState(() {
                            end = valueWithOffset;
                          });
                        }
                      },
                      children: availableAges.map((e) {
                        return Text(e.toString());
                      }).toList(),
                    ),
                  ),
                ],
              ),
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
                    setState(() {
                      start = kAgeFilterStart;
                      end = kAgeFilterEnd;

                      // with offset
                      _startPicker.jumpToItem(start - kAgeFilterStart);
                      _endPicker.jumpToItem(end - kAgeFilterStart);
                    });

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
                      widget.onFilter(start, end);
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
    );
  }
}
