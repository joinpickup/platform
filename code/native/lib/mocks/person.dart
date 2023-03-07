import 'package:local/mocks/location.dart';

import '../models/person.dart';

final andrew = Person(
  personID: 1,
  createdAt: DateTime.now(),
  name: "Andrew",
  username: "andyrewco",
  location: eastRockClimb,
);

final brian = Person(
  personID: 2,
  createdAt: DateTime.now(),
  name: "Brian",
  username: "windswept",
  location: eastRockClimb,
);

final allPersons = [andrew, brian];
