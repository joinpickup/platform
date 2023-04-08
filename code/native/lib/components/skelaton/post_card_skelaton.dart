import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PostCardSkelaton extends StatelessWidget {
  const PostCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TW3Colors.gray.shade700,
                border: Border.all(
                  color: TW3Colors.gray.shade500.withOpacity(.25),
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 28,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TW3Colors.gray.shade600,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 76,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TW3Colors.gray.shade600,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TW3Colors.gray.shade700,
                border: Border.all(
                  color: TW3Colors.gray.shade500.withOpacity(.25),
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 32,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TW3Colors.gray.shade600,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 76,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TW3Colors.gray.shade600,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
