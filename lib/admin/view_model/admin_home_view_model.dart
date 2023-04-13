import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/controller/report_status_controller.dart';

final adminHomeSearchTextProvider = StateProvider((ref) => '');

final adminHomeStatusSelectedProvider = StateProvider((ref) => -1);

final adminHomeFutureFilteredList = FutureProvider<List<ReportModel>>((ref) {
  final filteredReports = ref.watch(adminHomeFilteringReport);
  return Future.value(filteredReports);
});

final adminHomeFilteringReport = StateProvider<List<ReportModel>>((ref) {
  final rawReports = ref.watch(adminReportControllerProvider).value;
  final searchText = ref.watch(adminHomeSearchTextProvider);
  final statusSelectedItem = ref.watch(adminHomeStatusSelectedProvider);
  final reportStatus = ref.read(reportStatusControllerProvider);

  List<ReportModel>? filteredReports = rawReports;

  if (statusSelectedItem != -1) {
    filteredReports = filteredReports
        ?.where((reportModel) =>
            reportModel.reportStatusId == reportStatus[statusSelectedItem].id)
        .toList();
  }
  if (searchText != '') {
    filteredReports = rawReports
        ?.where((reportModel) =>
            reportModel.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  return filteredReports!;
});
