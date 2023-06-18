import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/repos/space_repository.dart';

part 'space_filter_modal_event.dart';
part 'space_filter_modal_state.dart';

class SpaceFilterModalBloc
    extends Bloc<SpaceFilterModalEvent, SpaceFilterModalState> {
  SpaceFilterModalBloc(SpaceRepository spaceRepository)
      : super(
          SpaceFilterModalState(
            spaceRepository: spaceRepository,
          ),
        ) {
    on<LoadSpaces>(_onLoadSpaces);
    on<SaveSpaces>(_onSaveSpace);
    on<ClearSpaces>(_onClearSpaces);
  }

  FutureOr<void> _onLoadSpaces(
    LoadSpaces event,
    Emitter<SpaceFilterModalState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          saveStatus: SpaceFilterModalSaveStatus.init,
          status: SpaceFilterModalStatus.loading,
        ),
      );

      // get space repository
      List<Space> allSpaces = await state.spaceRepository.getAllSpaces();

      emit(
        state.copyWith(
          allSpaces: allSpaces,
          saveStatus: SpaceFilterModalSaveStatus.init,
          status: SpaceFilterModalStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          saveStatus: SpaceFilterModalSaveStatus.init,
          status: SpaceFilterModalStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _onSaveSpace(
    SaveSpaces event,
    Emitter<SpaceFilterModalState> emit,
  ) {
    emit(
      state.copyWith(
        selectedSpaces: event.spaces,
        saveStatus: SpaceFilterModalSaveStatus.save,
        status: SpaceFilterModalStatus.success,
      ),
    );
  }

  FutureOr<void> _onClearSpaces(
    ClearSpaces event,
    Emitter<SpaceFilterModalState> emit,
  ) {
    emit(
      state.copyWith(
        selectedSpaces: [],
        saveStatus: SpaceFilterModalSaveStatus.init,
        status: SpaceFilterModalStatus.success,
      ),
    );
  }
}
