import 'dart:convert';

import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/mocks/space.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/repos/data/models/user/person.dart';

class SpaceRepository {
  SpaceRepository();

  Future<List<Space>> getAllSpaces() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return allSpaces;
  }

  Future<List<Interest>> getAllInterestsForASpace(Space space) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return allInterests
        .where(
          (element) => element.space.spaceID == space.spaceID,
        )
        .toList();
  }
}
