import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/employee/controllers/report_controller.dart';

final employeeHomeProjectCategorySelected = StateProvider((ref) => '');

final employeeHomeShowOnlyRejectedSwitch = StateProvider((ref) => false);

final employeeHomeSearchTextProvider = StateProvider((ref) => '');

final employeeHomeStatusSelectedProvider = StateProvider((ref) => 0);

final employeeHomeStatusSelectedLabelProvider = StateProvider((ref) => "All");

final employeeHomeProjectCategorySelectedProvider =
    StateProvider((ref) => "All");

final employeeHomeFutureFilteredList = FutureProvider<List<ReportModel>>((ref) {
  final filteredReports = ref.watch(employeeHomeFilteringReport);
  return Future.value(filteredReports);
});

final employeeHomeFilteringReport = StateProvider<List<ReportModel>>((ref) {
  final rawReports = ref.watch(reportControllerProvider).asData?.value;
  // final searchText = ref.watch(employeeHomeSearchTextProvider);

  // final statusSelectedItem = ref.watch(employeeHomeStatusSelectedProvider);
  // final reportStatus = ref.watch(reportStatusControllerProvider);

  // final projectCategorySelected =
  //     ref.watch(employeeHomeProjectCategorySelectedProvider);

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
