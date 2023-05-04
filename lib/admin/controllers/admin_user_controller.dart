import 'package:flutter/foundation.dart';
import 'package:report_project/admin/services/admin_user_service.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_user_controller.g.dart';

@Riverpod(keepAlive: true)
class AdminUserController extends _$AdminUserController {
  late final AdminUserService _adminUserService;

  FutureOr<List<UserModel>> _getUser() async {
    debugPrint('AdminUserController - _getUser');
    final res = await _adminUserService.get();

    return res.map((e) => UserModel.fromParseObject(e)).toList();
  }

  @override
  FutureOr<List<UserModel>> build() {
    debugPrint('AdminUserController - build');
    _adminUserService = ref.watch(adminUserServiceProvider);
    return _getUser();
  }

  Future<bool> verifyUser({
    required String id,
    required bool value,
  }) async {
    debugPrint('AdminUserController - verifyUser');
    final res = await _adminUserService.verify(id, value);
    if (!res.success || res.results == null) {
      return false;
    }
    final userList = state.value!.map((e) {
      if (e.id != id) return e;
      return e.copyWith(isUserVerified: value);
    }).toList();
    state = AsyncValue.data(userList);
    return true;
  }
}
