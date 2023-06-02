import 'package:flutter/material.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_report_controller.g.dart';

@riverpod
FutureOr<List<ReportModel>> getAdminReportByProject(
  GetAdminReportByProjectRef ref, {
  required String projectId,
  required bool showOnlyRejected,
}) async {
  if (projectId.isEmpty) return [];
  final adminReportService = ref.watch(adminReportServiceProvider);
  final res = await adminReportService.getByProjectId(
    projectId: projectId,
    project: false,
    user: true,
    reportStatus: true,
    showOnlyRejected: showOnlyRejected,
  );
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
class AdminReportController extends _$AdminReportController {
  late final AdminReportService _adminReportService;

  FutureOr<List<ReportModel>> _getReport() async {
    debugPrint('AdminReportController - _getReport');
    final res = await _adminReportService.get(
      project: true,
      user: true,
      reportStatus: true,
    );
    return res.fold((l) => [], (r) => r);
  }

  @override
  FutureOr<List<ReportModel>> build() {
    _adminReportService = ref.watch(adminReportServiceProvider);
    return _getReport();
  }

  Future<String> updateReportStatus({
    required String id,
    required String reportStatusId,
  }) async {
    debugPrint('AdminReportController - updateReportStatus');
    state = const AsyncValue.loading();
    final errMsg = await _adminReportService.updateStatus(
      id,
      reportStatusId,
    );
    state = await AsyncValue.guard(() async {
      return _getReport();
    });
    return errMsg;
  }
}
