import 'package:flutter/foundation.dart';
import 'package:report_project/admin/services/admin_report_service.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_report_media_controller.g.dart';

@riverpod
FutureOr<List<ReportMediaModel>> getAdminReportMedia(
  // getAdminReportMediaByReport - change function name TODO
  GetAdminReportMediaRef ref, {
  required String reportId,
}) async {
  debugPrint('FutureOr<List<ReportMediaModel>> - getAdminReportMedia');
  final reportService = ref.watch(adminReportServiceProvider);
  final res = await reportService.getReportMedia(reportId);
  return res.fold((l) => [], (r) => r);
}
