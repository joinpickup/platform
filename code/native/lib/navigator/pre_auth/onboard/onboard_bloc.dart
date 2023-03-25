import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/user/onboard_user.dart';
import 'package:location/location.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(const OnboardState()) {
    on<ResetErrors>(_onResetErrors);
    on<HandleNextPage>(_onHandleNextPage);
    on<HandleBackPage>(_onHandleBackPage);
    on<HandleBasicInfo>(_onHandleBasicInfo);
    on<HandleLocationSettings>(_onHandleLocationSettings);
    on<HandleInterests>(_onHandleInterests);
    on<HandleDonation>(_onHandleDonation);
  }

  Future<void> _onHandleNextPage(
    HandleNextPage event,
    Emitter<OnboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OnboardPageStatus.initial,
      ),
    );
  }

  Future<void> _onHandleBackPage(
    HandleBackPage event,
    Emitter<OnboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OnboardPageStatus.initial,
      ),
    );
  }

  Future<void> _onHandleBasicInfo(
    HandleBasicInfo event,
    Emitter<OnboardState> emit,
  ) async {
    if (event.name == "") {
      emit(state.copyWith(
        error: "Please enter a name...",
        status: OnboardPageStatus.error,
      ));
    } else {
      emit(
        state.copyWith(
          status: OnboardPageStatus.success,
        ),
      );
    }
  }

  Future<void> _onResetErrors(
    ResetErrors event,
    Emitter<OnboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OnboardPageStatus.initial,
      ),
    );
  }

  Future<void> _onHandleLocationSettings(
    HandleLocationSettings event,
    Emitter<OnboardState> emit,
  ) async {
    Location location = Location();
    bool locationServiceEnabled = await location.serviceEnabled();
    if (locationServiceEnabled) {
      emit(
        state.copyWith(
          status: OnboardPageStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: OnboardPageStatus.error,
        ),
      );
    }
  }

  Future<void> _onHandleInterests(
    HandleInterests event,
    Emitter<OnboardState> emit,
  ) async {}

  Future<void> _onHandleDonation(
    HandleDonation event,
    Emitter<OnboardState> emit,
  ) async {}
}
