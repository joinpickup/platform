import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/filter/search.dart';

List<Search> allSearches = [];

List<Search> recommendedSearches = [
  Search(
    searchID: 1,
    isPublic: false,
    owner: andrew,
    notificationsEnabled: true,
    createdAt: DateTime.now(),
    name: "Tennis Posts",
    description: "All posts related to tennis.",
    posts: [
      andrewPost,
    ],

    // interest
    spaces: [],
    interests: allInterests,
  ),
];

List<Search> savedSearches = [
  Search(
    searchID: 2,
    isPublic: false,
    owner: andrew,
    notificationsEnabled: true,
    createdAt: DateTime.now(),
    name: "Soccer Posts",
    description: "All posts related to soccerr.",
    posts: [
      andrewPost,
      brianPost,
      jayPost,
    ],
    spaces: [],
    interests: allInterests,
  ),
];

List<Search> moreSearches = [
  Search(
    searchID: 2,
    isPublic: false,
    owner: andrew,
    notificationsEnabled: true,
    createdAt: DateTime.now(),
    name: "Recent Posts",
    description: "All the most recent posts.",
    posts: [
      andrewPost,
      brianPost,
    ],
    spaces: [],
    interests: allInterests,
  ),
];

List<List<Search>> listOfListOfSearches = [
  recommendedSearches,
  savedSearches,
  moreSearches,
];

class SearchRepository {
  Future<List<Search>> getRecommendedSearches() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return recommendedSearches;
  }

  Future<List<Search>> getSavedSearches() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return savedSearches;
  }

  Future<List<Search>> getMoreSearches() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return moreSearches;
  }
}
