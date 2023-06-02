import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/common/models/report_model.dart';

final adminHomeSearchTextProvider = StateProvider((ref) => '');

final adminHomeStatusSelectedProvider = StateProvider((ref) => 0);

final adminHomeStatusSelectedLabelProvider = StateProvider((ref) => "All");

final adminHomeProjectCategorySelectedProvider = StateProvider((ref) => "All");

final adminHomeFutureFilteredList = FutureProvider<List<ReportModel>>((ref) {
  final filteredReports = ref.watch(adminHomeFilteringReport);
  return Future.value(filteredReports);
});

final adminHomeFilteringReport = StateProvider<List<ReportModel>>((ref) {
  final rawReports = ref.watch(adminReportControllerProvider).asData?.value;
  // final searchText = ref.watch(adminHomeSearchTextProvider);

  // final statusSelectedItem = ref.watch(adminHomeStatusSelectedProvider);
  // final reportStatus = ref.read(reportStatusControllerProvider);

  // final projectCategorySelected =
  //     ref.watch(adminHomeProjectCategorySelectedProvider);

  List<ReportModel> filteredReports = rawReports ?? [];

  /// TODO Filtrasi

  // if (statusSelectedItem != 0) {
  //   filteredReports = filteredReports
  //       .where((reportModel) =>
  //           reportModel.reportStatusId ==
  //           reportStatus[(statusSelectedItem - 1)].id)
  //       .toList();
  // }

  // if (projectCategorySelected != "All") {
  //   filteredReports = filteredReports
  //       .where((reportModel) => reportModel.projectId
  //           .toLowerCase()
  //           .contains(projectCategorySelected.toLowerCase()))
  //       .toList();
  // }

  // if (searchText != '') {
  //   filteredReports = filteredReports
  //       .where((reportModel) =>
  //           reportModel.title.toLowerCase().contains(searchText.toLowerCase()))
  //       .toList();
  // }

  return filteredReports;
});
