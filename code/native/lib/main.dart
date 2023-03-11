import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/pre_auth/pre_auth_navigator.dart';
import 'package:local/repos/user_repository.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:local/theme/dark_mode.dart';

import 'navigator/post_auth/post_auth_navigator/post_auth_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(userRepository: const UserRepository()),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            switch (state.status) {
              case AuthStateStatus.authenticated:
                return const PostAuthNavigator();
              default:
                return const PreAuthNavigator();
            }
          },
        ),
        theme: darkTheme,
      ),
    );
  }
}
