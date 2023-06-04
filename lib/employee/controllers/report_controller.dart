import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/employee/services/report_media_service.dart';
import 'package:report_project/employee/services/report_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_controller.g.dart';

@riverpod
FutureOr<List<ReportModel>> getReportByProject(
  GetReportByProjectRef ref, {
  required String projectId,
  required bool showOnlyRejected,
}) async {
  if (projectId.isEmpty) return [];
  final reportService = ref.watch(reportServiceProvider);
  final res = await reportService.getByProjectId(
    projectId: projectId,
    project: false,
    user: true,
    reportStatus: true,
    showOnlyRejected: showOnlyRejected,
  );
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
class ReportController extends _$ReportController {
  late final ReportService _reportService;
  late final ReportMediaService _reportMediaService;

  FutureOr<List<ReportModel>> _get() async {
    debugPrint('ReportController - _getReport');
    final res = await _reportService.get(
      project: true,
      reportStatus: true,
      user: false,
    );
    return res.fold((l) => [], (r) => r);
  }

  @override
  FutureOr<List<ReportModel>> build() {
    debugPrint('ReportController - build');
    _reportService = ref.watch(reportServiceProvider);
    _reportMediaService = ref.watch(reportMediaServiceProvider);
    return _get();
  }

  Future<String> create({
    required String projectId,
    required String title,
    required Position position,
    required String description,
    required List<Media> listMediaFile,
  }) async {
    debugPrint('ReportController - createProject');

    final Either<String, ReportModel> res =
        await _reportService.create(projectId, title, position, description);

    return res.fold((l) => l, (r) async {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async => _get());
      final List<Future<String>> collectionCreateFuture =
          listMediaFile.map((imageFile) {
        return _reportMediaService.create(r.id, imageFile.path);
      }).toList();
      final List<String> res = await Future.wait(collectionCreateFuture);

      /// If there is any error, return error message instead
      for (int i = 0; i < res.length; i++) {
        if (res[i].isNotEmpty) return res[i];
      }
      return '';
    });

    /// Check current user
    // final currentUser = await _profileService.currentUser();
    // if (currentUser == null) return false;

    // /// Find id for pending status as FK
    // final reportStatusId = ref
    //     .read(reportStatusControllerProvider.notifier)
    //     .findIdForStatusPending();
    // state = const AsyncValue.loading();
    // final res = await _reportService.create(projectId, currentUser,
    //     reportStatusId, title, description, position, listMediaFile);
    // if (!res.success || res.results == null) {
    //   return false;
    // }
    // final report = ReportModel.fromParseObject(res.results![0]);
    // state = AsyncValue.data([...state.value!, report]);
  }
}
