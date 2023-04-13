import 'package:flutter/material.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
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
    required String id,
    required int status,
  }) async {
    state = const AsyncValue.loading();
    final res = await _adminReportService.updateReportStatus(
      id,
      status,
    );
    if (!res.success || res.results == null) {
      return false;
    }
    final reportStatus = ref.read(reportStatusControllerProvider);
    final projectReportList = state.value!.map((e) {
      if (e.id != id) return e;
      return e.copyWith(reportStatusId: reportStatus[status].id);
    }).toList();
    state = AsyncValue.data(projectReportList);
    for (int i = 0; i < projectReportList.length; i++) {
      debugPrint(projectReportList[i].toString());
    }
    return true;
  }
}
