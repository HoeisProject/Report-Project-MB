import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/project_report_model.dart';
import 'package:report_project/common/models/report_media_model.dart';

final reportServiceProvider = Provider((ref) {
  return ReportService();
});

class ReportService {
  static const reportProjectClassName = 'ProjectReport';
  static const reportMediaClassName = 'ReportMedia';

  Future<ParseResponse> create(
    String projectTitle,
    DateTime projectDateTime,
    Position projectPosition,
    String projectDesc,
    ParseUser currentUser,
    List<Media> listMediaFile,
  ) async {
    final newReport = ParseObject(reportProjectClassName)
      ..set(ProjectReportEnum.projectTitle.name, projectTitle)
      ..set(ProjectReportEnum.projectDateTime.name, projectDateTime)
      ..set(
          ProjectReportEnum.projectPosition.name,
          ParseGeoPoint(
            latitude: projectPosition.latitude,
            longitude: projectPosition.longitude,
          ))
      ..set(ProjectReportEnum.projectDesc.name, projectDesc)
      ..set(ProjectReportEnum.uploadBy.name, currentUser)
      ..set(ProjectReportEnum.projectStatus.name, 0);

    final projectReport = await newReport.save();
    int i = 0;
    for (var media in listMediaFile) {
      ParseFile parseReportMedia = ParseFile(File(media.path));

      final newReportMedia = ParseObject(reportMediaClassName);
      newReportMedia.set(ReportMediaEnum.reportId.name, newReport.objectId);
      newReportMedia.set(
          ReportMediaEnum.reportAttachment.name, parseReportMedia);

      final response = await newReportMedia.save();
      if (response.success) {
        debugPrint('Done Save ReportMedia ${++i}');
      } else {
        debugPrint(response.error!.message);
        break;
      }
    }
    return projectReport;
  }

  Future<List<ParseObject>> getReports(ParseUser currentUser) async {
    ParseObject? getPostObject = ParseObject(reportProjectClassName);
    final queryPosts = QueryBuilder<ParseObject>(getPostObject)
      ..whereEqualTo(ProjectReportEnum.uploadBy.name, currentUser);
    final ParseResponse response = await queryPosts.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getReportsMedia(String reportObjectId) async {
    ParseObject? getPostObject = ParseObject(reportMediaClassName);
    QueryBuilder<ParseObject> queryPosts =
        QueryBuilder<ParseObject>(getPostObject)
          ..whereEqualTo(ReportMediaEnum.reportId.name, reportObjectId);
    final ParseResponse response = await queryPosts.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<ParseResponse> updateReport(
    String objectId,
    String projectTitle,
    String projectDesc,
  ) async {
    ParseObject updateReport = ParseObject("ProjectReport")
      ..objectId = objectId
      ..set('projectTitle', projectTitle)
      ..set('projectDesc', projectDesc);

    return updateReport.save();
  }

  Future<ParseResponse> deletePost(String objectId) async {
    ParseObject deleteReport = ParseObject("ProjectReport")
      ..objectId = objectId;
    return deleteReport.delete();
  }
}
