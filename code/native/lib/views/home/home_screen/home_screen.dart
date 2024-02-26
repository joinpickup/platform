import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/components/add_dialog.dart';
import 'package:local/views/home/home_screen/components/board_feed.dart';
import 'package:local/views/home/home_screen/components/tab_bar/cubit/tab_bar_cubit.dart';
import 'package:local/views/home/home_screen/components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        child: SvgPicture.string(
          kIconPlus,
          width: 36,
          height: 36,
          theme: SvgTheme(
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
                  height: 16,
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
