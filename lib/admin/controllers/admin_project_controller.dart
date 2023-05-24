import 'package:flutter/foundation.dart';
import 'package:report_project/admin/services/admin_project_service.dart';
import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'admin_project_controller.g.dart';

@Riverpod(keepAlive: true)
class AdminProjectController extends _$AdminProjectController {
  late final AdminProjectService _adminProjectService;
  late final ProfileService _profileService;

  FutureOr<List<ProjectModel>> _getProject() async {
    debugPrint('AdminProjectController - _getProject');
    final res = await _adminProjectService.get();
    return res.map((e) => ProjectModel.fromParseObject(e)).toList();
  }

  @override
  FutureOr<List<ProjectModel>> build() {
    debugPrint('AdminProjectController - build');
    _adminProjectService = ref.watch(adminProjectServiceProvider);
    _profileService = ref.watch(profileServiceProvider);
    return _getProject();
  }

  /// TODO
  Future<bool> createProject({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    debugPrint('AdminProjectController - createProject');
    debugPrint(
        "$name $description ${startDate.toString()} ${endDate.toString()}");
    final parseuser = await _profileService.currentUser();
    // if (parseuser == null) return false;
    // state = const AsyncValue.loading();
    // final res = await _adminProjectService.create(
    //     parseuser, name, description, startDate, endDate);
    // if (!res.success || res.results == null) return false;
    // final project = ProjectModel.fromParseObject(res.results![0]);
    // state = AsyncValue.data([...state.value!, project]);
    return true;
  }
}
