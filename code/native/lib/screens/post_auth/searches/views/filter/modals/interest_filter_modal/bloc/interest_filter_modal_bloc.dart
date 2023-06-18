import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/interest_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'interest_filter_modal_event.dart';
part 'interest_filter_modal_state.dart';

class InterestFilterModalBloc
    extends Bloc<InterestFilterModalEvent, InterestFilterModalState> {
  InterestFilterModalBloc(
    InterestRepository interestRepository,
  ) : super(InterestFilterModalState(
          interestRepository: interestRepository,
        )) {
    on<LoadInterests>(_loadInterests);

    on<SaveInterests>(_saveInterests);
    on<SearchIntersts>(_searchIntersts,
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 300))
            .switchMap(mapper));

    on<ClearInterests>(_clearIntersets);
    on<ResetInterestSearch>(_resetSearch);
  }

  FutureOr<void> _loadInterests(
    LoadInterests event,
    Emitter<InterestFilterModalState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          saveStatus: InterestsFilterModalSaveStatus.init,
          status: InterestsFilterModalStatus.loading,
          selectedInterests: event.selected,
        ),
      );

      // get interest
      List<Interest> allInterests =
          await state.interestRepository.getAllIntersts();

      emit(
        state.copyWith(
          saveStatus: InterestsFilterModalSaveStatus.init,
          allInterests: allInterests,
          status: InterestsFilterModalStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          saveStatus: InterestsFilterModalSaveStatus.init,
          status: InterestsFilterModalStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _saveInterests(
    SaveInterests event,
    Emitter<InterestFilterModalState> emit,
  ) {
    emit(
      state.copyWith(
        selectedInterests: event.interests,
        status: InterestsFilterModalStatus.success,
        saveStatus: InterestsFilterModalSaveStatus.save,
      ),
    );
  }

  FutureOr<void> _searchIntersts(
    SearchIntersts event,
    Emitter<InterestFilterModalState> emit,
  ) async {
    emit(
      state.copyWith(
        status: InterestsFilterModalStatus.loading,
      ),
    );
    try {
      List<Interest> interests =
          await state.interestRepository.searchinterests(event.query);

      emit(
        state.copyWith(
          allInterests: interests,
          status: InterestsFilterModalStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          allInterests: [],
          status: InterestsFilterModalStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _clearIntersets(
    ClearInterests event,
    Emitter<InterestFilterModalState> emit,
  ) async {
    // get interest
    List<Interest> allInterests =
        await state.interestRepository.getAllIntersts();

    emit(
      state.copyWith(
        selectedInterests: [],
        allInterests: allInterests,
        status: InterestsFilterModalStatus.success,
      ),
    );
  }

  FutureOr<void> _resetSearch(
    ResetInterestSearch event,
    Emitter<InterestFilterModalState> emit,
  ) async {
    // get interest
    List<Interest> allInterests =
        await state.interestRepository.getAllIntersts();

    emit(
      state.copyWith(
        allInterests: allInterests,
        saveStatus: InterestsFilterModalSaveStatus.init,
        status: InterestsFilterModalStatus.success,
      ),
    );
  }
}
