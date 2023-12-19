import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/board/board_screen.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BoardScreen(),
      ))),
      child: Container(
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
                Text(
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
                      theme: SvgTheme(
                        currentColor: kColorRoyal,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
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
                      theme: SvgTheme(
                        currentColor: kColorRoyal,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
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
    return Row(
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
        const SizedBox(
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
        const SizedBox(
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
