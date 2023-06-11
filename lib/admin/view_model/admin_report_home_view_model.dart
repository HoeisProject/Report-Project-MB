import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminReportHomeProjectCategorySelectedProvider =
    StateProvider<String>((ref) {
  return '';
});

final adminHomeShowOnlyRejectedSwitch = StateProvider((ref) => false);
