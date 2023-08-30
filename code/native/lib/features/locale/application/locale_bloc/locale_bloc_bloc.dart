import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/locale/data/locale_repository.dart';
import 'package:local/features/locale/domain/locale.dart';

part 'locale_bloc_event.dart';
part 'locale_bloc_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocalState> {
  LocaleBloc(this.localeRepository) : super(LocaleInitial()) {
    on<LoadLocales>(_loadLocales);
  }

  final LocaleRepository localeRepository;

  FutureOr<void> _loadLocales(event, emit) async {
    List<Locale> locales = await localeRepository.getLocales();

    print(locales);
  }
}
