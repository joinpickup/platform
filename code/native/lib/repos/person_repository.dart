import 'dart:convert';

import 'package:http/http.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/util/middleware/middleware.dart';

class PersonRepository {
  PersonRepository({
    required this.platformService,
  });

  ServiceInstance platformService;

  Future<List<Person>> getPersonsFromStore() async {
    return [];
  }

  Future<void> addPersonsToStore(List<Person> persons) async {}

  Future<Person?> getPerson({
    required int personID,
  }) async {
    // get stuff from API

    try {
      Response personRes =
          await platformService.newRequest("GET", "/v1/person/$personID", null);

      // need to serialize
      Map<String, dynamic> personDynamic = jsonDecode(personRes.body);
      Person person = Person.fromJson(personDynamic);

      return person;
    } catch (e) {
      Future.error(e);
    }

    return null;
  }
}
