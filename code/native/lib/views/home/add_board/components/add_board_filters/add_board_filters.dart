import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/cubit/board_filter_tab_bar_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/presentation/board_filter_tab_bar.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/presentation/tab_views/distance_filter_view.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/presentation/tab_views/tags_filter_view.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/presentation/tab_views/time_filter_view.dart';
import 'package:local/components/icon_button.dart';

Future<dynamic> showAddBoardFilters(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    enableDrag: true,
    isScrollControlled: true,
    builder: (_) {
      return const AddBoardFilters();
    },
  );
}

const filterViews = [
  TagsFilterView(),
  DistanceFilterView(),
  TimeFilterView(),
];

class AddBoardFilters extends StatefulWidget {
  const AddBoardFilters({Key? key}) : super(key: key);

  @override
  State<AddBoardFilters> createState() => _AddBoardFiltersState();
}

class _AddBoardFiltersState extends State<AddBoardFilters> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardFilterTabBarCubit(),
      child: BlocBuilder<BoardFilterTabBarCubit, BoardFilterTabBarTab>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              color: kColorSand,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTopRow(context),
                const BoardFilterCustomTabBar(),
                Expanded(child: filterViews[state.index]),
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
