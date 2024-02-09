import 'package:flutter/material.dart';
import 'package:local/views/home/home_screen/components/board_card.dart';

final items = [
  Board(
    author: "@local-hq",
    name: "Nearby",
    description:
        "This is a default board to give you back all of the posts in a 5 mile radius.",
    numberOfPosts: 24,
    numberOfFollowers: 100,
    isFollowed: false,
  ),
  Board(
    author: "@local-hq",
    name: "Sports",
    description: "This is a board that aggregates all sports posts.",
    numberOfPosts: 500,
    numberOfFollowers: 5000,
    isFollowed: true,
  ),
];

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
            board: items[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: items.length,
        shrinkWrap: true,
      ),
    );
  }
}
