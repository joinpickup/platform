import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/repos/person_repository.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc(personRepository)
      : super(PersonState(personRepository: personRepository)) {
    on<LoadPerson>(_onLoadPerson);
  }

  Future<void> _onLoadPerson(
    LoadPerson event,
    Emitter<PersonState> emit,
  ) async {
    Person? person =
        await state.personRepository.getPerson(personID: event.personID);

    if (person == null) {
      emit(state.copyWith(
        person: person,
        status: PersonStatus.error,
      ));
    }

    emit(state.copyWith(
      person: person,
      status: PersonStatus.success,
    ));
  }
}
