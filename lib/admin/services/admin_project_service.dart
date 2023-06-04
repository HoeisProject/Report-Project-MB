import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_project_service.g.dart';

@Riverpod(keepAlive: true)
AdminProjectService adminProjectService(AdminProjectServiceRef ref) {
  return AdminProjectService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
    ref.watch(profileControllerProvider.notifier),
  );
}

class AdminProjectService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;
  final ProfileController _profileController;

  AdminProjectService(
    this._dioClient,
    this._tokenManager,
    this._profileController,
  );

  Future<Either<String, List<ProjectModel>>> get() async {
    try {
      final String? token = await _tokenManager.read();
      if (token == null) return left('Token not exist');
      final res = await _dioClient.get(
        EndPoint.project,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ProjectModel.fromMap(e)).toList());
    } on DioError catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProjectModel>> create(
    String name,
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    final UserModel? currentUser = await _profileController.currentUser();
    if (currentUser == null || currentUser.role!.name != 'admin') {
      return left('Unauthenticated');
    }
    try {
      // debugPrint(DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate));
      final res = await _dioClient.post(EndPoint.project,
          options: _dioClient.tokenOptions(token),
          data: {
            ProjectModelEnum.userId.value: currentUser.id,
            ProjectModelEnum.name.value: name,
            ProjectModelEnum.description.value: description,
            ProjectModelEnum.startDate.value:
                DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate),
            ProjectModelEnum.endDate.value:
                DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate),
          });
      final data = res.data['data'];
      return right(ProjectModel.fromMap(data));
    } on DioError catch (e) {
      return left(e.toString());
    }
  }
}

class AdminProjectServicess {
  Future<List<ParseObject>> get() async {
    final queryProject = QueryBuilder<ParseObject>(ParseObject('Project'));
    final res = await queryProject.query();
    if (!res.success || res.results == null) return [];
    return res.results as List<ParseObject>;
  }

  Future<ParseResponse> create(
    ParseUser currentUser, // userId
    String name,
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final newProject = ParseObject('Project')
      ..set(ProjectModelEnum.userId.name, currentUser)
      ..set(ProjectModelEnum.name.name, name)
      ..set(ProjectModelEnum.description.name, description)
      ..set(ProjectModelEnum.startDate.name, startDate)
      ..set(ProjectModelEnum.endDate.name, endDate);
    return await newProject.save();
  }
}
