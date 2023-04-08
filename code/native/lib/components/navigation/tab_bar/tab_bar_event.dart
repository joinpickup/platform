part of 'tab_bar_bloc.dart';

abstract class TabBarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeTabBarTab extends TabBarEvent {
  ChangeTabBarTab({required this.tab});

  final int tab;
}

class InitializeTabBar extends TabBarEvent {}
