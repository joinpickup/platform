import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

int min = 18;
int max = 80;
List<int> availableAges = List.generate(max - min + 1, (index) {
  return index + min;
});

void showAgeModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    builder: (context) {
      return const AgeModal();
    },
  );
}

class AgeModal extends StatefulWidget {
  const AgeModal({
    super.key,
  });

  @override
  State<AgeModal> createState() => _AgeModalState();
}

class _AgeModalState extends State<AgeModal> {
  int start = min;
  int end = max;

  final FixedExtentScrollController _startPicker =
      FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController _endPicker =
      FixedExtentScrollController(initialItem: max - min);

  @override
  void initState() {
    super.initState();
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
                        int valueWithOffset = value + min;

                        if (valueWithOffset >= end) {
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // need to check if the component is still mounted
                            if (mounted) {
                              setState(() {
                                // update current state and picker state
                                start = end - 1;

                                // need to account for the min offset with the picker
                                _startPicker.jumpToItem(end - min - 1);
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
                        int valueWithOffset = value + min;

                        if (valueWithOffset <= start) {
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // need to check if the component is still mounted
                            if (mounted) {
                              setState(() {
                                // update current state and picker state
                                end = start + 1;

                                // need to account for the min offset with the picker
                                _endPicker.jumpToItem(start - min + 1);
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
                      start = min;
                      end = max;

                      // with offset
                      _startPicker.jumpToItem(start - min);
                      _endPicker.jumpToItem(end - min);
                    });
                  },
                  text: "Clear",
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomButton(
                    tap: () {},
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
