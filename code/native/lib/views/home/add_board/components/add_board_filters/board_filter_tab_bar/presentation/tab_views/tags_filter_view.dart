import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/presentation/tags_selector/presentation/tags_selector.dart';

class TagsFilterView extends StatelessWidget {
  const TagsFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Include",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const TagFilterDistinction(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: kColorInput,
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                const TagChip(
                  text: "/soccer/",
                ),
                const TagChip(
                  text: "/football-uk/",
                ),
                const TagChip(
                  text: "/intermediate/",
                ),
                const TagChip(
                  text: "/pickup/",
                ),
                Button(
                  icon: kIconPlus,
                  click: () {
                    showTagsSelector(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Exclude",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: kColorInput,
            ),
            child: Wrap(
              children: [
                Button(
                  icon: kIconPlus,
                  click: () {
                    showTagsSelector(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TagFilterDistinction extends StatelessWidget {
  const TagFilterDistinction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Text(
            "Any",
          ),
          const SizedBox(
            width: 4,
          ),
          SvgPicture.string(
            kIconArrowDown,
          )
        ],
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kColorInput.shade600,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          Button(
            background: kColorInput.shade700,
            icon: kIconX,
            size: 24,
            click: () {},
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.icon,
    required this.click,
    this.background,
    this.size = 32,
  });

  final String icon;
  final Function click;
  final Color? background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: Container(
        decoration: BoxDecoration(
          color: background ?? kColorInput.shade600,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: SvgPicture.string(
          icon,
          width: size,
          height: size,
          theme: SvgTheme(
            currentColor: kColorRoyal,
          ),
        ),
      ),
    );
  }
}
