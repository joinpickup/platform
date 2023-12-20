import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/board_filter_tab_bar/cubit/board_filter_tab_bar_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/board_filter_tab_bar/presentation/board_filter_tab_bar.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/distance_filter_view.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/cubit/tags_filter_view_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/presentation/tags_filter_view.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/time_filter_view.dart';

Future<dynamic> showAddBoardFilters(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    enableDrag: false,
    isScrollControlled: true,
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: const AddBoardFilters(),
      );
    },
  );
}

const filterViews = [
  TagsFilterView(),
  DistanceFilterView(),
  TimeFilterView(),
];

class AddBoardFilters extends StatelessWidget {
  const AddBoardFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BoardFilterTabBarCubit(),
        ),
        BlocProvider(
          create: (context) => TagsFilterViewCubit(),
        ),
      ],
      child: BlocBuilder<BoardFilterTabBarCubit, BoardFilterTabBarTab>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              color: kColorSand,
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTopRow(context),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                          "Modify the tags, distance and time to match posts that you want to be notified of."),
                      const BoardFilterCustomTabBar(),
                      filterViews[state.index],
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ApplyButton(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Board Filters",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomIconButton(
          icon: kIconClose,
          click: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ApplyButton extends StatelessWidget {
  const ApplyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kColorRoyal,
        ),
        child: Center(
          child: Text(
            "Apply",
            style: TextStyle(
              color: kColorSand,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
