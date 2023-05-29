part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPerson extends PersonEvent {
  LoadPerson({required this.personID});

  final int personID;
}
