import 'package:flutter/material.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/models/project_report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_project_report_controller.g.dart';

@Riverpod(keepAlive: true)
class AdminProjectReportController extends _$AdminProjectReportController {
  late final AdminReportService _adminProjectReportService;

  FutureOr<List<ProjectReportModel>> _getProjectReport() async {
    final res = await _adminProjectReportService.getReport();
    return res.map((e) => ProjectReportModel.fromParseObject(e)).toList();
  }

  @override
  FutureOr<List<ProjectReportModel>> build() {
    _adminProjectReportService = ref.watch(adminReportServiceProvider);
    return _getProjectReport();
  }

  Future<bool> updateReportStatus({
    required String objectId,
    required int projectStatus,
  }) async {
    state = const AsyncValue.loading();
    final res = await _adminProjectReportService.updateReportStatus(
      objectId,
      projectStatus,
    );
    if (!res.success || res.results == null) {
      return false;
    }
    final projectReportList = state.value!.map((e) {
      if (e.objectId != objectId) return e;
      return e.copyWith(projectStatus: projectStatus);
    }).toList();
    state = AsyncValue.data(projectReportList);
    for (int i = 0; i < projectReportList.length; i++) {
      debugPrint(projectReportList[i].toString());
    }
    return true;
  }
}
