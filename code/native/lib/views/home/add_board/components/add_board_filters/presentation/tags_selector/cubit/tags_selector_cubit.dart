import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tags_selector_state.dart';

class TagsSelectorCubit extends Cubit<TagsSelectorState> {
  TagsSelectorCubit()
      : super(
          const TagsSelectorState(
            options: [],
          ),
        );

  void updateOptions(String query) {
    emit(
      state.copyWith(
        options: [
          ...state.options,
          TagSearchOption(
            numPosts: "23m",
            query: query,
          )
        ],
      ),
    );
  }
}
