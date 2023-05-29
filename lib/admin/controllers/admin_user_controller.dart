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
    return res.fold((l) => [], (r) => r);
  }

  @override
  FutureOr<List<UserModel>> build() {
    debugPrint('AdminUserController - build');
    _adminUserService = ref.watch(adminUserServiceProvider);
    return _getUser();
  }

  Future<String> verifyUser({
    required String id,
    required UserStatus userStatus,
  }) async {
    debugPrint('AdminUserController - verifyUser');
    final res = await _adminUserService.updateStatus(id, userStatus);
    return res.fold((l) => l, (r) {
      final userList = state.value!.map((e) {
        if (e.id != id) return e;
        return e.copyWith(status: userStatus.value);
      }).toList();
      state = AsyncValue.data(userList);
      return '';
    });
  }
}
