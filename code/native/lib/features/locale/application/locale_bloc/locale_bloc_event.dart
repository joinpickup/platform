part of 'locale_bloc_bloc.dart';

@immutable
sealed class LocaleEvent {}

class LoadLocales extends LocaleEvent {}

class SearchLocales extends LocaleEvent {
  final String query;

  SearchLocales({required this.query});
}
