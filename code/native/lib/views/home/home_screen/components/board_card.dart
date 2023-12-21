import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/board/board_screen.dart';

class Board {
  final String author;
  final String name;
  final String description;

  Board({required this.author, required this.name, required this.description});
}

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
    required this.board,
  });

  final Board board;

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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: board.author,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: " / ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: board.name,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              board.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // description
            const SizedBox(
              height: 8,
            ),
            // data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "5d ago",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: kColorRoyal.shade300,
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