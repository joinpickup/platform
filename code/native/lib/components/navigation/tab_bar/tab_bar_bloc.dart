import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(const TabBarState()) {
    on<InitializeTabBar>(_onInitTab);
    on<ChangeTabBarTab>(_onChangeTab);
  }

  Future<void> _onInitTab(
    InitializeTabBar event,
    Emitter<TabBarState> emit,
  ) async {
    emit(
      const TabBarState(),
    );
  }

  Future<void> _onChangeTab(
    ChangeTabBarTab event,
    Emitter<TabBarState> emit,
  ) async {
    emit(
      TabBarState(
        tab: event.tab,
      ),
    );
  }
}
