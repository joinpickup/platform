part of 'locale_bloc_bloc.dart';

enum LocaleDialogStatus { init, loaded, error }

sealed class LocaleState extends Equatable {
  final List<Locale> locales;
  final LocaleDialogStatus status;

  const LocaleState({
    required this.locales,
    this.status = LocaleDialogStatus.init,
  });

  @override
  List<Object?> get props => [locales, status];
}

final class LocaleInitial extends LocaleState {
  LocaleInitial() : super(locales: []);
}

final class LocaleStateLoaded extends LocaleState {
  const LocaleStateLoaded({
    required super.locales,
    super.status = LocaleDialogStatus.loaded,
  });
}

final class LocaleStateError extends LocaleState {
  LocaleStateError()
      : super(
          locales: [],
          status: LocaleDialogStatus.loaded,
        );
}
