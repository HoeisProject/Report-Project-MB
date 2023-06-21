import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final createReportProjectCategorySelectedProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

final createReportProjectCreatedProvider =
    StateProvider.autoDispose<DateTime?>((ref) {
  return null;
});

final createReportPositionProvider = StateProvider.autoDispose<String>((ref) {
  return 'Getting location';
});

final createReportListMediaPickerFileProvider =
    StateProvider.autoDispose<List<XFile>>((ref) {
  return [];
});
