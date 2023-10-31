import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local/features/locale/domain/locale.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitial()) {
    on<UpdateLocale>((event, emit) {
      emit(UpdateLocaleState(locale: event.locale));
    });
  }
}
