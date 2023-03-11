part of 'tab_bar_bloc.dart';

class TabBarState extends Equatable {
  const TabBarState({this.tab = 0});

  final int tab;

  @override
  List<Object?> get props => [tab];
}
