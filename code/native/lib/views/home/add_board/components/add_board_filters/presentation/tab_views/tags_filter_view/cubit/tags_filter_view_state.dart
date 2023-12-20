part of 'tags_filter_view_cubit.dart';

enum IncludeState { any, all }

enum TagFilterOption { include, exclude }

class TagsFilterViewState extends Equatable {
  final List<Tag> included;
  final IncludeState includeState;
  final List<Tag> excluded;

  const TagsFilterViewState({
    required this.included,
    required this.includeState,
    required this.excluded,
  });

  @override
  List<Object?> get props => [includeState, included, excluded];

  TagsFilterViewState copyWith({
    List<Tag>? included,
    IncludeState? includeState,
    List<Tag>? excluded,
  }) {
    return TagsFilterViewState(
      included: included ?? this.included,
      includeState: includeState ?? this.includeState,
      excluded: excluded ?? this.excluded,
    );
  }
}
