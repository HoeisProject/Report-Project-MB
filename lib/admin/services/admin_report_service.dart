import 'package:flutter/foundation.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'admin_report_service.g.dart';

@Riverpod(keepAlive: true)
AdminReportService adminReportService(AdminReportServiceRef ref) {
  return AdminReportService();
}

class AdminReportService {
  Future<List<ParseObject>> getReport(
    String rejectReportStatusId,
    bool showRejectedReportOnly,
  ) async {
    final getPostObject = ParseObject('Report');
    final queryPosts = QueryBuilder<ParseObject>(getPostObject)
      ..includeObject(["userId"]);
    if (showRejectedReportOnly == false) {
      queryPosts.whereNotEqualTo(
        ReportModelEnum.reportStatusId.name,
        rejectReportStatusId,
      );
    } else {
      queryPosts.whereEqualTo(
        ReportModelEnum.reportStatusId.name,
        rejectReportStatusId,
      );
    }

    final ParseResponse response = await queryPosts.query();
    debugPrint(response.results.toString());
    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    }
    return [];
  }

  Future<List<ParseObject>> getReportMedia(String reportId) async {
    ParseObject? getPostObject = ParseObject('ReportMedia');
    final queryPosts = QueryBuilder<ParseObject>(getPostObject)
      ..whereEqualTo('reportId', reportId);
    final ParseResponse response = await queryPosts.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    }
    return [];
  }

  Future<ParseResponse> updateReportStatus(
    String objectId,
    String projectStatus,
  ) async {
    ParseObject updateReport = ParseObject("Report")
      ..objectId = objectId
      ..set(ReportModelEnum.reportStatusId.name,
          (ParseObject('ReportStatus')..objectId = projectStatus).toPointer());

    return updateReport.save();
  }
}
