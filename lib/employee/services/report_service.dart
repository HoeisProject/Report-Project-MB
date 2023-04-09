import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/report_media_model.dart';

final reportServiceProvider = Provider((ref) {
  return ReportService();
});

class ReportService {
  Future<ParseResponse> create(
    String title,
    DateTime dateTime,
    Position position,
    String desc,
    ParseUser currentUser,
    List<Media> listMediaFile,
  ) async {
    final newReport = ParseObject('ProjectReport')
      ..set(ReportEnum.projectTitle.name, title)
      ..set(ReportEnum.projectDateTime.name, dateTime)
      ..set(
          ReportEnum.projectPosition.name,
          ParseGeoPoint(
            latitude: position.latitude,
            longitude: position.longitude,
          ))
      ..set(ReportEnum.projectDesc.name, desc)
      ..set(ReportEnum.uploadBy.name, currentUser)
      ..set(ReportEnum.projectStatus.name, 0);

    final projectReport = await newReport.save();
    int i = 0;
    for (var media in listMediaFile) {
      ParseFile parseReportMedia = ParseFile(File(media.path));

      final newReportMedia = ParseObject('ReportMedia');
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

  Future<List<ParseObject>> getReport(ParseUser currentUser) async {
    ParseObject? getPostObject = ParseObject('ProjectReport');
    final queryPosts = QueryBuilder<ParseObject>(getPostObject)
      ..whereEqualTo(ReportEnum.uploadBy.name, currentUser);
    final ParseResponse response = await queryPosts.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getReportMedia(String reportId) async {
    ParseObject? getPostObject = ParseObject('ReportMedia');
    QueryBuilder<ParseObject> queryPosts =
        QueryBuilder<ParseObject>(getPostObject)
          ..whereEqualTo(ReportMediaEnum.reportId.name, reportId);
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
      ..set(ReportEnum.projectTitle.name, projectTitle)
      ..set(ReportEnum.projectDesc.name, projectDesc);

    return updateReport.save();
  }

  Future<ParseResponse> deletePost(String objectId) async {
    ParseObject deleteReport = ParseObject("ProjectReport")
      ..objectId = objectId;
    return deleteReport.delete();
  }
}
