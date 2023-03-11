part of 'post_auth_navigator_bloc.dart';

abstract class PostAuthNavigatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitializePage extends PostAuthNavigatorEvent {
  InitializePage();
}

class ChangeTab extends PostAuthNavigatorEvent {
  ChangeTab({required this.tab});

  final int tab;
}

class UpdateBottomAppBar extends PostAuthNavigatorEvent {
  UpdateBottomAppBar({required this.showBottomAppBar});

  final bool showBottomAppBar;
}
