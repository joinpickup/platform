import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/cubit/board_filter_tab_bar_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/board_filter_tab_bar/presentation/board_filter_tab_bar.dart';

Future<dynamic> showAddBoardFilters(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    enableDrag: true,
    isScrollControlled: true,
    builder: (_) {
      return BlocProvider(
        create: (context) => BoardFilterTabBarCubit(),
        child: const AddBoardFilters(),
      );
    },
  );
}

class AddBoardFilters extends StatefulWidget {
  const AddBoardFilters({Key? key}) : super(key: key);

  @override
  State<AddBoardFilters> createState() => _AddBoardFiltersState();
}

class _AddBoardFiltersState extends State<AddBoardFilters>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        TabController(length: BoardFilterTabBarTab.values.length, vsync: this);

    _controller.addListener(() {
      context
          .read<BoardFilterTabBarCubit>()
          .changeTab(BoardFilterTabBarTab.values[_controller.index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: kColorSand,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTopRow(context),
            const BoardFilterCustomTabBar(),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: BoardFilterTabBarTab.values.map((e) {
                  return Center(
                    child: Text(
                      e.text,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
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
