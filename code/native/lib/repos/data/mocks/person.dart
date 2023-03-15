import 'package:local/repos/data/mocks/location.dart';
import 'package:local/repos/data/models/user/person.dart';

final andrew = Person(
  personID: 1,
  avatar: "assets/avatars/fox_ai.png",
  createdAt: DateTime.now(),
  name: "Andrew",
  username: "andyrewco",
  location: eastRock,
);

final brian = Person(
  personID: 2,
  avatar: "assets/avatars/koala_cropped.png",
  createdAt: DateTime.now(),
  name: "Brian",
  username: "windswept",
  location: eastRock,
);

final jay = Person(
  personID: 3,
  avatar: "assets/avatars/panda_cropped.png",
  createdAt: DateTime.now(),
  name: "Jay",
  username: "jay",
  location: eastRock,
);

final allPersons = [andrew, brian, jay];
