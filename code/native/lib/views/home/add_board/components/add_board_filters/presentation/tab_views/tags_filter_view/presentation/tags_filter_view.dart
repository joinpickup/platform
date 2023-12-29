import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/rounded_icon_button.dart';
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
                  RoundedIconButton(
                    icon: kIconPlus,
                    click: () {
                      HapticFeedback.lightImpact();
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
                  RoundedIconButton(
                    icon: kIconPlus,
                    click: () {
                      HapticFeedback.lightImpact();
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

class TagFilterDistinction extends StatefulWidget {
  const TagFilterDistinction({
    super.key,
  });

  @override
  State<TagFilterDistinction> createState() => _TagFilterDistinctionState();
}

class _TagFilterDistinctionState extends State<TagFilterDistinction> {
  final _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsFilterViewCubit, TagsFilterViewState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: CustomPopupMenu(
            controller: _controller,
            pressType: PressType.singleClick,
            showArrow: false,
            barrierColor: Colors.black45,
            menuOnChange: (p0) {
              HapticFeedback.lightImpact();
            },
            menuBuilder: () => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: kColorSand,
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: TagFilterIncludeDistinction.values
                      .map(
                        (item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            context
                                .read<TagsFilterViewCubit>()
                                .updateIncludeDistinction(item);
                            _controller.hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            child: Text(
                              item.text,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  state.includeDistinction.text,
                ),
                const SizedBox(
                  width: 4,
                ),
                SvgPicture.string(
                  kIconArrowBoth,
                )
              ],
            ),
          ),
        );
      },
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
            tag.query.length >= 25
                ? "...${tag.query.substring(tag.query.length - 25, tag.query.length)}"
                : tag.query,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          RoundedIconButton(
            background: kColorInput.shade700,
            icon: kIconX,
            size: 24,
            click: () {
              HapticFeedback.lightImpact();
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
