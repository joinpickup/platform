part of 'basic_info_page_bloc.dart';

enum BasicInfoPageStatus { error, initial, success }

enum BasicInfoPageError { name, birthday }

class BasicInfoPageState extends Equatable {
  final String? name;
  final DateTime? birthday;
  final BasicInfoPageError? error;
  final BasicInfoPageStatus status;

  const BasicInfoPageState({
    this.name,
    this.error,
    this.birthday,
    this.status = BasicInfoPageStatus.initial,
  });

  @override
  List<Object?> get props => [name, status, birthday, error];

  BasicInfoPageState copyWith({
    String? name,
    DateTime? birthday,
    BasicInfoPageError? error,
    BasicInfoPageStatus? status,
  }) {
    return BasicInfoPageState(
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
