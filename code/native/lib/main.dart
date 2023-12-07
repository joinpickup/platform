import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/features/home_screen.dart';
import 'package:local/theme/theme.dart';

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

    return MaterialApp(
      title: "Local",
      debugShowCheckedModeBanner: false,
      theme: LocalTheme.light,
      darkTheme: LocalTheme.dark,
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
