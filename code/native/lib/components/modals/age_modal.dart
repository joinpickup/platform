import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

double min = 18;
double max = 80;

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
  RangeValues _currentRangeValues = RangeValues(min, max);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                  Text(
                    "${_currentRangeValues.start.round()}-${_currentRangeValues.end.round()}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                        ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            RangeSlider(
              divisions: max.round() - min.round(),
              onChanged: (values) {
                HapticFeedback.lightImpact();
                setState(() {
                  _currentRangeValues = values;
                });
              },
              min: min,
              max: max,
              values: _currentRangeValues,
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
                      _currentRangeValues = RangeValues(min, max);
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
