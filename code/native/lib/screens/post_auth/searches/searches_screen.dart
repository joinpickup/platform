import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/screens/post_auth/searches/views/add_search/add_search_modal.dart';
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
      child: Scaffold(
        backgroundColor: TW3Colors.gray.shade700,
        appBar: AppBar(
          backgroundColor: TW3Colors.gray.shade700,
          elevation: 0,
          title: const Text("Searches"),
          actions: [
            IconButton(
              onPressed: () {
                showAddSearchModal(context);
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
            const Expanded(
              child: SearchFeed(),
            ),
          ],
        ),
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
