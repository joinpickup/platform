import 'package:local/models/group.dart';

import 'interest.dart';

final climbingGroup = Group(
  groupID: 1,
  name: "Climbing Group",
  description: "A group dedicated to climbing in the New York area.",
  slug: "climb",
  interest: rockClimbingInterest,
);

final climbingGroup2 = Group(
  groupID: 2,
  name: "Climbing Group2",
  description: "A second group dedicated to climbing in the New York area.",
  slug: "climb2",
  interest: rockClimbingInterest,
);

final allGroups = [climbingGroup, climbingGroup2];
