import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/employee/controllers/report_controller.dart';

final employeeHomeSearchTextProvider = StateProvider((ref) => '');

final employeeHomeStatusSelectedProvider = StateProvider((ref) => -1);

final employeeHomeFutureFilteredList = FutureProvider<List<ReportModel>>((ref) {
  final filteredReports = ref.watch(employeeHomeFilteringReport);
  return Future.value(filteredReports);
});

final employeeHomeFilteringReport = StateProvider<List<ReportModel>>((ref) {
  final rawReports = ref.watch(reportControllerProvider).value;
  final searchText = ref.watch(employeeHomeSearchTextProvider);
  final statusSelectedItem = ref.watch(employeeHomeStatusSelectedProvider);

  List<ReportModel>? filteredReports = rawReports;

  if (statusSelectedItem != -1) {
    filteredReports = filteredReports
        ?.where((reportModel) => reportModel.status == statusSelectedItem)
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
