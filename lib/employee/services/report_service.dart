import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

final reportServiceProvider = Provider((ref) {
  return ReportService();
});

class ReportService {
  Future<void> create(
    String projectTitle,
    DateTime projectDateTime,
    Position projectPosition,
    String projectDesc,
    ParseUser currentUser,
    List<Media> listMediaFile,
  ) async {
    ParseObject newReport = ParseObject("ProjectReport")
      ..set('projectTitle', projectTitle)
      ..set('projectDateTime', projectDateTime)
      ..set(
          'projectPosition',
          ParseGeoPoint(
            latitude: projectPosition.latitude,
            longitude: projectPosition.longitude,
          ))
      ..set('projectDesc', projectDesc)
      ..set('uploadBy', currentUser)
      ..set('projectStatus', 0);

    await newReport.save();

    for (var media in listMediaFile) {
      ParseFile parseReportMedia = ParseFile(File(media.path));

      ParseObject newReportMedia = ParseObject("ReportMedia");
      newReportMedia.set('reportId', newReport.objectId);
      newReportMedia.set('reportAttachment', parseReportMedia);

      ParseResponse response = await newReportMedia.save();
      if (response.success) {
      } else {
        break;
      }
    }
  }

  Future<List<ParseObject>> getReports(ParseUser currentUser) async {
    ParseObject? getPostObject = ParseObject('ProjectReport');
    QueryBuilder<ParseObject> queryPosts =
        QueryBuilder<ParseObject>(getPostObject)
          ..whereEqualTo('uploadBy', currentUser);
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
