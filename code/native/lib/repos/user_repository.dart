import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:local/repos/data/models/user/person.dart';

class UserRepository {
  const UserRepository();

  // Create storage
  final storage = const FlutterSecureStorage();

  Future<String> authenticate({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return "token";
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
}
