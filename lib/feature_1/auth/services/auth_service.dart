import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthService {
  Future<ParseResponse> registerAccount(String imagePath, String username,
      String password, String email, String nik) async {
    ParseFile parseUserImage = ParseFile(File(imagePath));

    await parseUserImage.save();

    ParseUser newUser = ParseUser.createUser(username, password, email);
    newUser.set('userImage', parseUserImage);
    newUser.set('nik', nik);

    return await newUser.signUp();
  }

  Future<ParseResponse> loginAccount(String username, String password) async {
    ParseUser user = ParseUser.createUser(username, password, null);

    return await user.login();
  }

  Future<ParseResponse> logoutAccount() async {
    final user = await ParseUser.currentUser() as ParseUser;
    return await user.logout();
  }
}
