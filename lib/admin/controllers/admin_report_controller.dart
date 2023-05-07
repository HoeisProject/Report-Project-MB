import 'package:flutter/material.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_report_controller.g.dart';

@Riverpod(keepAlive: true)
class AdminReportController extends _$AdminReportController {
  late final AdminReportService _adminReportService;
  late final ReportStatusController _reportStatusController;

  FutureOr<List<ReportModel>> _getReport() async {
    debugPrint('AdminReportController - _getReport');
    final rejectReportStatusId =
        _reportStatusController.findIdForStatusReject();
    final res = await _adminReportService.getReport(rejectReportStatusId);
    return res.map((e) => ReportModel.fromParseObject(e)).toList();
  }

  @override
  FutureOr<List<ReportModel>> build() {
    _adminReportService = ref.watch(adminReportServiceProvider);
    _reportStatusController =
        ref.watch(reportStatusControllerProvider.notifier);
    return _getReport();
  }

  Future<bool> updateReportStatus({
    required String id,
    required int status,
  }) async {
    debugPrint('AdminReportController - updateReportStatus');
    state = const AsyncValue.loading();
    final reportStatus = ref.read(reportStatusControllerProvider);
    final res = await _adminReportService.updateReportStatus(
      id,
      reportStatus[status].id,
    );
    if (!res.success || res.results == null) {
      return false;
    }
    state = await AsyncValue.guard(() async {
      return _getReport();
    });
    return true;
  }
}
