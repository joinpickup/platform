import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local/repos/data/mocks/user.dart';
import 'package:local/repos/data/models/user/user.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class UserRepository {
  const UserRepository();

  // Create storage
  final storage = const FlutterSecureStorage();

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
    User user = await getUserFromEmail(email: email);
    if (user.password == password) {
      return user.email;
    } else {
      return Future.error("Invalid email or password.");
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
