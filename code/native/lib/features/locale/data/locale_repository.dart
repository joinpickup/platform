import 'package:local/features/locale/domain/locale.dart';
import 'package:pocketbase/pocketbase.dart';

abstract class LocaleRepository {
  Future<List<Locale>> getLocales();
  Future<List<Locale>> searchLocales(String query);
}

class HttpLocaleRepository implements LocaleRepository {
  const HttpLocaleRepository({
    required this.pocketBase,
  });

  final PocketBase pocketBase;

  @override
  Future<List<Locale>> getLocales() async {
    final resultList = await pocketBase.collection('locales').getList(
          page: 1,
          perPage: 25,
        );

    List<Locale> locales = [];

    for (RecordModel record in resultList.items) {
      Locale locale = Locale.fromRecord(record);
      locales.add(locale);
    }

    return locales;
  }

  @override
  Future<List<Locale>> searchLocales(String query) async {
    final resultList = await pocketBase
        .collection('locales')
        .getList(page: 1, perPage: 25, filter: "display_name ~ %$query%");

    print(resultList);

    List<Locale> locales = [];

    for (RecordModel record in resultList.items) {
      Locale locale = Locale.fromRecord(record);
      locales.add(locale);
    }

    return locales;
  }
}
