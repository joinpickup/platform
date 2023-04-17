part of 'service_bloc.dart';

enum ServiceStatus { initial, loading, success, error }

abstract class ServiceState extends Equatable {
  final ServiceStatus status;

  const ServiceState({
    this.status = ServiceStatus.initial,
  });

  @override
  List<Object?> get props => [status];
}

class InitialServiceState extends ServiceState {}

class UserServiceState extends ServiceState {
  final ServiceInstance platformService;
  final ServiceInstance authService;

  const UserServiceState({
    required this.platformService,
    required this.authService,
    super.status,
  });

  @override
  List<Object?> get props => [platformService, authService];

  UserServiceState copyWith({
    ServiceInstance? platformService,
    ServiceInstance? authService,
    ServiceStatus? status,
  }) {
    return UserServiceState(
      platformService: platformService ?? this.platformService,
      authService: authService ?? this.authService,
      status: status ?? this.status,
    );
  }
}

class PlatformServiceState extends ServiceState {
  final ServiceInstance platformService;
  final ServiceInstance authService;

  const PlatformServiceState({
    required this.platformService,
    required this.authService,
    super.status,
  });

  @override
  List<Object?> get props => [platformService, authService];

  PlatformServiceState copyWith({
    ServiceInstance? platformService,
    ServiceInstance? authService,
    ServiceStatus? status,
  }) {
    return PlatformServiceState(
      platformService: platformService ?? this.platformService,
      authService: authService ?? this.authService,
      status: status ?? this.status,
    );
  }
}
