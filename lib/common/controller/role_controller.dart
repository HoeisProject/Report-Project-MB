import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/services/role_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'role_controller.g.dart';

@Riverpod(keepAlive: true)
class RoleController extends _$RoleController {
  late final RoleService _roleService;

  Future<List<RoleModel>> _get() async {
    // final roles = (await _roleService.get()).getRight();
    // return roles;
    final res = await _roleService.get();
    return res.fold((l) => [], (r) => r);
    // return res.foldRight([], (acc, b) => b);
  }

  @override
  Future<List<RoleModel>> build() async {
    _roleService = ref.watch(roleServiceProvider);
    return _get();
  }

  RoleModel findById(String id) {
    return state.asData!.value.firstWhere((e) => e.id == id);
  }

  String findIdForRoleEmployee() {
    return state.asData!.value.firstWhere((e) => e.name == 'employee').id;
  }
}
