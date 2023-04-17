part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {}

class InitializeUserService extends ServiceEvent {
  final String token;
  final String authEndpoint;
  final String registryEndpoint;

  InitializeUserService({
    required this.token,
    required this.authEndpoint,
    required this.registryEndpoint,
  });
}

class InitializePlatformService extends ServiceEvent {
  final String serviceName;
  final String servicePassword;
  final int serviceID;
  final String authEndpoint;
  final String registryEndpoint;

  InitializePlatformService({
    required this.serviceName,
    required this.servicePassword,
    required this.serviceID,
    required this.authEndpoint,
    required this.registryEndpoint,
  });
}
