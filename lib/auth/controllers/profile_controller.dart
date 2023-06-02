import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  late final ProfileService _profileService;

  FutureOr<UserModel?> _getCurrentUser() async {
    final res = await _profileService.currentUser();
    return res.fold((l) => null, (r) => r);
  }

  @override
  FutureOr<UserModel?> build() async {
    _profileService = ref.watch(profileServiceProvider);
    return _getCurrentUser();
  }

  FutureOr<UserModel?> currentUser() {
    return state.value;
  }

  Future<void> refreshUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _getCurrentUser());
  }

  /// Update properties String, bool and File only. Based on UserModel properties
  /// Username, Email, Phone Number, NIK, Ktp Image
  Future<String> updateByProperties({
    required UserModelEnum userModelEnum,
    required dynamic newValue,
  }) async {
    final errorMsg = await _profileService.updateByProperties(
      userModelEnum,
      newValue,
    );
    if (errorMsg.isEmpty) await refreshUser();
    return errorMsg;
  }

  Future<String> verifyUser({
    required String nik,
    required String ktpImagePath,
  }) async {
    final errorMsg = await _profileService.verify(nik, ktpImagePath);
    if (errorMsg.isEmpty) await refreshUser();

    return errorMsg;
  }
}
