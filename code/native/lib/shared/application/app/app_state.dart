part of 'app_bloc.dart';

@immutable
sealed class AppState extends Equatable {
  final Locale? locale;

  const AppState({this.locale});

  @override
  List<Object?> get props => [locale];
}

final class AppInitial extends AppState {
  const AppInitial();
}

final class UpdateLocaleState extends AppState {
  const UpdateLocaleState({required super.locale});
}
