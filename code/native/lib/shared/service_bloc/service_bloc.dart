import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local/util/middleware/middleware.dart';
import 'package:meta/meta.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(InitialServiceState()) {
    on<InitializeUserService>(_initializeUserService);
    on<InitializePlatformService>(_initializePlatformService);
  }

  FutureOr<void> _initializeUserService(event, emit) async {
    // create token entity
    TokenEntity tokenEntity = TokenEntity(
      token: event.token,
    );

    // create user client
    try {
      MiddlewareClient userClient = await tokenEntity.newClient(
        event.authEndpoint,
        event.registryEndpoint,
      );

      // get platform service
      ServiceInstance platformService =
          await userClient.newServiceInstance("PlatformService");

      emit(
        UserServiceState(
          authService: userClient.authService,
          platformService: platformService,
          status: ServiceStatus.success,
        ),
      );
    } catch (e) {
      emit(
        const UserServiceState(
          status: ServiceStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _initializePlatformService(
    InitializePlatformService event,
    Emitter<ServiceState> emit,
  ) async {
    // create service entity
    ServiceEntity serviceEntity = ServiceEntity(
      serviceName: event.serviceName,
      serviceID: event.serviceID,
      password: event.servicePassword,
    );

    // create user client
    try {
      MiddlewareClient platformClient = await serviceEntity.newClient(
        event.authEndpoint,
        event.registryEndpoint,
      );

      // get platform service
      ServiceInstance platformService =
          await platformClient.newServiceInstance("PlatformService");

      emit(
        PlatformServiceState(
          authService: platformClient.authService,
          platformService: platformService,
          status: ServiceStatus.success,
        ),
      );
    } catch (e) {
      emit(
        const PlatformServiceState(
          status: ServiceStatus.error,
        ),
      );
    }
  }
}
