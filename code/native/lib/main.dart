import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local/navigator/post_auth/post_auth_navigator.dart';
import 'package:local/navigator/pre_auth/pre_auth_navigator.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/repos/person_repository.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/repos/user_repository.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:local/theme/dark_mode.dart';
import 'package:local/util/middleware/middleware.dart';

import 'dart:io';

import 'package:tailwind_colors/tailwind_colors.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        //add your certificate verification logic here
        return true;
      };
  }
}

Future main() async {
  // TODO: REMOVE ONLY FOR DEVELOPMENT
  HttpOverrides.global = MyHttpOverrides();

  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");

  // setup cache
  // posts
  Box postBox = await Hive.openBox('posts');
  List<Post> posts = [...allPosts];
  String mapPosts = jsonEncode(posts);
  await postBox.put("posts", mapPosts);

  // person
  Box personBox = await Hive.openBox('persons');
  List<Person> persons = [...allPersons];
  String mapPersons = jsonEncode(persons);
  await personBox.put("persons", mapPersons);

  // get pickup middleware

  // check for auth service and service registry
  final authEndpoint = dotenv.env["AUTH_ENDPOINT"];
  final registryEndpoint = dotenv.env["REGISTRY_ENDPOINT"];

  if (authEndpoint == null || registryEndpoint == null) {
    print('Missing environment variable: REGISTRY_ENDPOINT or AUTH_ENDPOINT');
    exit(1);
  }

  // setup mapbox stuff

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _postRepository = PostRepository();
  final _userRepository = const UserRepository();
  final _personRepository = PersonRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddPostBloc>(
          create: (context) => AddPostBloc(
            _postRepository,
            _personRepository,
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            userRepository: _userRepository,
            personRepository: _personRepository,
          )..add(AppStart(
              authEndpoint: dotenv.env["AUTH_ENDPOINT"] as String,
              registryEndpoint: dotenv.env["REGISTRY_ENDPOINT"] as String,
            )),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            switch (state.status) {
              case AuthStateStatus.authenticated:
                return const PostAuthNavigator();
              case AuthStateStatus.loading:
                return Scaffold(
                  backgroundColor: TW3Colors.gray.shade700,
                  body: Center(
                    child: Text(
                      "Local",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                );
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
