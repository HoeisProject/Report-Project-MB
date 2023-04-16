import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/employee/services/report_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_controller.g.dart';

@Riverpod(keepAlive: true)
class ReportController extends _$ReportController {
  late final ReportService _reportService;
  late final ProfileService _profileService;

  FutureOr<List<ReportModel>> _getReport() async {
    debugPrint('ReportController - _getReport');
    final parseUser = await _profileService.currentUser();
    if (parseUser == null) return [];
    final res = await _reportService.getReport(parseUser);
    final reports = res.map((e) => ReportModel.fromParseObject(e)).toList();
    return reports;
  }

  @override
  FutureOr<List<ReportModel>> build() {
    debugPrint('ReportController - build');
    _reportService = ref.watch(reportServiceProvider);
    _profileService = ref.watch(profileServiceProvider);
    return _getReport();
  }

  Future<bool> createProject({
    required String title,
    required Position position,
    required String desc,
    required List<Media> listMediaFile,
  }) async {
    debugPrint('ReportController - createProject');
    final parseUser = await _profileService.currentUser();
    if (parseUser == null) return false;
    state = const AsyncValue.loading();
    final res = await _reportService.create(
      title,
      position,
      desc,
      parseUser,
      listMediaFile,
    );
    if (!res.success || res.results == null) {
      return false;
    }
    final report = ReportModel.fromParseObject(res.results![0]);
    state = AsyncValue.data([...state.value!, report]);
    return true;
  }
}
