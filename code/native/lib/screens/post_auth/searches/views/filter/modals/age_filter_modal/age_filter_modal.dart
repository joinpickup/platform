import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showAgeFilterModal(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const FractionallySizedBox(
        heightFactor: 0.7,
        child: AgeFilterModal(),
      );
    },
  );
}

class AgeFilterModal extends StatefulWidget {
  const AgeFilterModal({
    super.key,
  });

  @override
  State<AgeFilterModal> createState() => _AgeFilterModalState();
}

class _AgeFilterModalState extends State<AgeFilterModal> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                "Age",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TW3Colors.gray.shade400),
              ),
              const SizedBox(
                height: 8,
              ),
              _buildFilter(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    tap: () {
                      Navigator.of(context).pop();
                    },
                    text: "Save",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildFilter() {
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
                    children: List.generate(100, (index) {
                      return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: TW3Colors.gray.shade600,
                          ),
                          child: Text("#test"));
                    }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
