import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/auth/controllers/auth_controller.dart';
import 'package:report_project/common/models/user_model.dart';

final employeeControllerProvider = Provider((ref) {
  final userModel = ref.watch(authControllerProvider);
  return EmployeeController(
    employee: userModel,
  );
});

class EmployeeController {
  final UserModel? employee;

  EmployeeController({
    required this.employee,
  });

  UserModel? getCurrentEmployee() {
    return employee;
  }
}
