import 'package:flutter/foundation.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:report_project/employee/services/report_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_media_controller.g.dart';

@riverpod
FutureOr<List<ReportMediaModel>> getReportMedia(
  GetReportMediaRef ref, {
  required String reportId,
}) async {
  debugPrint('FutureOr<List<ReportMediaModel>> - getReportMedia');
  final reportService = ref.watch(reportServiceProvider);
  final res = await reportService.getReportMedia(reportId);
  return res.map((e) => ReportMediaModel.fromParseObject(e)).toList();
}
