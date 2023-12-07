import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/components/board_feed.dart';
import 'package:local/features/components/tab_bar/cubit/tab_bar_cubit.dart';
import 'package:local/features/components/tab_bar/presentation/tab_bar.dart';
import 'package:local/features/components/top_bar.dart';

const fColorRoyal = Color(0xFF152834);
const fColorSand = Color(0xFFF5E8DA);

// card
const fColorCardBlue = Color(0xFFB5C1B9);
const fColorCardBlueAccent = Color(0xFF324E5F);

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TabBarCubit(),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
