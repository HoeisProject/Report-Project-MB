import 'package:flutter/material.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_report_controller.g.dart';

@Riverpod(keepAlive: true)
class AdminReportController extends _$AdminReportController {
  late final AdminReportService _adminReportService;

  FutureOr<List<ReportModel>> _getProjectReport() async {
    final res = await _adminReportService.getReport();
    return res.map((e) => ReportModel.fromParseObject(e)).toList();
  }

  @override
  FutureOr<List<ReportModel>> build() {
    _adminReportService = ref.watch(adminReportServiceProvider);
    return _getProjectReport();
  }

  Future<bool> updateReportStatus({
    required String objectId,
    required int projectStatus,
  }) async {
    state = const AsyncValue.loading();
    final res = await _adminReportService.updateReportStatus(
      objectId,
      projectStatus,
    );
    if (!res.success || res.results == null) {
      return false;
    }
    final projectReportList = state.value!.map((e) {
      if (e.objectId != objectId) return e;
      return e.copyWith(status: projectStatus);
    }).toList();
    state = AsyncValue.data(projectReportList);
    for (int i = 0; i < projectReportList.length; i++) {
      debugPrint(projectReportList[i].toString());
    }
    return true;
  }
}
