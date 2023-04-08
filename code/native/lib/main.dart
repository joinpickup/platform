import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

Future main() async {
  await Hive.initFlutter();

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

  // setup mapbox stuff

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
