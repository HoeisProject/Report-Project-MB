import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

final profileServiceProvider = Provider((ref) {
  return ProfileService();
});

class ProfileService {
  Future<ParseUser?> getCurrentUser() async {
    final user = await ParseUser.currentUser();
    return await ParseUser.currentUser() as ParseUser?;
  }
}
