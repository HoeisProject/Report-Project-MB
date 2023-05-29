import 'dart:io';

import 'package:dio/dio.dart';
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
        data: formData,
        options: _dioClient.tokenOptions(token),
      );
      return '';
    } on DioError catch (e) {
      return e.toString();
    }
  }
}

class ProfileServicess {
  Future<ParseUser?> currentUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  /// Get Current User From Query
  Future<ParseObject?> getCurrentUser(String userId) async {
    final queryUser = QueryBuilder<ParseObject>(ParseObject('_User'))
      ..whereEqualTo(UserModelEnum.id.name, userId);
    final res = await queryUser.query();

    if (!res.success || res.result == null) return null;
    return res.results![0] as ParseObject;
  }

  /// Update properties String, bool and File only. Based on UserModel properties
  Future<ParseResponse> update(
    UserModelEnum userModelEnum,
    dynamic newValue,
  ) async {
    final currentUserId = (await currentUser())!.objectId;
    final parse = ParseObject('_User')..objectId = currentUserId;
    if (newValue is String || newValue is bool) {
      parse.set(userModelEnum.name, newValue);
      if (userModelEnum == UserModelEnum.email) {
        parse.set(UserModelEnum.email.name, newValue);
      }
    } else if (newValue is File) {
      final parseFile = ParseFile(File(newValue.path));
      parse.set(userModelEnum.name, parseFile);
    }
    return parse.save();
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
