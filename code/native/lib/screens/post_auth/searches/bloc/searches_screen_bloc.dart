import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/repos/search_repository.dart';

part 'searches_screen_event.dart';
part 'searches_screen_state.dart';

class SearchesScreenBloc
    extends Bloc<SearchesScreenEvent, SearchesScreenState> {
  SearchesScreenBloc(searchRepository)
      : super(SearchesScreenState(
          searchRepository: searchRepository,
        )) {
    on<LoadSearches>(_onLoadSearches);
  }

  FutureOr<void> _onLoadSearches(
    LoadSearches event,
    Emitter<SearchesScreenState> emit,
  ) async {
    emit(state.copyWith(
      status: SearchStatus.loading,
      searches: [],
    ));

    try {
      switch (event.type) {
        case SearchType.recommended:
          var recommendedSearches =
              await state.searchRepository.getRecommendedSearches();

          emit(state.copyWith(
            status: SearchStatus.success,
            searches: recommendedSearches,
          ));
          break;
        case SearchType.saved:
          var savedSearches = await state.searchRepository.getSavedSearches();

          emit(state.copyWith(
            status: SearchStatus.success,
            searches: savedSearches,
          ));
          break;
        case SearchType.more:
          var moreSearches = await state.searchRepository.getMoreSearches();

          emit(state.copyWith(
            status: SearchStatus.success,
            searches: moreSearches,
          ));
          break;
        default:
          var recommendedSearches =
              await state.searchRepository.getRecommendedSearches();

          emit(state.copyWith(
            status: SearchStatus.success,
            searches: recommendedSearches,
          ));
          break;
      }
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.error,
        searches: [],
      ));
    }
  }
}
