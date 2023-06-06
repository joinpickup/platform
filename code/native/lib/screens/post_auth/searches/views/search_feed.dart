import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/screens/post_auth/post/post_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/bloc/space_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/search_card.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({
    Key? key,
    required this.searches,
  }) : super(key: key);

  final List<Search> searches;

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
        itemCount: widget.searches.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemBuilder: (context, index) {
          return SearchCard(
            search: widget.searches[index],
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
