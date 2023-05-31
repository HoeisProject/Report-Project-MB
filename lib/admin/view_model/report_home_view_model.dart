import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_home_view_model.g.dart';

final reportHomeProjectCategorySelectedProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

@riverpod
FutureOr<List<ReportModel>> reportHomeReportsByProject(
    ReportHomeReportsByProjectRef ref, String projectId) {
  return [];
}
