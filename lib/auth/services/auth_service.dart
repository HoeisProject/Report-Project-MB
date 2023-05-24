import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/controller/role_controller.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
    ref.watch(roleControllerProvider.notifier),
  );
}

class AuthService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;
  final RoleController _roleController;

  AuthService(this._dioClient, this._tokenManager, this._roleController);

  Future<Either<String, UserModel>> register(
    String username,
    String email,
    String phoneNumber,
    String password,
    String userImagePath,
  ) async {
    try {
      final roleId = _roleController.findIdForRoleEmployee();

      FormData formData = FormData.fromMap({
        UserModelEnum.roleId.value: roleId,
        UserModelEnum.username.value: username,
        UserModelEnum.nickname.value: username,
        UserModelEnum.email.value: email,
        UserModelEnum.phoneNumber.value: phoneNumber,
        UserModelEnum.password.value: password,
        UserModelEnum.status.value: UserStatus.noupload.value,
        UserModelEnum.userImage.value:
            await MultipartFile.fromFile(userImagePath)
      });
      final Response res = await _dioClient.post(
        EndPoint.register,
        data: formData,
      );

      debugPrint('Res : ' + res.toString());
      final token = res.data['token'] as String;
      await _tokenManager.store(token);

      final data = (res.data['data']);
      final user = UserModel.fromMap(data);
      return right(user);
    } on DioError catch (e) {
      debugPrint('Error : ' + e.toString());
      return left(e.toString());
    }
  }

  Future<Either<String, UserModel>> login(String email, String password) async {
    try {
      final Response res = await _dioClient.post(
        EndPoint.login,
        data: {
          UserModelEnum.email.name: email,
          UserModelEnum.password.name: password,
        },
      );
      final token = res.data['token'] as String;
      await _tokenManager.store(token);
      final data = (res.data['data']);
      return right(UserModel.fromMap(data));
    } on DioError catch (e) {
      return left(e.toString());
    }
  }

  Future<String> logout() async {
    try {
      final token = await _tokenManager.read() ?? 'invalid token';
      await _dioClient.post(
        EndPoint.logout,
        options: _dioClient.tokenOptions(token),
      );
      return _tokenManager.delete();
    } on DioError catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }
}

class AuthServicess {
  // Future<ParseResponse> register(
  //   String username,
  //   String email,
  //   String phoneNumber,
  //   String password,
  //   String userImage,
  // ) async {
  //   ParseFile parseUserImage = ParseFile(File(userImage));

  //   await parseUserImage.save();

  //   final newUser = ParseUser.createUser(username, password, email)
  //     ..set(UserModelEnum.roleId.name, ParseObject('_Role')..objectId = roleId)
  //     ..set(UserModelEnum.nickname.name, username)
  //     ..set(UserModelEnum.phoneNumber.name, phoneNumber)
  //     ..set(UserModelEnum.status.name, UserStatus.noupload.value)
  //     ..set(UserModelEnum.userImage.name, parseUserImage);

  //   return newUser.signUp();
  // }

  // Future<ParseResponse> login(String email, String password) async {
  //   final user = ParseUser.createUser(email, password, null);
  //   return user.login();
  // }

  Future<ParseResponse> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    return user.logout();
  }
}
