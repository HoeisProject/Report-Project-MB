import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/common/models/report_model.dart';
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
