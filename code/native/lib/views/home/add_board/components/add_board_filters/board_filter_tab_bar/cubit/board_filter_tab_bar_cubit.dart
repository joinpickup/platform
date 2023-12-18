import 'package:flutter_bloc/flutter_bloc.dart';

part 'board_filter_tab_bar_state.dart';

class BoardFilterTabBarCubit extends Cubit<BoardFilterTabBarTab> {
  BoardFilterTabBarCubit() : super(BoardFilterTabBarTab.tags);

  void changeTab(BoardFilterTabBarTab tab) => emit(tab);
}
