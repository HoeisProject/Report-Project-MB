import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';

final createReportProjectCreatedProvider =
    StateProvider.autoDispose<DateTime?>((ref) {
  return null;
});

final createReportLocationAddressProvider =
    StateProvider.autoDispose<String>((ref) {
  return 'Getting location';
});

final createReportListMediaPickerFileProvider =
    StateProvider.autoDispose<List<Media>>((ref) {
  return [];
});
