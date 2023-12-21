part of 'tags_selector_cubit.dart';

class TagSearchOption {
  final String query;
  final String numPosts;

  TagSearchOption({required this.query, required this.numPosts});
}

class TagsSelectorState extends Equatable {
  final List<TagSearchOption> options;

  const TagsSelectorState({required this.options});

  @override
  List<Object?> get props => [options];

  TagsSelectorState copyWith({
    List<TagSearchOption>? options,
  }) {
    return TagsSelectorState(
      options: options ?? this.options,
    );
  }
}
