part of 'person_bloc.dart';

enum PersonStatus { loading, success, error }

class PersonState extends Equatable {
  const PersonState({
    required this.personRepository,
    this.status = PersonStatus.loading,
    this.person,
  });

  final PersonRepository personRepository;
  final PersonStatus status;
  final Person? person;

  @override
  List<Object?> get props => [
        personRepository,
        status,
      ];

  PersonState copyWith({
    PersonRepository? personRepository,
    PersonStatus? status,
    Person? person,
  }) {
    return PersonState(
      personRepository: personRepository ?? this.personRepository,
      status: status ?? this.status,
      person: person ?? this.person,
    );
  }
}
