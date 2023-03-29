import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

final authServiceProvider = Provider((ref) {
  return AuthService();
});

class AuthService {
  Future<ParseResponse> register(
    String imagePath,
    String username,
    String password,
    String email,
    String nik,
  ) async {
    ParseFile parseUserImage = ParseFile(File(imagePath));

    await parseUserImage.save();

    final newUser = ParseUser.createUser(username, password, email)
      ..set('userImage', parseUserImage)
      ..set('nik', nik);

    return newUser.signUp();
  }

  Future<ParseResponse> login(String username, String password) async {
    final user = ParseUser.createUser(username, password, null);
    return user.login();
  }

  Future<ParseResponse> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    return user.logout();
  }
}
