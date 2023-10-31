part of 'home_drawer_bloc_bloc.dart';

@immutable
sealed class HomeDrawerBlocEvent extends Equatable {}

class ChangeFeed extends HomeDrawerBlocEvent {
  final HomeDrawerFeed drawerFeed;

  ChangeFeed({
    required this.drawerFeed,
  });

  @override
  List<Object?> get props => [drawerFeed];
}
