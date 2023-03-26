part of 'basic_info_page_bloc.dart';

abstract class BasicInfoPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitBasicInfo extends BasicInfoPageEvent {
  final String name;
  final DateTime? birthday;

  SubmitBasicInfo(this.name, this.birthday);
}

class ResetBasicInfoValidation extends BasicInfoPageEvent {}
