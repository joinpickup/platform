import 'dart:convert';
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
import 'package:local/shared/service_bloc/service_bloc.dart';
import 'package:local/theme/dark_mode.dart';
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

  final serviceName = dotenv.env["SERVICE_NAME"];
  final serviceID = dotenv.env["SERVICE_ID"];
  final servicePassword = dotenv.env["SERVICE_PASSWORD"];

  if (serviceName == null || serviceID == null || servicePassword == null) {
    print(
      'Missing environment variable: SERVICE_NAME or SERVICE_ID or SERVICE_PASSWORD',
    );
    exit(1);
  }

  // setup mapbox stuff

  runApp(MyApp(
    authEndpoint: authEndpoint,
    registryEndpoint: registryEndpoint,
    serviceName: serviceName,
    serviceID: int.parse(serviceID),
    servicePassword: servicePassword,
  ));
}

class MyApp extends StatefulWidget {
  final String authEndpoint;
  final String registryEndpoint;

  final String serviceName;
  final int serviceID;
  final String servicePassword;

  const MyApp({
    Key? key,
    required this.authEndpoint,
    required this.registryEndpoint,
    required this.serviceName,
    required this.serviceID,
    required this.servicePassword,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _postRepository = PostRepository();
  final _personRepository = PersonRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceBloc>(
      create: (context) => ServiceBloc()
        ..add(
          InitializePlatformService(
            serviceName: widget.serviceName,
            servicePassword: widget.servicePassword,
            serviceID: widget.serviceID,
            authEndpoint: widget.authEndpoint,
            registryEndpoint: widget.registryEndpoint,
          ),
        ),
      child: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          switch (state.status) {
            case ServiceStatus.success:
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
                      userRepository: UserRepository(
                          (context.read<ServiceBloc>().state
                                  as PlatformServiceState)
                              .authService,
                          null),
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
                        case AuthStateStatus.loading:
                          return Scaffold(
                            backgroundColor: TW3Colors.gray.shade700,
                            body: Center(
                              child: Text(
                                "Local",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
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
            default:
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: darkTheme,
                home: Scaffold(
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
                ),
              );
          }
        },
      ),
    );
  }
}
