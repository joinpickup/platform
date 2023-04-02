import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/constants/filters.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum SortOption {
  bestMatch(title: "Best Match"),
  recent(title: "Recent"),
  nearby(title: "Nearby"),
  mostComments(title: "Popular");

  final String title;

  const SortOption({required this.title});
}

void showSortModal(
  BuildContext context,
  Function onSort,
  Function onClear,
  SortOption sort,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    builder: (context) {
      return SortModal(
        onSort: onSort,
        onClear: onClear,
        sort: sort,
      );
    },
  );
}

class SortModal extends StatefulWidget {
  const SortModal({
    super.key,
    required this.onSort,
    required this.onClear,
    required this.sort,
  });

  final Function onSort;
  final Function onClear;
  final SortOption sort;

  @override
  State<SortModal> createState() => _SortModalState();
}

class _SortModalState extends State<SortModal> {
  SortOption? sortValue = kSort;

  @override
  void initState() {
    super.initState();
    sortValue = widget.sort;
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
                    "Sort",
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
            Column(
              children: SortOption.values.toList().map((e) {
                return RadioListTile(
                  value: e,
                  groupValue: sortValue,
                  title: Text(
                    e.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    12,
                  )),
                  onChanged: (value) {
                    setState(() {
                      sortValue = value;
                    });
                  },
                );
              }).toList(),
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
                      sortValue = kSort;
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
                      widget.onSort(sortValue);
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
                          "Sort",
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
