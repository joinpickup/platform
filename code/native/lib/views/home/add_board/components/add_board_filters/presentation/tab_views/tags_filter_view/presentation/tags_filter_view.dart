import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/cubit/tags_filter_view_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/domain/tag.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tags_selector/presentation/tags_selector.dart';

class TagsFilterView extends StatelessWidget {
  const TagsFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsFilterViewCubit, TagsFilterViewState>(
      builder: (context, state) {
        return Column(
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
              height: 4,
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
                  ...state.included.map((e) {
                    return TagChip(
                      tag: e,
                      tagFilterOption: TagFilterOption.include,
                    );
                  }).toList(),
                  Button(
                    icon: kIconPlus,
                    click: () {
                      showTagsSelector(
                        context,
                        TagFilterOption.include,
                      );
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
              height: 4,
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
                  ...state.excluded.map((e) {
                    return TagChip(
                      tag: e,
                      tagFilterOption: TagFilterOption.exclude,
                    );
                  }).toList(),
                  Button(
                    icon: kIconPlus,
                    click: () {
                      showTagsSelector(
                        context,
                        TagFilterOption.exclude,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
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
    required this.tag,
    required this.tagFilterOption,
  });

  final Tag tag;
  final TagFilterOption tagFilterOption;

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
            tag.name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          Button(
            background: kColorInput.shade700,
            icon: kIconX,
            size: 24,
            click: () {
              switch (tagFilterOption) {
                case TagFilterOption.include:
                  context.read<TagsFilterViewCubit>().removeIncludeTag(tag);
                case TagFilterOption.exclude:
                  context.read<TagsFilterViewCubit>().removeExcludedTag(tag);
              }
            },
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
