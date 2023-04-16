import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}

class AuthService {
  Future<ParseResponse> register(
    String roleId,
    String username,
    String email,
    String phoneNumber,
    String password,
    String userImage,
  ) async {
    ParseFile parseUserImage = ParseFile(File(userImage));

    await parseUserImage.save();

    final newUser = ParseUser.createUser(username, password, email)
      ..set(UserModelEnum.roleId.name, ParseObject('_Role')..objectId = roleId)
      ..set(UserModelEnum.nickname.name, username)
      ..set(UserModelEnum.phoneNumber.name, phoneNumber)
      ..set(UserModelEnum.isUserVerified.name, false)
      ..set(UserModelEnum.userImage.name, parseUserImage);

    return newUser.signUp();
  }

  Future<ParseResponse> login(String email, String password) async {
    final user = ParseUser.createUser(email, password, null);
    return user.login();
  }

  Future<ParseResponse> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    return user.logout();
  }
}
