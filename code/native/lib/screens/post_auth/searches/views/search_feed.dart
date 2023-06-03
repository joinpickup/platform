import 'package:flutter/material.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/screens/post_auth/searches/views/search_card.dart';

List<Search> searches = [
  Search(
    searchID: 1,
    createdAt: DateTime.now(),
    name: "Tennis Posts",
    description: "All posts related to tennis.",
    posts: [
      andrewPost,
    ],
  ),
  Search(
    searchID: 2,
    createdAt: DateTime.now(),
    name: "Posts about soccer",
    description: "All posts related to soccer.",
    posts: [
      andrewPost,
      brianPost,
    ],
  ),
];

class SearchFeed extends StatefulWidget {
  const SearchFeed({Key? key}) : super(key: key);

  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      child: ListView.separated(
        itemCount: searches.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemBuilder: (context, index) {
          return SearchCard(
            search: searches[index],
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
