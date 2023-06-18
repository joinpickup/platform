import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/search_repository.dart';
import 'package:local/screens/post_auth/searches/bloc/searches_screen_bloc.dart';
import 'package:local/screens/post_auth/searches/views/add_edit_search_modal/add_edit_search_modal.dart';
import 'package:local/screens/post_auth/searches/views/search_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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
      child: BlocProvider(
        create: (context) => SearchesScreenBloc(
          SearchRepository(),
        )..add(LoadSearches()),
        child: BlocConsumer<TabBarBloc, TabBarState>(
          listener: (context, state) {
            switch (state.tab) {
              // this is recommended
              case 0:
                context
                    .read<SearchesScreenBloc>()
                    .add(LoadSearches(type: SearchType.recommended));
                break;
              // this is saved
              case 1:
                context
                    .read<SearchesScreenBloc>()
                    .add(LoadSearches(type: SearchType.saved));
                break;
              // this is more
              case 2:
                context
                    .read<SearchesScreenBloc>()
                    .add(LoadSearches(type: SearchType.more));
                break;
              default:
            }
          },
          builder: (context, tabBarState) {
            return BlocBuilder<SearchesScreenBloc, SearchesScreenState>(
              builder: (context, searchState) {
                switch (searchState.status) {
                  case SearchStatus.success:
                    return _buildSuccess(context, searchState);
                  default:
                    return _buildLoading(context, searchState);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Scaffold _buildSuccess(
      BuildContext context, SearchesScreenState searchState) {
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
              searches: searchState.searches,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _buildLoading(
      BuildContext context, SearchesScreenState searchState) {
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
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
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
