import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';

Future<dynamic> showTagsSelector(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    enableDrag: true,
    isScrollControlled: true,
    builder: (_) {
      return const TagsSelector();
    },
  );
}

class TagsSelector extends StatelessWidget {
  const TagsSelector({Key? key}) : super(key: key);

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
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopRow(context),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Column(
              children: [
                TagItem(
                  text: "/*",
                  postNumber: "332M",
                ),
                TagItem(
                  text: "/soccer",
                  postNumber: "244K",
                ),
                TagItem(
                  text: "/outdoors",
                  postNumber: "234K",
                ),
                TagItem(
                  text: "/books",
                  postNumber: "47K",
                ),
                TagItem(
                  text: "/music",
                  postNumber: "37K",
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(
            height: 16,
          ),
          const Spacer(),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "/",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: kColorRoyal,
                      )),
              TextSpan(
                  text: "space/",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: kColorRoyal.shade300,
                      )),
            ]),
          ),
          const SizedBox(
            height: 16,
          ),
          const CreateButton(),
        ],
      ),
    );
  }

  Row _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tag Builder",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
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

class TagItem extends StatelessWidget {
  const TagItem({super.key, required this.text, required this.postNumber});

  final String text;
  final String postNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Row(children: [
            Text(
              postNumber,
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.string(
              kIconPost,
            ),
          ]),
        ],
      ),
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
        hintText: "Search for a keyword...",
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
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
