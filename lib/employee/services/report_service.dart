import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_service.g.dart';

@Riverpod(keepAlive: true)
ReportService reportService(ReportServiceRef ref) {
  // return ReportService();
  return ReportService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
    ref.watch(profileControllerProvider.notifier),
  );
}

class ReportService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;
  final ProfileController _profileController;

  ReportService(this._dioClient, this._tokenManager, this._profileController);

  Future<Either<String, List<ReportModel>>> get({
    required bool project,
    required bool user,
    required bool reportStatus,
  }) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    final UserModel? currentUser = await _profileController.currentUser();
    if (currentUser == null) return left('Unauthenticated');
    final Map<String, dynamic> dataMap = {};
    if (project) dataMap['project'] = project;
    if (user) dataMap['user'] = user;
    if (reportStatus) dataMap['reportStatus'] = reportStatus;

    try {
      final res = await _dioClient.get(
        '${EndPoint.report}/${currentUser.id}/user',
        options: _dioClient.tokenOptions(token),
        queryParameters: dataMap,
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ReportModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ReportModel>> create(
    String projectId,
    String title,
    Position position,
    String description,
  ) async {
    try {
      final String? token = await _tokenManager.read();
      if (token == null) return left('Token not exist');
      final UserModel? currentUser = await _profileController.currentUser();
      if (currentUser == null) return left('Unauthenticated');

      final positionLatLong = '${position.latitude}#${position.longitude}';
      final res = await _dioClient.post(EndPoint.report,
          options: _dioClient.tokenOptions(token),
          data: {
            ReportModelEnum.projectId.value: projectId,
            ReportModelEnum.userId.value: currentUser.id,
            ReportModelEnum.title.value: title,
            ReportModelEnum.description.value: description,
            ReportModelEnum.position.value: positionLatLong,
          });
      final data = res.data['data'];
      return right(ReportModel.fromMap(data));
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  /// Get report by project
  Future<Either<String, List<ReportModel>>> getByProjectId({
    required String projectId,
    required bool project,
    required bool user,
    required bool reportStatus,
    required bool showOnlyRejected,
  }) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    final Map<String, dynamic> dataMap = {};
    if (project) dataMap['project'] = true;
    if (user) dataMap['user'] = true;
    if (reportStatus) dataMap['reportStatus'] = true;
    if (showOnlyRejected) dataMap['showOnlyRejected'] = true;

    try {
      final res = await _dioClient.get(
        '${EndPoint.project}/$projectId/${EndPoint.report}',
        options: _dioClient.tokenOptions(token),
        queryParameters: dataMap,
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ReportModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }
}

class ReportServices {
  ReportServices();

  Future<ParseResponse> create(
    String projectId,
    ParseUser currentUser, // userId
    String reportStatusId,
    String title,
    String description,
    Position position,
    List<Media> listMediaFile,
  ) async {
    debugPrint('ReportService - create');
    final newReport = ParseObject('Report')
      ..set(
        ReportModelEnum.projectId.name,
        ParseObject('Project')..objectId = projectId,
      )
      ..set(ReportModelEnum.userId.name, currentUser)
      ..set(
        ReportModelEnum.reportStatusId.name,
        ParseObject('ReportStatus')..objectId = reportStatusId,
      )
      ..set(ReportModelEnum.title.name, title)
      ..set(ReportModelEnum.description.name, description)
      ..set(
        ReportModelEnum.position.name,
        ParseGeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    debugPrint(newReport.toJson().toString());
    final report = await newReport.save();
    debugPrint(report.toString());
    debugPrint(report.results.toString());
    if (!report.success || report.result == null) return report;

    int i = 0;
    for (var media in listMediaFile) {
      ParseFile parseReportMedia = ParseFile(File(media.path));

      final newReportMedia = ParseObject('ReportMedia');
      newReportMedia.set(
          ReportMediaModelEnum.reportId.name, newReport.objectId);
      newReportMedia.set(
          ReportMediaModelEnum.attachment.name, parseReportMedia);

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
      ..whereEqualTo(ReportModelEnum.userId.name, currentUser)
      ..includeObject(["userId"]);
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
          ..whereEqualTo(ReportMediaModelEnum.reportId.name, reportId);
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
      ..set(ReportModelEnum.title.name, projectTitle)
      ..set(ReportModelEnum.description.name, projectDesc);

    return updateReport.save();
  }

  Future<ParseResponse> deletePost(String objectId) async {
    ParseObject deleteReport = ParseObject("Report")..objectId = objectId;
    return deleteReport.delete();
  }
}
