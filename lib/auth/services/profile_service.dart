import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_service.g.dart';

@Riverpod(keepAlive: true)
ProfileService profileService(ProfileServiceRef ref) {
  return ProfileService(
      ref.watch(dioClientProvider), ref.watch(tokenManagerProvider));
}

class ProfileService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  ProfileService(this._dioClient, this._tokenManager);

  Future<Either<String, UserModel>> currentUser() async {
    try {
      final String? token = await _tokenManager.read();
      if (token == null) return left('Token not exist');
      final res = await _dioClient.get(
        EndPoint.currentUser,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'];
      return right(UserModel.fromMap(data));
    } on DioError catch (e) {
      return left(e.toString());
    }
  }

  /// Update properties String, bool and File only. Based on UserModel properties
  /// Username, Email, Phone Number, NIK, Ktp Image
  Future<String> updateByProperties(
    UserModelEnum userModelEnum,
    dynamic newValue,
  ) async {
    final String? token = await _tokenManager.read();
    if (token == null) return 'Token not exist';
    final Map<String, dynamic> dataMap = {};
    if (newValue is File) {
      File image = newValue;
      dataMap[userModelEnum.value] = await MultipartFile.fromFile(image.path);
    } else if (newValue is String || newValue is bool) {
      dataMap[userModelEnum.value] = newValue;
    }
    if (dataMap.isEmpty) return 'Nothing to change';

    try {
      FormData formData = FormData.fromMap(dataMap);
      // debugPrint(formData.fields[0].toString());
      await _dioClient.post(
        EndPoint.userUpdateProperties,
        options: _dioClient.tokenOptions(token),
        data: formData,
      );
      return '';
    } on DioError catch (e) {
      return e.toString();
    }
  }

  Future<String> verify(String nik, String ktpImagePath) async {
    try {
      FormData formData = FormData.fromMap({
        UserModelEnum.nik.value: nik,
        UserModelEnum.ktpImage.value: await MultipartFile.fromFile(ktpImagePath)
      });
      final token = await _tokenManager.read();
      if (token == null) return 'Token not exist';
      await _dioClient.post(
        EndPoint.userVerify,
        options: _dioClient.tokenOptions(token),
        data: formData,
      );
      return '';
    } on DioError catch (e) {
      return e.toString();
    }
  }
}
