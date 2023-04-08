part of 'account_info_bloc.dart';

abstract class AccountInfoPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitAccountInfo extends AccountInfoPageEvent {
  final String email;
  final String password;

  SubmitAccountInfo(this.email, this.password);
}

class ResetAccountInfoValidation extends AccountInfoPageEvent {}
