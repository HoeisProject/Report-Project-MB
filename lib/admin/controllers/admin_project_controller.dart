import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/admin/services/admin_project_priority_service.dart';
import 'package:report_project/admin/services/admin_project_service.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'admin_project_controller.g.dart';

@Riverpod(keepAlive: true)
class AdminProjectController extends _$AdminProjectController {
  late final AdminProjectService _adminProjectService;
  late final AdminProjectPriorityService _adminProjectPriorityService;

  FutureOr<List<ProjectModel>> _get() async {
    debugPrint('AdminProjectController - _getProject');
    final res = await _adminProjectService.get();
    return res.fold((l) => [], (r) => r);
  }

  @override
  FutureOr<List<ProjectModel>> build() {
    debugPrint('AdminProjectController - build');
    _adminProjectService = ref.watch(adminProjectServiceProvider);
    _adminProjectPriorityService =
        ref.watch(adminProjectPriorityServiceProvider);
    return _get();
  }

  Future<String> createProject({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String timeSpanId,
    required String moneyEstimateId,
    required String manpowerId,
    required String materialFeasibilityId,
  }) async {
    debugPrint('AdminProjectController - createProject');
    final Either<String, ProjectModel> res = await _adminProjectService.create(
        name, description, startDate, endDate);
    return res.fold((l) => l, (r) async {
      state = const AsyncValue.loading();
      final errMsg = await _adminProjectPriorityService.create(
        r.id,
        timeSpanId,
        moneyEstimateId,
        manpowerId,
        materialFeasibilityId,
      );
      state = await AsyncValue.guard(() async => _get());
      return errMsg;
    });
  }
}
