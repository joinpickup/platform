import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.primary,
        color: TW3Colors.gray.shade600,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: TW3Colors.gray.shade300),
      ),
    );
  }
}
