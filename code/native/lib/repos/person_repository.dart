import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:local/repos/data/models/user/person.dart';

class PersonRepository {
  PersonRepository() {
    personStorage = Hive.box("persons");
  }

  late Box personStorage;

  Future<List<Person>> getPersonsFromStore() async {
    String jsonPersons = personStorage.get("persons");
    List<dynamic> dynamicPersons = jsonDecode(jsonPersons);
    List<Person> persons =
        dynamicPersons.map((e) => Person.fromJson(e)).toList();
    return persons;
  }

  Future<void> addPersonsToStore(List<Person> persons) async {
    String mapPersons = jsonEncode(persons);
    await personStorage.put("persons", mapPersons);
  }

  Future<Person?> getPerson({
    required int personID,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    List<Person> persons = await getPersonsFromStore();
    Person? person =
        persons.firstWhere((person) => person.personID == personID);
    return person;
  }
}
