import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProfileService {
  Future<dynamic> getCurrentUser() async {
    return await ParseUser.currentUser();
  }
}
