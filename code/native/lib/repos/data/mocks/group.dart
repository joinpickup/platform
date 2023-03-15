import 'package:local/repos/data/mocks/location.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/group/group.dart';
import 'package:local/repos/data/models/group/group_member.dart';

import 'interest.dart';

final climbingGroup = Group(
  members: [
    GroupMember(
      person: andrew,
      memberType: GroupMemberType.admin,
    ),
    GroupMember(
      person: brian,
      memberType: GroupMemberType.member,
    ),
  ],
  groupID: 1,
  icon: "assets/icons/climbing-1.svg",
  location: eastRock,
  name: "Climbing Group",
  description: "A group dedicated to climbing in the New York area.",
  slug: "climb",
  interest: rockClimbingInterest,
);

final climbingGroup2 = Group(
  members: [
    GroupMember(
      person: andrew,
      memberType: GroupMemberType.member,
    ),
    GroupMember(
      person: brian,
      memberType: GroupMemberType.admin,
    ),
  ],
  location: eastRock,
  groupID: 2,
  icon: "assets/icons/climbing-2.svg",
  name: "Climbing Group2",
  description: "A second group dedicated to climbing in the New York area.",
  slug: "climb2",
  interest: rockClimbingInterest,
);

final soccerGroup1 = Group(
  icon: "assets/icons/soccer-1.svg",
  location: eastRock,
  members: [
    GroupMember(
      person: jay,
      memberType: GroupMemberType.member,
    ),
    GroupMember(
      person: andrew,
      memberType: GroupMemberType.admin,
    ),
  ],
  groupID: 3,
  name: "Soccer Group",
  description: "A group for soccer players",
  slug: "soc1",
  interest: soccerInterest,
);

final soccerGroup2 = Group(
  members: [
    GroupMember(
      person: jay,
      memberType: GroupMemberType.admin,
    ),
    GroupMember(
      person: brian,
      memberType: GroupMemberType.member,
    ),
  ],
  location: eastRock,
  groupID: 4,
  icon: "assets/icons/soccer-2.svg",
  name: "Soccer Group 2",
  description: "A group for soccer players",
  slug: "soc1",
  interest: soccerInterest,
);

final recommendedGroups = [climbingGroup, soccerGroup1];
final allGroups = [climbingGroup, climbingGroup2, soccerGroup1, soccerGroup2];
