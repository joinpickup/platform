import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/locale/application/locale_bloc/locale_bloc_bloc.dart';
import 'package:local/features/locale/data/locale_repository.dart';
import 'package:local/features/locale/domain/locale.dart';
import 'package:local/features/locale/presentation/locale_dialog.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final log = Logger("MainLogger");
  await dotenv.load(fileName: ".env");

  // check for auth service and service registry
  final apiEndpoint = dotenv.env["API_ENDPOINT"];

  if (apiEndpoint == null) {
    log.severe("Missing environment variable: API_ENDPOINT");
    exit(1);
  }

  // to create pocketbase instances, lets grab the auth store
  try {
    final prefs = await SharedPreferences.getInstance();
    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );
    final pb = PocketBase(apiEndpoint, authStore: store);

    final resultList = await pb.collection('locales').getList(
          page: 1,
          perPage: 50,
          filter: 'created >= "2022-01-01 00:00:00"',
        );

    List<Locale> locales = [];

    for (RecordModel record in resultList.items) {
      Locale locale = Locale.fromRecord(record);
      locales.add(locale);
    }

    runApp(MyApp(pb: pb));
  } catch (e) {
    log.severe("Error setting up pocketbase", [e]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.pb});

  final PocketBase pb;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => LocaleBloc(HttpLocaleRepository(
          pocketBase: pb,
        ))
          ..add(LoadLocales()),
        child: LocaleDialog(),
      ),
    );
  }
}
