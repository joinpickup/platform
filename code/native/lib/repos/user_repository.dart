import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:local/repos/data/mocks/user.dart';
import 'package:local/repos/data/models/user/user.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:local/util/middleware/middleware.dart';

class UserRepository {
  const UserRepository(
    this.platformAuthService,
    this.userAuthService,
  );

  // Create storage
  final storage = const FlutterSecureStorage();
  final ServiceInstance platformAuthService;
  final ServiceInstance? userAuthService;

  Future<String> register({
    required String email,
    required String password,
  }) async {
    if (email == "acohen@joinpickup.com") {
      return email;
    } else {
      return Future.error("Could not register");
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    // get auth service
    try {
      Response loginRes = await platformAuthService.newRequest(
        "POST",
        "/v1/token/basic",
        {
          "email": email,
          "password": password,
        },
      );

      if (loginRes.statusCode == 200) {
        AuthResponse tokenRes = AuthResponse.fromJson(loginRes.body);
        return tokenRes.token;
      } else {
        return Future.error(loginRes.body);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<User> getUserFromEmail({
    required String email,
  }) async {
    final user = allUsers.firstWhereOrNull(
      (user) => user.email == email,
    );
    if (user == null) {
      return Future.error("No user exists with that email.");
    } else {
      return user;
    }
  }

  Future<User> getUserFromToken({
    required String token,
  }) async {
    final user = allUsers.firstWhereOrNull(
      (user) => user.email == token,
    );
    if (user == null) {
      return Future.error("Could not get user.");
    } else {
      return user;
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "token");
    return;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: "token", value: "token");
    return;
  }

  Future<bool> hasToken() async {
    String? token = await storage.read(key: "token");
    return token != null;
  }

  Future<String?> getToken() async {
    String? token = await storage.read(key: "token");
    return token;
  }
}
