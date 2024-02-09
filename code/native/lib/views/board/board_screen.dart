import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/board/components/post_card.dart';
import 'package:local/views/home/home_screen/components/board_card.dart';

final items = [
  Post(
    author: "@local-hq",
    body: "looking for a trivia partner",
    createdAt: "5m",
  ),
  Post(
    author: "@andrew",
    body: "anyone know any good volunteer places?",
    createdAt: "5m",
  ),
];

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    Key? key,
    required this.board,
  }) : super(key: key);

  final Board board;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: SvgPicture.string(
              kIconVert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            0.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              _buildBoardTitle(context),
              const SizedBox(
                height: 16,
              ),
              _buildDescription(),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  BoardMetaData(
                    name: "Posts",
                    icon: kIconPost,
                    number: board.numberOfPosts,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  BoardMetaData(
                    name: "Followers",
                    icon: kIconBellSolid,
                    number: board.numberOfFollowers,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              _buildButtons(),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    return PostCard(post: items[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: board.isFollowed ? "Following" : "Follow",
            color: board.isFollowed ? kColorDeepBlood : kColorDeepBlood,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        CustomButton(text: "View Filter", color: kColorRoyal),
      ],
    );
  }

  Text _buildDescription() => Text(board.description);

  RichText _buildBoardTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: board.author,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: " / ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: board.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

class BoardMetaData extends StatelessWidget {
  const BoardMetaData({
    Key? key,
    required this.name,
    required this.number,
    required this.icon,
  }) : super(key: key);

  final String name;
  final int number;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.string(
          icon,
          height: 16,
          width: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          number.toString(),
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: kColorDeepBlood),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(name, style: Theme.of(context).textTheme.bodyMedium!),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.icon,
    this.color,
  }) : super(key: key);

  final String text;
  final Color? color;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? kColorDeepBlood,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: kColorSand,
            ),
      ),
    );
  }
}
