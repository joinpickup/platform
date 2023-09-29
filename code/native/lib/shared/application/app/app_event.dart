part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class UpdateLocale extends AppEvent {
  final Locale locale;

  UpdateLocale({required this.locale});
}
