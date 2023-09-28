import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/locale/application/locale_service.dart';
import 'package:local/features/locale/domain/locale.dart';

part 'locale_bloc_event.dart';
part 'locale_bloc_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(
    this.localeService,
  ) : super(LocaleInitial()) {
    on<LoadLocales>(_loadLocales);
    on<SearchLocales>(_searchLocales);
  }

  final LocaleService localeService;

  FutureOr<void> _loadLocales(event, emit) async {
    try {
      List<Locale> locales = await localeService.getLocales();

      emit(
        LocaleStateLoaded(
          locales: locales,
        ),
      );
    } catch (e) {
      emit(
        LocaleStateError(),
      );
    }
  }

  FutureOr<void> _searchLocales(event, emit) async {
    try {
      List<Locale> locales = await localeService.searchLocales(event.query);

      emit(
        LocaleStateLoaded(
          locales: locales,
        ),
      );
    } catch (e) {
      emit(
        LocaleStateError(),
      );
    }
  }
}
