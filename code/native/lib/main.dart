import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/home/presentation/home.dart';
import 'package:local/features/locale/application/locale_bloc/locale_bloc_bloc.dart';
import 'package:local/features/locale/application/locale_service.dart';
import 'package:local/features/locale/domain/locale.dart';
import 'package:local/shared/application/app/app_bloc.dart';
import 'package:local/shared/application/service/service_bloc.dart';
import 'package:local/theme/theme.dart';
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
  PocketBase? pb;
  List<Locale> locales = [];
  try {
    final prefs = await SharedPreferences.getInstance();
    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );

    pb = PocketBase(apiEndpoint, authStore: store);

    final resultList = await pb.collection('locales').getList(
          page: 1,
          perPage: 50,
          filter: 'created >= "2022-01-01 00:00:00"',
        );

    for (RecordModel record in resultList.items) {
      Locale locale = Locale.fromRecord(record);
      locales.add(locale);
    }
  } catch (e) {
    log.severe("Error setting up pocketbase", [e]);
  }

  runApp(
    MyApp(
      pb: pb,
      locales: locales,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.pb, required this.locales});

  final PocketBase? pb;
  final List<Locale> locales;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: "Local",
      debugShowCheckedModeBanner: false,
      theme: LocalTheme.light,
      darkTheme: LocalTheme.dark,
      themeMode: ThemeMode.light,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ServiceBloc()
              ..add(
                LoadServices(
                  pocketbase: pb as PocketBase,
                ),
              ),
          ),
          BlocProvider(
            create: (context) => AppBloc(),
          ),
        ],
        child: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            switch (state.status) {
              case ServiceStatus.loaded:
                return BlocProvider(
                  create: (context) =>
                      LocaleBloc(state.localeService as LocaleService)
                        ..add(
                          LoadLocales(),
                        ),
                  child: const Home(),
                );
              default:
                return const SafeArea(
                  child: Text("loading"),
                );
            }
          },
        ),
      ),
    );
  }
}
