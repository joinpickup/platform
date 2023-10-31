part of 'app_bloc.dart';

enum AppLocaleStatus { init, loaded, error }

@immutable
sealed class AppState extends Equatable {
  final Locale? locale;
  final AppLocaleStatus localeStatus;

  const AppState({this.locale, this.localeStatus = AppLocaleStatus.init});

  @override
  List<Object?> get props => [locale, localeStatus];
}

final class AppInitial extends AppState {
  const AppInitial();
}

final class UpdateLocaleState extends AppState {
  const UpdateLocaleState({required locale})
      : super(
          locale: locale,
          localeStatus: AppLocaleStatus.loaded,
        );
}

final class UpdateLocaleStateError extends AppState {
  const UpdateLocaleStateError()
      : super(
          localeStatus: AppLocaleStatus.error,
        );
}
