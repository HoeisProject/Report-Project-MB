import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_service.g.dart';

@Riverpod(keepAlive: true)
ReportService reportService(ReportServiceRef ref) {
  return ReportService(ref: ref);
}

class ReportService {
  final ProviderRef ref;
  ReportService({required this.ref});

  Future<ParseResponse> create(
    String projectId,
    ParseUser currentUser, // userId
    String reportStatusId,
    String title,
    String description,
    Position position,
    List<Media> listMediaFile,
  ) async {
    final newReport = ParseObject('Report')
      ..set(
        ReportEnum.projectId.name,
        ParseObject('Project')..objectId = projectId,
      )
      ..set(ReportEnum.userId.name, currentUser)
      ..set(
        ReportEnum.reportStatusId.name,
        ParseObject('ReportStatus')..objectId = reportStatusId,
      )
      ..set(ReportEnum.title.name, title)
      ..set(ReportEnum.description.name, description)
      ..set(
        ReportEnum.position.name,
        ParseGeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );

    final report = await newReport.save();
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
    return report;
  }

  Future<List<ParseObject>> getReport(ParseUser currentUser) async {
    ParseObject? getPostObject = ParseObject('Report');
    final queryPosts = QueryBuilder<ParseObject>(getPostObject)
      ..whereEqualTo(ReportEnum.userId.name, currentUser);
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
    ParseObject updateReport = ParseObject("Report")
      ..objectId = objectId
      ..set(ReportEnum.title.name, projectTitle)
      ..set(ReportEnum.description.name, projectDesc);

    return updateReport.save();
  }

  Future<ParseResponse> deletePost(String objectId) async {
    ParseObject deleteReport = ParseObject("Report")..objectId = objectId;
    return deleteReport.delete();
  }
}
