import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  late final ProfileService _profileService;

  FutureOr<UserModel?> _getCurrentUser() async {
    final parseUser = await _profileService.currentUser();
    if (parseUser == null) return null;
    return UserModel.fromParseUser(parseUser);
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
}
