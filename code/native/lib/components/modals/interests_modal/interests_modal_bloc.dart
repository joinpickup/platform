import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/space/interest.dart';

part 'interests_modal_events.dart';
part 'interests_modal_state.dart';

class InterestsModalBloc
    extends Bloc<InterestsModalEvent, InterestsModalState> {
  InterestsModalBloc(interests)
      : super(InterestsModalState(
          interests: interests ?? [],
        )) {
    on<ToggleInterstsModal>(_toggleInterest);
  }

  FutureOr<void> _toggleInterest(
    ToggleInterstsModal event,
    Emitter<InterestsModalState> emit,
  ) async {
    List<Interest> newInterests = [...state.interests];

    if (state.interests.contains(event.interest)) {
      newInterests.removeWhere(
        (element) => element.interestID == event.interest.interestID,
      );
    } else {
      newInterests = [...state.interests, event.interest];
    }
    emit(
      state.copyWith(
        interests: newInterests,
      ),
    );
  }
}
