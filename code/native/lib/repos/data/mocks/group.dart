import 'package:local/repos/data/mocks/location.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/group.dart';

import 'interest.dart';

final climbingGroup = Group(
  members: [andrew, brian],
  groupID: 1,
  location: eastRock,
  name: "Climbing Group",
  description: "A group dedicated to climbing in the New York area.",
  slug: "climb",
  interest: rockClimbingInterest,
);

final climbingGroup2 = Group(
  members: [brian],
  location: eastRock,
  groupID: 2,
  name: "Climbing Group2",
  description: "A second group dedicated to climbing in the New York area.",
  slug: "climb2",
  interest: rockClimbingInterest,
);

final soccerGroup1 = Group(
  location: eastRock,
  members: [andrew],
  groupID: 3,
  name: "Soccer Group",
  description: "A group for soccer players",
  slug: "soc1",
  interest: soccerInterest,
);

final soccerGroup2 = Group(
  members: [andrew],
  location: eastRock,
  groupID: 4,
  name: "Soccer Group 2",
  description: "A group for soccer players",
  slug: "soc1",
  interest: soccerInterest,
);

final recommendedGroups = [climbingGroup, soccerGroup1];
final allGroups = [climbingGroup, climbingGroup2, soccerGroup1, soccerGroup2];
