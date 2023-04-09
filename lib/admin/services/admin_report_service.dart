import 'package:report_project/common/models/project_report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'admin_report_service.g.dart';

@Riverpod(keepAlive: true)
AdminReportService adminReportService(AdminReportServiceRef ref) {
  return AdminReportService();
}

class AdminReportService {
  Future<List<ParseObject>> getReport() async {
    ParseObject? getPostObject = ParseObject('ProjectReport');
    final queryPosts = QueryBuilder<ParseObject>(getPostObject);
    final ParseResponse response = await queryPosts.query();

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
    int projectStatus,
  ) async {
    ParseObject updateReport = ParseObject("ProjectReport")
      ..objectId = objectId
      ..set(ProjectReportEnum.projectStatus.name, projectStatus);

    return updateReport.save();
  }
}
