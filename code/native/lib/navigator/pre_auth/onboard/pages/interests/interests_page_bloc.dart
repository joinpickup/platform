import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/space/interest.dart';

part 'interests_page_event.dart';
part 'interests_page_state.dart';

class InterestsPageBloc extends Bloc<InterestsPageEvent, InterestsPageState> {
  InterestsPageBloc()
      : super(
          const InterestsPageState(
            interests: [],
          ),
        ) {
    on<ToggleInterest>(_onToggleInterests);
    on<SubmitInterests>(_onSubmit);
    on<ResetValidation>(_onReset);
  }

  Future<void> _onToggleInterests(
    ToggleInterest event,
    Emitter<InterestsPageState> emit,
  ) async {
    List<Interest> newInterests = [...state.interests];

    if (state.interests.contains(event.interest)) {
      newInterests.removeWhere(
        (element) => element.interestID == event.interest.interestID,
      );
    } else {
      newInterests = [...state.interests, event.interest];
    }

    if (newInterests.length > 5) {
      emit(
        state.copyWith(
          interests: newInterests,
          status: InterestsPageStatus.error,
        ),
      );
    } else {
      emit(
        state.copyWith(
          interests: newInterests,
          status: InterestsPageStatus.initial,
        ),
      );
    }
  }

  Future<void> _onSubmit(
    SubmitInterests event,
    Emitter<InterestsPageState> emit,
  ) async {
    if (state.interests.length != 5) {
      emit(
        state.copyWith(
          status: InterestsPageStatus.error,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500), () {});

      emit(
        state.copyWith(
          status: InterestsPageStatus.initial,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: InterestsPageStatus.success,
        ),
      );
    }
  }

  Future<void> _onReset(
    ResetValidation event,
    Emitter<InterestsPageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: InterestsPageStatus.initial,
      ),
    );
  }
}
