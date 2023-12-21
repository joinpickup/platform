import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/domain/tag.dart';

part 'tags_filter_view_state.dart';

class TagsFilterViewCubit extends Cubit<TagsFilterViewState> {
  TagsFilterViewCubit() : super(initialTagsFilterViewState);

  void init(TagsFilterViewState newState) {
    emit(newState);
  }

  void updateIncludeDistinction(TagFilterIncludeDistinction distinction) {
    emit(state.copyWith(includeDistinction: distinction));
  }

  void addIncludeTag(Tag tag) {
    emit(state.copyWith(included: [...state.included, tag]));
  }

  void removeIncludeTag(Tag tag) {
    emit(state.copyWith(
      included: state.included
          .where(
            (element) => element.id != tag.id,
          )
          .toList(),
    ));
  }

  void addExcludeTag(Tag tag) {
    emit(state.copyWith(excluded: [...state.excluded, tag]));
  }

  void removeExcludedTag(Tag tag) {
    emit(state.copyWith(
      excluded: state.excluded
          .where(
            (element) => element.id != tag.id,
          )
          .toList(),
    ));
  }
}
