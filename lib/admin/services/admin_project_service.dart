import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_project_service.g.dart';

@Riverpod(keepAlive: true)
AdminProjectService adminProjectService(AdminProjectServiceRef ref) {
  return AdminProjectService();
}

class AdminProjectService {
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
