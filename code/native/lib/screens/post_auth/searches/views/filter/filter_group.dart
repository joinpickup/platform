import 'package:flutter/material.dart';
import 'package:local/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class FilterGroup extends StatefulWidget {
  const FilterGroup({
    Key? key,
    this.name,
    required this.filters,
  }) : super(key: key);

  final String? name;
  final List<Widget> filters;

  @override
  State<FilterGroup> createState() => _FilterGroupState();
}

class _FilterGroupState extends State<FilterGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.name != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name as String,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: TW3Colors.gray.shade400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              )
            : Container(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: TW3Colors.gray.shade500.withOpacity(.25),
              width: 2.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.filters.insertBetween(
              const SizedBox(
                height: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
