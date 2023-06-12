import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_report_service.g.dart';

@Riverpod(keepAlive: true)
AdminReportService adminReportService(AdminReportServiceRef ref) {
  return AdminReportService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
  );
}

class AdminReportService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  AdminReportService(this._dioClient, this._tokenManager);

  /// Ascending by updated_at properties
  Future<Either<String, List<ReportModel>>> get({
    int page = 1,
    required bool project,
    required bool user,
    required bool reportStatus,
  }) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    final Map<String, dynamic> dataMap = {};
    dataMap['page'] = page;
    if (project) dataMap['project'] = project;
    if (user) dataMap['user'] = user;
    if (reportStatus) dataMap['reportStatus'] = reportStatus;

    try {
      final res = await _dioClient.get(
        EndPoint.report,
        options: _dioClient.tokenOptions(token),
        queryParameters: dataMap,
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ReportModel.fromMap(e)).toList());
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
    // dataMap['page'] = page;
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
      debugPrint(res.data.toString());
      final data = res.data['data'] as List;

      return right(data.map((e) => ReportModel.fromMap(e)).toList());
    } on DioException catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<String> updateStatus(String reportId, String reportStatusId) async {
    final String? token = await _tokenManager.read();
    if (token == null) return 'Token not exist';
    try {
      await _dioClient.put(
        '${EndPoint.report}/$reportId/update-status',
        options: _dioClient.tokenOptions(token),
        data: {'status': reportStatusId},
      );
      return '';
    } on DioException catch (e) {
      return e.toString();
    }
  }

  Future<Either<String, List<ReportMediaModel>>> getReportMedia(
    String reportId,
  ) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        '${EndPoint.report}/$reportId/report-media',
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ReportMediaModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }
}
