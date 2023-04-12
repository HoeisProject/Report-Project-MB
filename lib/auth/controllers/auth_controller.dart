// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/services/auth_service.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
AuthController authController(AuthControllerRef ref) {
  final authService = ref.watch(authServiceProvider);
  final profileController = ref.watch(profileControllerProvider.notifier);
  return AuthController(
    authService: authService,
    profileController: profileController,
  );
}

class AuthController {
  final AuthService authService;
  final ProfileController profileController;

  AuthController({
    required this.authService,
    required this.profileController,
  });

  Future<bool> registerUser({
    required String imagePath,
    required String username,
    required String password,
    required String email,
    required String nik,
    required String role,
    required String phoneNumber,
  }) async {
    debugPrint('AuthController - registerUser');
    final res = await authService.register(
        imagePath, username, password, email, nik, role, phoneNumber);

    if (!res.success) return false;
    return true;
  }

  Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    debugPrint('AuthController - loginUser');
    final res = await authService.login(username, password);

    if (!res.success) {
      debugPrint(res.error!.message);
      return false;
    }
    await profileController.refreshUser();
    return true;
  }

  Future<bool> logout() async {
    debugPrint('AuthController - logout');
    final res = await authService.logout();
    if (!res.success) return false;
    await profileController.refreshUser();
    return true;
  }
}

// final authControllerProvider =
//     StateNotifierProvider<AuthController, UserModel?>((ref) {
//   final authService = ref.watch(authServiceProvider);
//   final profileService = ref.watch(profileServiceProvider);
//   return AuthController(
//     authService: authService,
//     profileService: profileService,
//   );
// });

// class AuthController extends StateNotifier<UserModel?> {
//   final AuthService authService;
//   final ProfileService profileService;

//   AuthController({
//     required this.authService,
//     required this.profileService,
//   }) : super(null);

//   Future<bool> registerUser({
//     required String imagePath,
//     required String username,
//     required String password,
//     required String email,
//     required String nik,
//     required String role,
//   }) async {
//     debugPrint('auth - controller - register user');
//     final res = await authService.register(
//         imagePath, username, password, email, nik, role);

//     if (!res.success) return false;
//     return true;
//   }

//   Future<UserModel?> loginUser({
//     required String username,
//     required String password,
//   }) async {
//     debugPrint('auth - controller - login user');
//     final res = await authService.login(username, password);

//     if (!res.success) {
//       debugPrint(res.error!.message);
//       return null;
//     }

//     final parseUser = await profileService.getCurrentUser();

//     if (parseUser == null) return null;

//     final user = UserModel.fromParseUser(parseUser);
//     state = user;

//     return user;
//   }

//   Future<UserModel?> checkCurrentUser() async {
//     final parseUser = await profileService.getCurrentUser();
//     if (parseUser == null) return null;
//     final user = UserModel.fromParseUser(parseUser);
//     state = user;
//     return user;
//   }

//   Future<bool> logout() async {
//     debugPrint('auth - controller - logout user');
//     final res = await authService.logout();
//     if (!res.success) return false;
//     return true;
//   }
// }
