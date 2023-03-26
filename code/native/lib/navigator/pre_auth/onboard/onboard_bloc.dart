import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/user/onboard_user.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(const OnboardState()) {
    on<ResetOnboardPage>(_onReset);
    on<HandleNextPage>(_onHandleNextPage);
    on<HandleBackPage>(_onHandleBackPage);
  }

  Future<void> _onHandleNextPage(
    HandleNextPage event,
    Emitter<OnboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OnboardPageStatus.success,
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

  Future<void> _onReset(
    ResetOnboardPage event,
    Emitter<OnboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OnboardPageStatus.initial,
      ),
    );
  }
}
