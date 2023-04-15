part of 'middleware.dart';

abstract class Entity {
  Future<MiddlewareClient> newClient(
    String authEndpoint,
    String registryEndpoint,
  );
}

class AuthResponse {
  String token;
  AuthResponse({
    required this.token,
  });
}

class TokenEntity implements Entity {
  String token;

  TokenEntity({
    required this.token,
  });

  @override
  Future<MiddlewareClient> newClient(
    String authEndpoint,
    String registryEndpoint,
  ) async {
    ServiceInstance registry = ServiceInstance(
      base: registryEndpoint,
      token: token,
    );

    ServiceInstance authService = ServiceInstance(
      base: authEndpoint,
      token: token,
    );

    return MiddlewareClient(
      token: token,
      authService: authService,
      serviceRegistry: registry,
    );
  }
}

// class ServiceEntity implements Entity {
//   String serviceName;
//   String password;

//   ServiceEntity({
//     required this.serviceName,
//     required this.password,
//   });

//   @override
//   Future<MiddlewareClient> newClient(
//     String authService,
//     String serviceRegistry,
//   ) {
//     throw UnimplementedError();
//   }
// }

// class BasicEntity implements Entity {
//   String username;
//   String email;
//   String password;
//   BasicEntity({
//     required this.username,
//     required this.email,
//     required this.password,
//   });

//   @override
//   Future<MiddlewareClient> newClient(
//     String authService,
//     String serviceRegistry,
//   ) {
//     throw UnimplementedError();
//   }
// }
