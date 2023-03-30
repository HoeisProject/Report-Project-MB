import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/common/models/project_report_model.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/employee/services/report_service.dart';

final projectReportControllerProvider =
    StateNotifierProvider<ProjectReportController, List<ProjectReportModel>>(
        (ref) {
  final reportService = ref.watch(reportServiceProvider);
  final profileService = ref.watch(profileServiceProvider);
  return ProjectReportController(
    reportService: reportService,
    profileService: profileService,
  );
});

final getProjectReportsProvider =
    FutureProvider<List<ProjectReportModel>>((ref) {
  return ref.watch(projectReportControllerProvider);
});

final getReportsMediaProvider =
    FutureProvider.autoDispose.family((ref, String reportObjectId) async {
  final reportService = ref.watch(reportServiceProvider);
  final res = await reportService.getReportsMedia(reportObjectId);
  final reportsMedia =
      res.map((e) => ReportMediaModel.fromParseObject(e)).toList();
  return reportsMedia;
});

class ProjectReportController extends StateNotifier<List<ProjectReportModel>> {
  final ReportService reportService;
  final ProfileService profileService;

  ProjectReportController({
    required this.reportService,
    required this.profileService,
  }) : super([]);

  Future<bool> createProject({
    required String projectTitle,
    required DateTime projectDateTime,
    required Position projectPosition,
    required String projectDesc,
    required List<Media> listMediaFile,
  }) async {
    debugPrint('project report - controller - createProject');
    final user = await profileService.getCurrentUser();
    if (user == null) return false;
    final res = await reportService.create(
      projectTitle,
      projectDateTime,
      projectPosition,
      projectDesc,
      user,
      listMediaFile,
    );
    if (!res.success || res.results == null) {
      return false;
    }

    final projectReport = ProjectReportModel.fromParseObject(res.results![0]);
    state = [...state, projectReport];
    return true;
  }

  Future<List<ProjectReportModel>> getProjectReports() async {
    debugPrint('project report - controller - getProjectReports');
    final user = await profileService.getCurrentUser();
    if (user == null) return [];

    final res = await reportService.getReports(user);
    final projectReports =
        res.map((e) => ProjectReportModel.fromParseObject(e)).toList();
    state = projectReports;

    return projectReports;
  }
}
