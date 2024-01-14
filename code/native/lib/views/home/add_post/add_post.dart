import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/components/rounded_icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/cubit/tags_filter_view_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/domain/tag.dart';

Future<dynamic> showAddPost(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (_) {
      return const AddPost();
    },
  );
}

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: kColorSand,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context),
          const SizedBox(
            height: 8,
          ),
          const Text(
              "Posts are like real life posts you'd put on a bulliten board."),
          const SizedBox(
            height: 24,
          ),
          _buildTitleInput(context),
          const SizedBox(
            height: 24,
          ),
          _buildBody(context),
          const SizedBox(
            height: 24,
          ),
          _buildLabels(context),
          const Spacer(),
          const CreateButton(),
        ],
      ),
    );
  }

  Column _buildLabels(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Labels",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text("Labels allow other people to find your post."),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: [
            const LabelChip(
              group: "Space",
              value: "sports",
            ),
            LabelChip(
              group: "Activity",
              value: "tennis",
              color: kColorCardBlue.shade800,
            ),
            LabelChip(
              group: "Type",
              value: "game",
              color: kColorInput.shade800,
            ),
            LabelChip(
              group: "Difficulty",
              value: "intermediate",
              color: kColorRoyal,
            ),
            RoundedIconButton(
              icon: kIconPlus,
              background: Colors.transparent,
              iconColor: kColorRoyal,
              click: () {
                HapticFeedback.lightImpact();
              },
            ),
          ],
        ),
      ],
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Body",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const CustomBodyInput(),
      ],
    );
  }

  Column _buildTitleInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const CustomInput(),
      ],
    );
  }

  Row _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "New Post",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        CustomIconButton(
          icon: kIconClose,
          click: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kColorRoyal,
      ),
      child: Center(
        child: Text(
          "Create",
          style: TextStyle(
            color: kColorSand,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.group,
    required this.value,
    this.color,
  });

  final String group;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildChipPart(context, true),
        _buildChipPart(context, false),
      ],
    );
  }

  Container _buildChipPart(
    BuildContext context,
    bool isFront,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isFront ? color ?? kColorDeepBlood : Colors.transparent,
        border: Border.all(color: color ?? kColorDeepBlood, width: 2),
        borderRadius: isFront
            ? const BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              )
            : const BorderRadius.only(
                bottomRight: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
      ),
      child: Text(
        isFront ? group : value,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: isFront ? kColorSand : color ?? kColorDeepBlood,
            ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: "Enter a title...",
        hintStyle: TextStyle(
          color: kColorRoyal.shade300,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kColorRoyal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class CustomBodyInput extends StatelessWidget {
  const CustomBodyInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 3,
      maxLines: 5,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: "Enter the body...",
        hintStyle: TextStyle(
          color: kColorRoyal.shade300,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kColorRoyal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
