import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board.dart';
import 'package:local/views/home/components/board_feed.dart';
import 'package:local/views/home/components/tab_bar/cubit/tab_bar_cubit.dart';
import 'package:local/views/home/components/tab_bar/presentation/tab_bar.dart';
import 'package:local/views/home/components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBoard(context);
        },
        child: SvgPicture.string(
          kIconPlus,
          width: 36,
          height: 36,
          theme: const SvgTheme(
            currentColor: kColorSand,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TabBarCubit(),
        child: const SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              0.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TopBar(),
                SizedBox(
                  height: 8,
                ),
                CustomTabBar(),
                SizedBox(
                  height: 8,
                ),
                BoardFeed(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
