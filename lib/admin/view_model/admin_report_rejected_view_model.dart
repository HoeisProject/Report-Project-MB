import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/common/models/report_model.dart';

final adminReportRejectedProjectCategorySelectedProvider =
    StateProvider((ref) => "All");

final adminReportRejectedFutureFilteredList =
    FutureProvider<List<ReportModel>>((ref) {
  final filteredReports = ref.watch(adminReportRejectedFilteringReport);
  return Future.value(filteredReports);
});

final adminReportRejectedFilteringReport =
    StateProvider<List<ReportModel>>((ref) {
  final rawReports = ref.watch(reportRejectedControllerProvider).asData?.value;

  final projectCategorySelected =
      ref.watch(adminReportRejectedProjectCategorySelectedProvider);

  List<ReportModel> filteredReports = rawReports ?? [];

  /// TODO Filtrasi
  // if (projectCategorySelected != "All") {
  //   filteredReports = filteredReports
  //       .where((reportModel) => reportModel.projectId
  //           .toLowerCase()
  //           .contains(projectCategorySelected.toLowerCase()))
  //       .toList();
  // }

  return filteredReports;
});
