import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/user/onboard_user.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(const OnboardState()) {
    on<HandleNextPage>(_onHandleNextPage);
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

  Future<void> _onHandleBasicInfo(
    HandleBasicInfo event,
    Emitter<OnboardState> emit,
  ) async {
    emit(
      state.copyWith(),
    );
  }

  Future<void> _onHandleLocationSettings(
    HandleLocationSettings event,
    Emitter<OnboardState> emit,
  ) async {}

  Future<void> _onHandleInterests(
    HandleInterests event,
    Emitter<OnboardState> emit,
  ) async {}

  Future<void> _onHandleDonation(
    HandleDonation event,
    Emitter<OnboardState> emit,
  ) async {}
}
