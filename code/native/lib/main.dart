import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/cubit/theme_cubit.dart';
import 'package:local/theme/theme.dart';
import 'package:local/views/home/home_screen/home_screen.dart';

Future<void> main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: "Local",
            debugShowCheckedModeBanner: false,
            theme: LocalTheme.light,
            darkTheme: LocalTheme.dark,
            themeMode: state,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
