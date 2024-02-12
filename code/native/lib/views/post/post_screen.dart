import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/board/components/post_card.dart';
import 'package:local/views/home/add_post/add_post.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

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
              theme: SvgTheme(
                currentColor: Theme.of(context).colorScheme.onBackground,
              ),
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
              _buildUser(context),
              const SizedBox(
                height: 16,
              ),
              _buildBody(context),
              const SizedBox(
                height: 16,
              ),
              const Spacer(),
              _buildTagButton(),
              const SizedBox(
                height: 8,
              ),
              _buildButtons(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagButton() {
    return Row(children: [
      Expanded(
        child: CustomButton(
          text: "View Details",
          click: () {},
          color: Colors.transparent,
          textColor: kColorRoyal,
        ),
      ),
    ]);
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            click: () {},
            text: "Message",
          ),
        ),
      ],
    );
  }

  Text _buildBody(BuildContext context) => Text(
        post.body,
        style: Theme.of(context).textTheme.bodyLarge,
      );

  Widget _buildTags(BuildContext context) {
    return const Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: [
        LabelChip(
          group: "ThisTest",
          value: "test",
        ),
        LabelChip(
          group: "ThisTest",
          value: "test",
        )
      ],
    );
  }

  Widget _buildUser(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: kColorDeepBlood,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: post.author,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          post.createdAt,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
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
    required this.click,
    this.icon,
    this.color,
    this.textColor,
  }) : super(key: key);

  final String text;
  final Color? color;
  final Function click;
  final Color? textColor;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: Container(
        decoration: BoxDecoration(
          color: color ?? kColorDeepBlood,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: textColor ?? kColorSand,
              ),
        ),
      ),
    );
  }
}
