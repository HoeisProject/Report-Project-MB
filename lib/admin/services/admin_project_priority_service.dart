import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/common/models/project_priority/manpower_model.dart';
import 'package:report_project/common/models/project_priority/material_feasibility_model.dart';
import 'package:report_project/common/models/project_priority/money_estimate_model.dart';
import 'package:report_project/common/models/project_priority/project_priority_calculate_model.dart';
import 'package:report_project/common/models/project_priority/project_priority_model.dart';
import 'package:report_project/common/models/project_priority/time_span_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_project_priority_service.g.dart';

@Riverpod(keepAlive: true)
AdminProjectPriorityService adminProjectPriorityService(
    AdminProjectPriorityServiceRef ref) {
  return AdminProjectPriorityService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
  );
}

class AdminProjectPriorityService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  AdminProjectPriorityService(this._dioClient, this._tokenManager);

  Future<Either<String, ProjectPriorityModel>> findByProjectId(
      String projectId) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        '${EndPoint.projectPriority}/$projectId/show',
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'];
      return right(ProjectPriorityModel.fromMap(data));
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<String> create(
    String projectId,
    String timeSpanId,
    String moneyEstimateId,
    String manpowerId,
    String materialFeasibilityId,
  ) async {
    final String? token = await _tokenManager.read();
    if (token == null) return 'Token not exist';
    final FormData formData = FormData.fromMap({
      'project_id': projectId,
      'time_span_id': timeSpanId,
      'money_estimate_id': moneyEstimateId,
      'manpower_id': manpowerId,
      'material_feasibility_id': materialFeasibilityId,
    });
    try {
      _dioClient.post(
        EndPoint.projectPriority,
        data: formData,
      );
      return '';
    } on DioException catch (e) {
      return e.toString();
    }
  }

  Future<Either<String, List<ProjectPriorityCalculateModel>>> calculate(
    String timeSpan,
    String moneyEstimate,
    String manpower,
    String materialFeasibility,
  ) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    final FormData formData = FormData.fromMap({
      ProjectPriorityCalculateModelEnum.timeSpan.value: timeSpan,
      ProjectPriorityCalculateModelEnum.moneyEstimate.value: moneyEstimate,
      ProjectPriorityCalculateModelEnum.manpower.value: manpower,
      ProjectPriorityCalculateModelEnum.materialFeasibility.value:
          materialFeasibility,
    });
    try {
      final res = await _dioClient.post(
        EndPoint.projectPriorityCalculate,
        options: _dioClient.tokenOptions(token),
        data: formData,
      );
      final data = res.data['data'] as List;
      return right(
          data.map((e) => ProjectPriorityCalculateModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<TimeSpanModel>>> getTimeSpan() async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        EndPoint.projectPriorityTimeSpan,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => TimeSpanModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<MoneyEstimateModel>>> getMoneyEstimate() async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        EndPoint.projectPriorityMoneyEstimate,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => MoneyEstimateModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ManpowerModel>>> getManpower() async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        EndPoint.projectPriorityManpower,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ManpowerModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<MaterialFeasibilityModel>>>
      getMaterialFeasibility() async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        EndPoint.projectPriorityMaterialFeasibility,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(
          data.map((e) => MaterialFeasibilityModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }
}
