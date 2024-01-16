import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:local/theme/color.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: kColorCardBlue,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 24,
            cornerSmoothing: 0.6,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      // left and right
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: kColorDeepBlood,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                child: const Text("@local-hq"),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            child: const Text("looking for a partner for a trivia"),
          ),
        ],
      ),
    );
  }
}
