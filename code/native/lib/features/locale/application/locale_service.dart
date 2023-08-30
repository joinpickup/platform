import 'dart:async';

import 'package:local/features/locale/data/locale_repository.dart';
import 'package:local/features/locale/domain/locale.dart';

class LocaleService {
  const LocaleService(
    this._localeRepository,
  );

  final LocaleRepository _localeRepository;

  Future<List<Locale>> getLocales() async {
    // handle the different state cases
    try {
      return _localeRepository.getLocales();
    } catch (e) {
      // TODO: parse for common errors
      return Future.error(e);
    }
  }
}
