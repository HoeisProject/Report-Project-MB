import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
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
  );
}

class AuthService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  AuthService(this._dioClient, this._tokenManager);

  Future<Either<String, UserModel>> register(
    String username,
    String email,
    String phoneNumber,
    String password,
    String userImagePath,
  ) async {
    try {
      FormData formData = FormData.fromMap({
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

      final token = res.data['token'] as String;
      await _tokenManager.store(token);

      final data = (res.data['data']);
      final user = UserModel.fromMap(data);
      return right(user);
    } on DioException catch (e) {
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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }
}
