import 'dart:convert';

import 'package:http/http.dart';
import 'package:local/repos/data/mocks/space.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/util/middleware/middleware.dart';

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
  Interest(
    interestID: 5,
    name: "Classical",
    space: allSpaces[0],
  ),
  Interest(
    interestID: 6,
    name: "R&B",
    space: allSpaces[0],
  ),
  Interest(
    interestID: 7,
    name: "Rap",
    space: allSpaces[0],
  ),
];

class InterestRepository {
  InterestRepository({
    required this.platformService,
  });

  final ServiceInstance platformService;

  Future<List<Interest>> getAllIntersts() async {
    // get stuff from API
    Response interestsRes =
        await platformService.newRequest("GET", "/v1/interest", null);

    // need to serialize
    List<dynamic> interestsDynamic = jsonDecode(interestsRes.body);
    List<Interest> interests =
        interestsDynamic.map((e) => Interest.fromJson(e)).toList();

    return interests;
  }

  Future<List<Interest>> searchinterests(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    List<Interest> filteredInterests = allInterests.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return filteredInterests;
  }
}
