import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/project_report_model.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:report_project/feature_1/auth/services/profile_service.dart';
import 'package:report_project/feature_1/employee/services/report_service.dart';

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
  return ref
      .watch(projectReportControllerProvider.notifier)
      .getProjectReports();
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

  Future<void> createProject({
    required String projectTitle,
    required DateTime projectDateTime,
    required Position projectPosition,
    required String projectDesc,
    required List<Media> listMediaFile,
  }) async {
    final user = await profileService.getCurrentUser();
    if (user == null) return;
    return reportService.create(
      projectTitle,
      projectDateTime,
      projectPosition,
      projectDesc,
      user,
      listMediaFile,
    );
  }

  Future<List<ProjectReportModel>> getProjectReports() async {
    final user = await profileService.getCurrentUser();
    if (user == null) return [];

    final res = await reportService.getReports(user);
    final projectReports =
        res.map((e) => ProjectReportModel.fromParseObject(e)).toList();
    state = projectReports;

    return projectReports;
  }
}
