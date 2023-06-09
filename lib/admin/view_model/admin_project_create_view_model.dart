import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminProjectCreateInternetDateProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

final adminProjectCreateStartDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);

final adminProjectCreateEndDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);

final adminProjectCreateIsLoadingProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final adminProjectCreateTimeSpanSelected = StateProvider<String>((ref) {
  return '';
});

final adminProjectCreateMoneyEstimateSelected = StateProvider<String>((ref) {
  return '';
});

final adminProjectCreateManpowerSelected = StateProvider<String>((ref) {
  return '';
});

final adminProjectCreateMaterialFeasibilitySelected =
    StateProvider<String>((ref) {
  return '';
});
