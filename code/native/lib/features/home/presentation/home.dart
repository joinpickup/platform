import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/home/application/home_drawer_bloc/home_drawer_bloc_bloc.dart';
import 'package:local/features/home/presentation/home_drawer.dart';
import 'package:local/features/home/presentation/home_end_drawer.dart';
import 'package:local/features/home/presentation/search_sheet.dart';
import 'package:local/shared/presentation/black_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDrawerBlocBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            drawer: const HomeDrawer(),
            endDrawer: const HomeEndDrawer(),
            body: BlocBuilder<HomeDrawerBlocBloc, HomeDrawerBlocState>(
              builder: (context, state) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        // feed
                        Column(
                          // header bar
                          children: [
                            Row(
                              children: [
                                // title
                                Text(
                                  state.drawerFeed.display,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                ),
                                const Spacer(),
                                // button
                                const NewBoardButton(),
                              ],
                            ),
                          ],
                        ),
                        // search bar
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              showSearchBottomSheet(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(-1, 1),
                                    blurRadius: 8,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              child: const ActionBar(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ActionBar extends StatelessWidget {
  const ActionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // left button
        BlackButton(
          icon: Icons.menu,
          click: (context) {
            Scaffold.of(context).openDrawer();
          },
        ),

        // search bar
        const SearchBar(),

        // right button
        BlackButton(
          icon: Icons.person,
          click: (context) {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          "Search...",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class NewBoardButton extends StatelessWidget {
  const NewBoardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-1, 1),
            blurRadius: 8,
            color: Colors.black,
          ),
        ],
      ),
      child: Text(
        "New Board",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
