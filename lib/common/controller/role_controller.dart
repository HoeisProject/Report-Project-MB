import 'package:report_project/common/models/role_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'role_controller.g.dart';

@Riverpod(keepAlive: true)
class RoleController extends _$RoleController {
  @override
  List<RoleModel> build() {
    return const [
      RoleModel(
          id: 'ELLCD8h3hf',
          name: 'admin',
          description: 'Admin - Stackholder and Developer'),
      RoleModel(
        id: 'im3ET8czLq',
        name: 'employee',
        description: 'Regular Employee',
      ),
    ];
  }

  RoleModel findById(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  String findIdForRoleEmployee() {
    return state.firstWhere((element) => element.name == 'employee').id;
  }
}
