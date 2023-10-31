part of 'home_drawer_bloc_bloc.dart';

extension StringExtensions on String {
  String toNormalCase() {
    // Split the input string by whitespace to get individual words
    List<String> words = split(' ');

    // Capitalize the first letter of each word and make the rest lowercase
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).toList();

    // Join the words back together with a space
    return capitalizedWords.join(' ');
  }
}

enum HomeDrawerFeed { discover, following, recent, popular, random }

extension HomeDrawerFeedIcon on HomeDrawerFeed {
  IconData get icon {
    switch (this) {
      case HomeDrawerFeed.discover:
        return Icons.home;
      case HomeDrawerFeed.following:
        return Icons.person;
      case HomeDrawerFeed.recent:
        return Icons.schedule;
      case HomeDrawerFeed.popular:
        return Icons.trending_up;
      case HomeDrawerFeed.random:
        return Icons.help;
      default:
        return Icons.note;
    }
  }

  String get display {
    return name.toNormalCase();
  }

  String get description {
    switch (this) {
      case HomeDrawerFeed.discover:
        return "Discover new boards";
      case HomeDrawerFeed.following:
        return "See the boards that you follow";
      case HomeDrawerFeed.recent:
        return "See the most recent boards";
      case HomeDrawerFeed.popular:
        return "Only see the most popular boards";
      case HomeDrawerFeed.random:
        return "See a random board";
      default:
        return "Discover new boards that we think you will like";
    }
  }
}

@immutable
sealed class HomeDrawerBlocState extends Equatable {
  final HomeDrawerFeed drawerFeed;

  const HomeDrawerBlocState({
    this.drawerFeed = HomeDrawerFeed.discover,
  });

  @override
  List<Object?> get props => [drawerFeed];
}

final class HomeDrawerBlocInitial extends HomeDrawerBlocState {
  const HomeDrawerBlocInitial();
}

final class HomeDrawerBlocFeedChange extends HomeDrawerBlocState {
  const HomeDrawerBlocFeedChange({drawerFeed}) : super(drawerFeed: drawerFeed);
}
