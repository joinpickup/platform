import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/mocks/space.dart';
import 'package:local/repos/data/models/space/space.dart';

part 'space_modal_event.dart';
part 'space_modal_state.dart';

class SpaceModalBloc extends Bloc<SpaceModalEvent, SpaceModalState> {
  SpaceModalBloc() : super(const SpaceModalState()) {
    on<LoadSpaces>(_loadSpaces);
  }

  FutureOr<void> _loadSpaces(LoadSpaces event, Emitter<SpaceModalState> emit) {
    emit(
      state.copyWith(
        spaces: allSpaces,
        status: SpaceModalStatus.success,
      ),
    );
  }
}
