import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
      child: Row(
        children: [
          // side bar
          Container(
            width: 8,
            decoration: const BoxDecoration(
              color: kColorCardBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          // body
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // title
              const BoardHeader(),
              // description
              const SizedBox(
                width: 16,
              ),
              // data
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "5d ago",
                    style: TextStyle(
                      color: kColorRoyal,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.string(
                        kIconPost,
                        width: 24,
                        height: 24,
                        theme: const SvgTheme(
                          currentColor: kColorRoyal,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "2k",
                        style: TextStyle(
                          color: kColorRoyal,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SvgPicture.string(
                        kIconStar,
                        width: 24,
                        height: 24,
                        theme: const SvgTheme(
                          currentColor: kColorRoyal,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "100k",
                        style: TextStyle(
                          color: kColorRoyal,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    ],
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

class BoardHeader extends StatelessWidget {
  const BoardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "@local-hq",
          style: TextStyle(
            color: kColorRoyal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          "/",
          style: TextStyle(
            color: kColorRoyal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          "Nearby",
          style: TextStyle(
            color: kColorRoyal,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
