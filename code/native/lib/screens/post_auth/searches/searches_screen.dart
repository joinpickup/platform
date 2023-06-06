import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/repos/space_repository.dart';
import 'package:local/screens/post_auth/searches/views/add_edit_search_modal/add_edit_search_modal.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/space_filter_modal/bloc/space_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/search_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

List<Search> recommended = [
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
  ),
];

List<Search> saved = [
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
  ),
];

List<Search> more = [
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
  ),
];

List<List<Search>> listOfListOfSearches = [
  recommended,
  saved,
  more,
];

class SearchesScreen extends StatelessWidget {
  const SearchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, tabBarState) {
          return Scaffold(
            backgroundColor: TW3Colors.gray.shade700,
            appBar: AppBar(
              backgroundColor: TW3Colors.gray.shade700,
              elevation: 0,
              title: const Text("Searches"),
              actions: [
                IconButton(
                  onPressed: () {
                    showAddEditSearchModal(
                      context,
                      null,
                      SearchModalType.add,
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _buildTabBar(),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: SearchFeed(
                    searches: listOfListOfSearches[tabBarState.tab],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  CustomTabBar _buildTabBar() {
    return CustomTabBar(
      small: true,
      tabs: [
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Recommended",
          tab: 0,
          small: true,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Saved",
          tab: 1,
          small: true,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "More",
          tab: 2,
          small: true,
        ),
      ],
    );
  }
}
