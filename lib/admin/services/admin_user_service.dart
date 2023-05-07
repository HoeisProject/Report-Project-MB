import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'admin_user_service.g.dart';

@Riverpod(keepAlive: true)
AdminUserService adminUserService(AdminUserServiceRef ref) {
  return AdminUserService();
}

class AdminUserService {
  Future<List<ParseObject>> get() async {
    final queryUser = QueryBuilder<ParseObject>(ParseObject('_User'));
    final res = await queryUser.query();

    if (!res.success || res.result == null) return [];

    return res.results as List<ParseObject>;
  }

  Future<ParseResponse> verify(String id, int value) {
    final verifyUser = ParseObject('_User')
      ..objectId = id
      ..set(UserModelEnum.status.name, value);
    return verifyUser.save();
  }
}
