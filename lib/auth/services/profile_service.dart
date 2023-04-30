import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_service.g.dart';

@Riverpod(keepAlive: true)
ProfileService profileService(ProfileServiceRef ref) {
  return ProfileService();
}

class ProfileService {
  Future<ParseUser?> currentUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  /// Get Current User From Query
  Future<ParseObject?> getCurrentUser(String userId) async {
    final queryUser = QueryBuilder<ParseObject>(ParseObject('_User'))
      ..whereEqualTo(UserModelEnum.objectId.name, userId);
    final res = await queryUser.query();

    if (!res.success || res.result == null) return null;
    return res.results![0] as ParseObject;
  }

  Future<ParseResponse> verifyUser(
    String nik,
    File ktp,
  ) async {
    final ktpImageFile = ParseFile(File(ktp.path));
    final currentUserId = (await currentUser())!.objectId!;

    final res = ParseObject('_User')
      ..objectId = currentUserId
      ..set(UserModelEnum.nik.name, nik)
      ..set(UserModelEnum.ktpImage.name, ktpImageFile);
    return res.save();
  }
}
