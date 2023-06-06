import 'package:local/repos/data/models/space/space.dart';

List<Space> allSpaces = [
  const Space(
    name: "Music",
    spaceID: 1,
  ),
  const Space(
    name: "Sports",
    spaceID: 2,
  ),
  const Space(
    name: "Tabletop",
    spaceID: 3,
  ),
];

class SpaceRepository {
  Future<List<Space>> getAllSpaces() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return allSpaces;
  }
}
