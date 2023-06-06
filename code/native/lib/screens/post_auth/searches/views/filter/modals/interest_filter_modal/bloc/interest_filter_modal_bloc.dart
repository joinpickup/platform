import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/interest_repository.dart';

part 'interest_filter_modal_event.dart';
part 'interest_filter_modal_state.dart';

class InterestFilterModalBloc
    extends Bloc<InterestFilterModalEvent, InterestFilterModalState> {
  InterestFilterModalBloc(
    InterestRepository interestRepository,
  ) : super(InterestFilterModalState(
          interestRepository: interestRepository,
        )) {
    on<LoadIntersts>(_loadInterests);
    on<SaveInterests>(_saveInterests);
    on<SearchIntersts>(_searchIntersts);
    on<ClearInterests>(_clearIntersets);
  }

  FutureOr<void> _loadInterests(
    LoadIntersts event,
    Emitter<InterestFilterModalState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: InterestsFilterModalStatus.loading,
        ),
      );

      // get interest
      List<Interest> allInterests =
          await state.interestRepository.getAllInterests();

      emit(
        state.copyWith(
          allInterests: allInterests,
          status: InterestsFilterModalStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
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
      ),
    );
  }

  FutureOr<void> _searchIntersts(
    SearchIntersts event,
    Emitter<InterestFilterModalState> emit,
  ) {
    try {} catch (e) {
      emit(
        state.copyWith(
          allInterests: [],
          status: InterestsFilterModalStatus.success,
        ),
      );
    }
  }

  FutureOr<void> _clearIntersets(
    ClearInterests event,
    Emitter<InterestFilterModalState> emit,
  ) {
    emit(
      state.copyWith(
        selectedInterests: [],
        status: InterestsFilterModalStatus.success,
      ),
    );
  }
}
