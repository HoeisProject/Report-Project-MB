import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'admin_user_service.g.dart';

@Riverpod(keepAlive: true)
AdminUserService adminUserService(AdminUserServiceRef ref) {
  return AdminUserService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
    ref.watch(profileServiceProvider),
  );
}

class AdminUserService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;
  final ProfileService _profileService;

  AdminUserService(this._dioClient, this._tokenManager, this._profileService);

  Future<Either<String, List<UserModel>>> get() async {
    try {
      final String? token = await _tokenManager.read();
      if (token == null) return left('Token not exist');
      final UserModel? currentUser =
          (await _profileService.currentUser()).fold((l) => null, (r) => r);
      if (currentUser == null || currentUser.role!.name != 'admin') {
        return left('Unauthenticated');
      }

      final res = await _dioClient.get(
        EndPoint.user,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => UserModel.fromMap(e)).toList());
    } on DioError catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, UserModel>> updateStatus(
    String userId,
    UserStatus userStatus,
  ) async {
    try {
      final String? token = await _tokenManager.read();
      if (token == null) return left('Token not exist');
      final UserModel? currentUser =
          (await _profileService.currentUser()).fold((l) => null, (r) => r);
      if (currentUser == null || currentUser.role!.name != 'admin') {
        return left('Unauthenticated');
      }

      final res = await _dioClient.put('${EndPoint.user}/$userId/update-status',
          options: _dioClient.tokenOptions(token),
          data: {UserModelEnum.status.value: userStatus.value});

      final data = res.data['data'];
      return right(UserModel.fromMap(data));
    } on DioError catch (e) {
      return left(e.toString());
    }
  }
}
