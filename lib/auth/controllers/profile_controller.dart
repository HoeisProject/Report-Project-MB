import 'dart:io';

import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  late final ProfileService _profileService;

  FutureOr<UserModel?> _getCurrentUser() async {
    final parseUser = await _profileService.currentUser();
    if (parseUser == null || parseUser.objectId == null) return null;

    final currentUser =
        await _profileService.getCurrentUser(parseUser.objectId!);
    if (currentUser == null) return null;
    return UserModel.fromParseObject(currentUser);
  }

  @override
  FutureOr<UserModel?> build() async {
    _profileService = ref.watch(profileServiceProvider);
    return _getCurrentUser();
  }

  Future<void> refreshUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getCurrentUser();
    });
  }

  /// Update properties String, bool and File only. Based on UserModel properties
  Future<bool> updateByProperties({
    required UserModelEnum userModelEnum,
    required dynamic newValue,
  }) async {
    final res = await _profileService.update(userModelEnum, newValue);
    if (!res.success) return false;
    await refreshUser();
    return true;
  }

  Future<bool> verifyUser({
    required String nik,
    required File ktp,
  }) async {
    final res = await _profileService.verifyUser(nik, ktp);
    if (!res.success) return false;
    await refreshUser();
    return true;
  }
}
