import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:local/constants/filters.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

List<int> availableLocations =
    List.generate(kLocationFilterEnd - kLocationFilterStart + 1, (index) {
  return index + kLocationFilterStart;
});

void showLocationModal(
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
      return LocationModal(
        onFilter: onFilter,
        onClear: onClear,
        start: start,
        end: end,
      );
    },
  );
}

class LocationModal extends StatefulWidget {
  const LocationModal({
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
  State<LocationModal> createState() => _LocationModalState();
}

class _LocationModalState extends State<LocationModal> {
  int start = kLocationFilterStart;
  int end = kLocationFilterEnd;

  FixedExtentScrollController _startPicker =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _endPicker = FixedExtentScrollController(
      initialItem: kLocationFilterEnd - kLocationFilterStart);

  @override
  void initState() {
    super.initState();

    start = widget.start;
    end = widget.end;
    _startPicker =
        FixedExtentScrollController(initialItem: start - kLocationFilterStart);
    _endPicker =
        FixedExtentScrollController(initialItem: end - kLocationFilterStart);
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
                width: 100,
                height: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$start miles - $end miles",
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
                        int valueWithOffset = value + kLocationFilterStart;

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
                                    .jumpToItem(end - kLocationFilterStart - 1);
                              });
                            }
                          });
                        } else {
                          setState(() {
                            start = valueWithOffset;
                          });
                        }
                      },
                      children: availableLocations.map((e) {
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
                        int valueWithOffset = value + kLocationFilterStart;

                        if (valueWithOffset <= start) {
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // need to check if the component is still mounted
                            if (mounted) {
                              setState(() {
                                // update current state and picker state
                                end = start + 1;

                                // need to account for the min offset with the picker
                                _endPicker.jumpToItem(
                                    start - kLocationFilterStart + 1);
                              });
                            }
                          });
                        } else {
                          setState(() {
                            end = valueWithOffset;
                          });
                        }
                      },
                      children: availableLocations.map((e) {
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
                      start = kLocationFilterStart;
                      end = kLocationFilterEnd;

                      // with offset
                      _startPicker.jumpToItem(start - kLocationFilterStart);
                      _endPicker.jumpToItem(end - kLocationFilterStart);
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
                    text: "Filter",
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
