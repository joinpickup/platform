import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showSnackBar(
  BuildContext context,
  String error,
) {
  final snackBar = SnackBar(
    content: Container(
      decoration: BoxDecoration(
        color: TW3Colors.red.shade400,
        borderRadius: BorderRadius.circular(8),
        border: Border.fromBorderSide(
          BorderSide(
            color: TW3Colors.red.shade600,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          HeroIcon(
            HeroIcons.informationCircle,
            color: TW3Colors.red.shade700,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            "Warning!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TW3Colors.red.shade700,
                ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: TW3Colors.gray.shade800,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    ),
    elevation: 0,
    width: double.infinity,
    backgroundColor: Colors.transparent,
    duration: const Duration(milliseconds: 600),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
