import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:local/navigator/post_auth/post_auth_navigator.dart';
import 'package:local/navigator/pre_auth/pre_auth_navigator.dart';
import 'package:local/repos/person_repository.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/repos/user_repository.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:local/shared/service_bloc/service_bloc.dart';
import 'package:local/theme/dark_mode.dart';
import 'package:local/util/middleware/middleware.dart';
import 'package:logging/logging.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:web_socket_channel/io.dart';

extension ExtendedWidgetList on List<Widget> {
  /// Insert [widget] between each member of this list
  List<Widget> insertBetween(Widget widget) {
    if (length > 1) {
      for (var i = length - 1; i > 0; i--) {
        insert(i, widget);
      }
    }

    return this;
  }
}

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
  // setup logger
  final log = Logger("MainLogger");

  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");

  // check for auth service and service registry
  final authEndpoint = dotenv.env["AUTH_ENDPOINT"];
  final registryEndpoint = dotenv.env["REGISTRY_ENDPOINT"];

  if (authEndpoint == null || registryEndpoint == null) {
    log.severe(
        "Missing environment variable: REGISTRY_ENDPOINT or AUTH_ENDPOINT");
    exit(1);
  }

  final serviceName = dotenv.env["SERVICE_NAME"];
  final serviceID = dotenv.env["SERVICE_ID"];
  final servicePassword = dotenv.env["SERVICE_PASSWORD"];

  if (serviceName == null || serviceID == null || servicePassword == null) {
    log.severe(
        "Missing environment variable: SERVICE_NAME or SERVICE_ID or SERVICE_PASSWORD");
    exit(1);
  }

  // test things
  testWebSockets(
    authEndpoint,
    registryEndpoint,
    serviceName,
    int.parse(serviceID),
    servicePassword,
  );

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
                    create: (context) {
                      // need to do a null check here, we would be good beacuse of the status check above
                      final platformService = (context.read<ServiceBloc>().state
                              as PlatformServiceState?)
                          ?.platformService as ServiceInstance;

                      return AddPostBloc(
                        PostRepository(
                          platformService: platformService,
                        ),
                        PersonRepository(
                          platformService: platformService,
                        ),
                      );
                    },
                  ),
                  BlocProvider<AuthBloc>(
                    create: (context) {
                      // need to do a null check here, we would be good beacuse of the status check above
                      final authService = (context.read<ServiceBloc>().state
                              as PlatformServiceState?)
                          ?.authService as ServiceInstance;

                      final platformService = (context.read<ServiceBloc>().state
                              as PlatformServiceState?)
                          ?.platformService as ServiceInstance;

                      return AuthBloc(
                          userRepository: UserRepository(
                            authService,
                            null,
                          ),
                          personRepository: PersonRepository(
                            platformService: platformService,
                          ));
                    },
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
            case ServiceStatus.error:
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: darkTheme,
                home: Scaffold(
                  backgroundColor: TW3Colors.gray.shade700,
                  body: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        "Cannot connect to the internet...",
                        style: TextStyle(
                          color: TW3Colors.gray.shade300,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
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
                      style: TextStyle(
                        color: TW3Colors.gray.shade300,
                        fontSize: 26,
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

Future<FutureOr<void>> testWebSockets(
  String authEndpoint,
  String registryEndpoint,
  String serviceName,
  int serviceID,
  String servicePassword,
) async {
  ServiceEntity serviceEntity = ServiceEntity(
    serviceName: serviceName,
    serviceID: serviceID,
    password: servicePassword,
  );

  // get platform service
  MiddlewareClient platformClient = await serviceEntity.newClient(
    authEndpoint,
    registryEndpoint,
  );

  ServiceInstance platformService =
      await platformClient.newServiceInstance("PlatformService");

  IOWebSocketChannel channel =
      await platformService.newWebSocketChannel("/v1/action/message/ws");

  // Send a message
  channel.sink.add('Hello from Flutter!');

  // Receive messages
  channel.stream.listen(
    (message) {
      // Handle received messages
      print('Received message: message');
    },
  );
}
