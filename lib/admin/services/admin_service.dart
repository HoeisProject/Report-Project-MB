import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AdminService {
  Future<List<ParseObject>> getReports() async {
    ParseObject? getPostObject = ParseObject('ProjectReport');
    QueryBuilder<ParseObject> queryPosts =
        QueryBuilder<ParseObject>(getPostObject);
    final ParseResponse response = await queryPosts.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getReportsMedia(String reportObjectId) async {
    ParseObject? getPostObject = ParseObject('ReportMedia');
    QueryBuilder<ParseObject> queryPosts =
        QueryBuilder<ParseObject>(getPostObject)
          ..whereEqualTo('reportId', reportObjectId);
    final ParseResponse response = await queryPosts.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<ParseResponse> updateReportStatus(
      String objectId, int projectStatus) async {
    ParseObject updateReport = ParseObject("ProjectReport")
      ..objectId = objectId
      ..set('projectStatus', projectStatus);

    return updateReport.save();
  }
}
