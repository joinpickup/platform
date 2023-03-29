import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showSpaceModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    builder: (context) {
      return const SpaceModal();
    },
  );
}

class SpaceModal extends StatelessWidget {
  const SpaceModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
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
        ],
      ),
    );
  }
}