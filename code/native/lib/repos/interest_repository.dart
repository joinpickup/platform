import 'package:local/repos/data/mocks/space.dart';
import 'package:local/repos/data/models/space/interest.dart';

List<Interest> allInterests = [
  Interest(
    interestID: 1,
    name: "Country",
    space: allSpaces[0],
  ),
  Interest(
    interestID: 2,
    name: "Alternative",
    space: allSpaces[0],
  ),
  Interest(
    interestID: 3,
    name: "Jazz",
    space: allSpaces[0],
  ),
  Interest(
    interestID: 4,
    name: "Pop",
    space: allSpaces[0],
  ),
];

class InterestRepository {
  Future<List<Interest>> getAllInterests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return allInterests;
  }
}
