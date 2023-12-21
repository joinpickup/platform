part of 'tags_filter_view_cubit.dart';

enum TagFilterIncludeDistinction {
  any(icon: kIconAny, text: "Any"),
  all(icon: kIconAll, text: "All");

  final String text;
  final String icon;

  const TagFilterIncludeDistinction({required this.text, required this.icon});
}

enum TagFilterOption { include, exclude }

class TagsFilterViewState extends Equatable {
  final List<Tag> included;
  final TagFilterIncludeDistinction includeDistinction;
  final List<Tag> excluded;

  const TagsFilterViewState({
    required this.included,
    required this.includeDistinction,
    required this.excluded,
  });

  @override
  List<Object?> get props => [includeDistinction, included, excluded];

  TagsFilterViewState copyWith({
    List<Tag>? included,
    TagFilterIncludeDistinction? includeDistinction,
    List<Tag>? excluded,
  }) {
    return TagsFilterViewState(
      included: included ?? this.included,
      includeDistinction: includeDistinction ?? this.includeDistinction,
      excluded: excluded ?? this.excluded,
    );
  }
}

const TagsFilterViewState initialTagsFilterViewState = TagsFilterViewState(
  included: [],
  excluded: [],
  includeDistinction: TagFilterIncludeDistinction.any,
);
