import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/user_repository.dart';

part 'account_info_event.dart';
part 'account_info_state.dart';

class AccountInfoPageBloc
    extends Bloc<AccountInfoPageEvent, AccountInfoPageState> {
  AccountInfoPageBloc(userRepository)
      : super(AccountInfoPageState(userRepository: userRepository)) {
    on<SubmitAccountInfo>(_onSubmitAccountInfo);
    on<ResetAccountInfoValidation>(_onResetValidation);
  }

  Future<void> _onSubmitAccountInfo(
    SubmitAccountInfo event,
    Emitter<AccountInfoPageState> emit,
  ) async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email);

    if (event.email == "" || !emailValid) {
      emit(
        state.copyWith(
          error: const AccountInfoError(
            "Enter a valid email...",
            AccountInfoPageErrorType.email,
          ),
          status: AccountInfoPageStatus.error,
        ),
      );
    } else if (event.password == "") {
      emit(
        state.copyWith(
          error: const AccountInfoError(
            "Enter a valid password...",
            AccountInfoPageErrorType.password,
          ),
          status: AccountInfoPageStatus.error,
        ),
      );
    } else {
      try {
        // handle register
        String token = await state.userRepository
            .register(email: event.email, password: event.password);

        emit(
          state.copyWith(
            token: token,
            email: event.email,
            status: AccountInfoPageStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            error: AccountInfoError(
              e.toString(),
              AccountInfoPageErrorType.register,
            ),
            email: event.email,
            status: AccountInfoPageStatus.error,
          ),
        );
      }
    }
  }

  Future<void> _onResetValidation(
    ResetAccountInfoValidation event,
    Emitter<AccountInfoPageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AccountInfoPageStatus.initial,
      ),
    );
  }
}
