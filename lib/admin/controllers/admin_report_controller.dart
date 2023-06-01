import 'package:flutter/material.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_report_controller.g.dart';

@riverpod
FutureOr<List<ReportModel>> getAdminReportByProject(
  GetAdminReportByProjectRef ref, {
  required String projectId,
}) async {
  if (projectId.isEmpty) return [];
  final adminReportService = ref.watch(adminReportServiceProvider);
  final res = await adminReportService.getByProjectId(
    projectId: projectId,
    project: false,
    user: true,
    reportStatus: true,
  );
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
class AdminReportController extends _$AdminReportController {
  late final AdminReportService _adminReportService;
  late final ReportStatusController _reportStatusController;

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
    _reportStatusController =
        ref.watch(reportStatusControllerProvider.notifier);
    return _getReport();
  }

  Future<String> updateReportStatus({
    required String id,
    required String reportStatusId,
  }) async {
    debugPrint('AdminReportController - updateReportStatus');
    state = const AsyncValue.loading();
    // final reportStatus = ref.read(reportStatusControllerProvider);
    final errMsg = await _adminReportService.updateStatus(
      id, '1',
      // reportStatus[status].id,
    );
    state = await AsyncValue.guard(() async {
      return _getReport();
    });
    return errMsg;
  }
}

// TODO Report Rejected
@Riverpod(keepAlive: true)
FutureOr<List<ReportModel>> reportRejectedController(
    ReportRejectedControllerRef ref) async {
  final adminReportService = ref.watch(adminReportServiceProvider);
  final reportStatusController =
      ref.watch(reportStatusControllerProvider.notifier);
  final rejectReportStatusId = reportStatusController.findIdForStatusReject();
  // final res = await adminReportService.getReport(rejectReportStatusId);
  return [];
  // return res
  //     .map((e) => ReportModel.fromParseObject(e))
  //     .toList()
  //     .where((element) => element.reportStatusId == rejectReportStatusId)
  //     .toList();
}
