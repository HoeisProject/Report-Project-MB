// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/services/auth_service.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
AuthController authController(AuthControllerRef ref) {
  final authService = ref.watch(authServiceProvider);
  final profileController = ref.watch(profileControllerProvider.notifier);
  return AuthController(authService, profileController);
}

class AuthController {
  final AuthService _authService;
  final ProfileController _profileController;

  AuthController(this._authService, this._profileController);

  Future<String> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String userImagePath,
  }) async {
    final Either<String, UserModel> res = await _authService.register(
        username, email, phoneNumber, password, userImagePath);

    return res.fold((l) => l, (r) async {
      await _profileController.refreshUser();
      return ''; // It means no error
    });
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final Either<String, UserModel> res =
        await _authService.login(email, password);

    return res.fold((l) => l, (r) async {
      await _profileController.refreshUser();
      return '';
    });
  }

  Future<String> logout() async {
    final res = await _authService.logout();
    await _profileController.refreshUser();
    return res;
  }
}
