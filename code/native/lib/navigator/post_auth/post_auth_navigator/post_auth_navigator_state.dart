part of 'post_auth_navigator_bloc.dart';

class PostAuthNavigatorState extends Equatable {
  const PostAuthNavigatorState({
    this.showBottomAppBar = true,
    this.tab = 0,
  });

  final int tab;
  final bool showBottomAppBar;

  @override
  List<Object?> get props => [tab, showBottomAppBar];

  PostAuthNavigatorState copyWith({
    int? tab,
    bool? showBottomAppBar,
  }) {
    return PostAuthNavigatorState(
      tab: tab ?? this.tab,
      showBottomAppBar: showBottomAppBar ?? this.showBottomAppBar,
    );
  }
}
