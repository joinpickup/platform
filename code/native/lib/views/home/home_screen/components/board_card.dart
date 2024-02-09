import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/board/board_screen.dart';

class Board {
  final String author;
  final String name;
  final String description;
  final int numberOfPosts;
  final int numberOfFollowers;
  final bool isFollowed;

  Board({
    required this.author,
    required this.name,
    required this.description,
    required this.numberOfPosts,
    required this.numberOfFollowers,
    required this.isFollowed,
  });
}

class BoardCard extends StatefulWidget {
  const BoardCard({
    super.key,
    required this.board,
  });

  final Board board;

  @override
  State<BoardCard> createState() => _BoardCardState();
}

class _BoardCardState extends State<BoardCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          selected = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          selected = false;
        });
      },
      onTapCancel: () {
        setState(() {
          selected = false;
        });
      },
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BoardScreen(board: widget.board),
        ));
      },
      child: Container(
        decoration: ShapeDecoration(
          color: selected
              ? createMaterialColor(Theme.of(context).colorScheme.surface)
                  .shade600
              : createMaterialColor(Theme.of(context).colorScheme.surface),
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
                    text: widget.board.author,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: " / ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: widget.board.name,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.board.description,
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
                      height: 16,
                      width: 16,
                      theme: SvgTheme(
                        currentColor: kColorRoyal,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.board.numberOfPosts.toString(),
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
                      kIconBellSolid,
                      height: 16,
                      width: 16,
                      theme: SvgTheme(
                        currentColor: kColorRoyal,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.board.numberOfFollowers.toString(),
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
