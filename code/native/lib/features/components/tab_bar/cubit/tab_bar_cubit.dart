import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarTab> {
  TabBarCubit() : super(TabBarTab.pinned);

  void changeTab(TabBarTab tab) => emit(tab);
}
