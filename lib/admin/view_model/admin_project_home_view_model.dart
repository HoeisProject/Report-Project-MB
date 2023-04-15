import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminProjectHomeStartDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);

final adminProjectHomeEndDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);
