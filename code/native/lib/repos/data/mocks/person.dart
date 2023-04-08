import 'package:local/repos/data/mocks/location.dart';
import 'package:local/repos/data/models/user/person.dart';

final andrew = Person(
  personID: 1,
  userID: 1,
  avatar: "assets/avatars/fox_ai.png",
  createdAt: DateTime.now(),
  name: "Andrew",
  username: "andyrewco",
  location: eastRock,
);

final brian = Person(
  personID: 2,
  userID: 2,
  avatar: "assets/avatars/koala_cropped.png",
  createdAt: DateTime.now(),
  name: "Brian",
  username: "windswept",
  location: eastRock,
);

final jay = Person(
  personID: 3,
  userID: 3,
  avatar: "assets/avatars/panda_cropped.png",
  createdAt: DateTime.now(),
  name: "Jay",
  username: "jay",
  location: eastRock,
);

final stef = Person(
  personID: 4,
  userID: 4,
  avatar: "assets/avatars/panda_cropped.png",
  createdAt: DateTime.now(),
  name: "Stef",
  username: "stef",
  location: eastRock,
);

final allPersons = [andrew, brian, jay, stef];
