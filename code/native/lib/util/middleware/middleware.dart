import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

part 'entity.dart';
part 'registry.dart';

/*
  Create Middleware
*/
class MiddlewareClient {
  String token;
  ServiceInstance serviceRegistry;
  ServiceInstance authService;

  MiddlewareClient({
    required this.token,
    required this.serviceRegistry,
    required this.authService,
  });

  Future<ServiceInstance> newServiceInstance(String name) async {
    var endpoint = '/v1/item/$name';
    var resp = await serviceRegistry.newRequest('GET', endpoint, null);

    if (resp.statusCode != HttpStatus.ok) {
      throw Exception('status from ServiceRegistry: ${resp.statusCode}');
    }

    RegistryItem item = RegistryItem.fromJson(jsonDecode(resp.body));

    return ServiceInstance(
      base: item.endpoint,
      token: token,
    );
  }
}

class ServiceInstance {
  String base;
  String? token;

  ServiceInstance({
    required this.base,
    required this.token,
  });

  Future<http.Response> newRequest<T>(
    String request,
    String endpoint,
    dynamic data,
  ) async {
    var parsedUrl = Uri.parse('$base$endpoint');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };
    var client = http.Client();

    switch (request) {
      case 'GET':
        return await client.get(
          parsedUrl,
          headers: headers,
        );
      case 'POST':
        return await client.post(
          parsedUrl,
          body: jsonEncode(data),
          headers: headers,
        );
      case 'PUT':
        return await client.put(
          parsedUrl,
          body: jsonEncode(data),
          headers: headers,
        );
      case 'DELETE':
        return await client.delete(
          parsedUrl,
          headers: headers,
        );
      default:
        return Future.error("Not a valid method.");
    }
  }

  Future<IOWebSocketChannel> newWebSocketChannel(
    String endpoint,
  ) async {
    String websocketBase =
        base.replaceFirst("https", "wss").replaceFirst("http", "wss");
    var parsedUrl = Uri.parse('$websocketBase$endpoint');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };

    return IOWebSocketChannel.connect(parsedUrl, headers: headers);
  }
}

/*
  Create Client Methods
*/
class BasicAuthRequest {
  String username;
  String email;
  String password;

  BasicAuthRequest({
    required this.username,
    required this.password,
    this.email = "",
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
