import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/util/debounce.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/cubit/tags_filter_view_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/domain/tag.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tags_selector/cubit/tags_selector_cubit.dart';

final debounce = Debouncer(
  milliseconds: 300,
);

Future<dynamic> showTagsSelector(
  BuildContext context,
  TagFilterOption tagFilterOption,
) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    enableDrag: false,
    isScrollControlled: true,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<TagsFilterViewCubit>(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.90,
          child: TagsSelector(
            tagFilterOption: tagFilterOption,
          ),
        ),
      );
    },
  );
}

class TagsSelector extends StatefulWidget {
  const TagsSelector({
    Key? key,
    required this.tagFilterOption,
  }) : super(key: key);

  final TagFilterOption tagFilterOption;

  @override
  State<TagsSelector> createState() => _TagsSelectorState();
}

class _TagsSelectorState extends State<TagsSelector> {
  final _tagQueryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagsSelectorCubit(),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: kColorSand,
        ),
        child: BlocBuilder<TagsSelectorCubit, TagsSelectorState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTopRow(context),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Build tags using folders. Use slash (/) to indicate folder/subfolder and wildcard (*) to match everything in that folder.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) {
                        debounce.run(() {
                          context
                              .read<TagsSelectorCubit>()
                              .updateOptions(value);
                        });
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          " ",
                          replacementString: "-",
                        )
                      ],
                      controller: _tagQueryController,
                      autofocus: true,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        hintText: "/space",
                        hintStyle:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: kColorRoyal.shade300,
                                ),
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: kColorRoyal,
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: state.options.length,
                        itemBuilder: (context, index) {
                          return TagSearchOptionView(
                            option: state.options[index],
                            editingController: _tagQueryController,
                          );
                        },
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CreateButton(
                    widget: widget,
                    tagQueryController: _tagQueryController,
                  ),
                ),
              ],
            );
          },
        ),
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

class TagSearchOptionView extends StatelessWidget {
  const TagSearchOptionView({
    super.key,
    required this.option,
    required this.editingController,
  });

  final TagSearchOption option;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        editingController.text = option.query;
        debounce.run(() {
          context.read<TagsSelectorCubit>().updateOptions(option.query);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            option.query.length >= 25
                ? "...${option.query.substring(option.query.length - 25, option.query.length)}"
                : option.query,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            children: [
              Text(
                option.numPosts,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: 8,
              ),
              SvgPicture.string(kIconPost),
            ],
          ),
        ],
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
    required this.widget,
    required TextEditingController tagQueryController,
  }) : _tagQueryController = tagQueryController;

  final TagsSelector widget;
  final TextEditingController _tagQueryController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (widget.tagFilterOption) {
          case TagFilterOption.include:
            context.read<TagsFilterViewCubit>().addIncludeTag(Tag(
                  id: Random.secure().nextInt(100),
                  query: _tagQueryController.text,
                ));
          case TagFilterOption.exclude:
            context.read<TagsFilterViewCubit>().addExcludeTag(Tag(
                  id: Random.secure().nextInt(100),
                  query: _tagQueryController.text,
                ));
        }
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kColorRoyal,
        ),
        child: Center(
          child: Text(
            "Add",
            style: TextStyle(
              color: kColorSand,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(children: [
            Text(
              postNumber,
              style: Theme.of(context).textTheme.bodyLarge,
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
