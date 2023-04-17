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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'token': token});

    return result;
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));
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

class ServiceEntity implements Entity {
  String serviceName;
  int serviceID;
  String password;

  ServiceEntity({
    required this.serviceName,
    required this.serviceID,
    required this.password,
  });

  @override
  Future<MiddlewareClient> newClient(
    String authEndpoint,
    String registryEndpoint,
  ) async {
    ServiceInstance registry = ServiceInstance(
      base: registryEndpoint,
      token: null,
    );

    ServiceInstance authService = ServiceInstance(
      base: authEndpoint,
      token: null,
    );

    final resp = await authService.newRequest('POST', '/v1/token/service', {
      "id": 1,
      "name": serviceName,
      "password": password,
    });

    if (resp.statusCode != 200) {
      throw Exception(
          'error calling authService to get token, status code: ${resp.statusCode}');
    }

    AuthResponse authResponse = AuthResponse.fromJson(resp.body);

    return MiddlewareClient(
      token: authResponse.token,
      authService: authService,
      serviceRegistry: registry,
    );
  }
}

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
