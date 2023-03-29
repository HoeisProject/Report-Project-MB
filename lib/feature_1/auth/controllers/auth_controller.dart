import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/feature_1/auth/services/auth_service.dart';
import 'package:report_project/feature_1/auth/services/profile_service.dart';

final authControllerProvider = StateNotifierProvider((ref) {
  final authService = ref.watch(authServiceProvider);
  final profileService = ref.watch(profileServiceProvider);
  return AuthController(
    authService: authService,
    profileService: profileService,
  );
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthService authService;
  final ProfileService profileService;

  AuthController({
    required this.authService,
    required this.profileService,
  }) : super(null);

  Future<bool> registerUser({
    required String imagePath,
    required String username,
    required String password,
    required String email,
    required String nik,
  }) async {
    debugPrint('auth - controller - register user');
    final res =
        await authService.register(imagePath, username, password, email, nik);

    if (!res.success) return false;
    return true;
  }

  Future<UserModel?> loginUser({
    required String username,
    required String password,
  }) async {
    debugPrint('auth - controller - login user');
    final res = await authService.login(username, password);

    if (!res.success) {
      debugPrint(res.error!.message);
      return null;
    }

    final parseUser = await profileService.getCurrentUser();

    if (parseUser == null) return null;

    final user = UserModel.fromParseUser(parseUser);
    state = user;

    return user;
  }

  Future<bool> logout() async {
    debugPrint('auth - controller - logout user');
    final res = await authService.logout();
    if (!res.success) return false;
    return true;
  }
}
