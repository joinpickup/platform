import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/repos/space_repository.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  SpaceBloc(spaceRepository)
      : super(SpaceState(
          spaceRepository: spaceRepository,
        )) {
    on<LoadSpaces>(_loadSpaces);
    on<ChangeSpace>(_onChangeSpace);
  }

  Future<void> _loadSpaces(LoadSpaces event, Emitter<SpaceState> emit) async {
    emit(
      state.copyWith(
        spaceStatus: SpaceStatus.loading,
        interestsStatus: SpaceInterestsStatus.loading,
      ),
    );

    List<Space> spaces = await state.spaceRepository.getAllSpaces();
    List<Interest> interests =
        await state.spaceRepository.getAllInterestsForASpace(spaces[0]);

    emit(
      state.copyWith(
        spaces: spaces,
        space: spaces[0],
        interests: interests,
        spaceStatus: SpaceStatus.success,
        interestsStatus: SpaceInterestsStatus.success,
      ),
    );
  }

  FutureOr<void> _onChangeSpace(
    ChangeSpace event,
    Emitter<SpaceState> emit,
  ) async {
    emit(
      state.copyWith(
        space: event.space,
        interestsStatus: SpaceInterestsStatus.loading,
      ),
    );

    List<Interest> interests =
        await state.spaceRepository.getAllInterestsForASpace(event.space);

    emit(
      state.copyWith(
        interests: interests,
        interestsStatus: SpaceInterestsStatus.success,
      ),
    );
  }
}
