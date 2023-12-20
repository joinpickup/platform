import 'package:flutter/material.dart';
import 'package:local/views/home/home_screen/components/board_card.dart';

const items = [];

class BoardFeed extends StatelessWidget {
  const BoardFeed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return BoardCard(
            board: Board(
                author: "@local-hq",
                name: "Nearby",
                description:
                    "This is a default board to give you back all of the posts in a 5 mile radius."),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: 5,
        shrinkWrap: true,
      ),
    );
  }
}
